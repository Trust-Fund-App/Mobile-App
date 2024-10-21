import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:particle_connect/model/wallet_type.dart';
import 'package:particle_connect/particle_connect.dart';
import 'package:provider/provider.dart';
import 'package:trustfund_app/provider/connect_logic_provider.dart';
import 'package:trustfund_app/styles/colors.dart';
import 'package:trustfund_app/provider/readcontract_service.dart';
import 'package:trustfund_app/utils/smartcontract_service.dart';
import 'package:trustfund_app/utils/currency_api.dart';
import 'package:trustfund_app/widgets/custom_button.dart';
import 'package:trustfund_app/widgets/custom_sheet.dart';
import 'package:trustfund_app/widgets/custom_textfield.dart';
import 'package:trustfund_app/widgets/payment_info.dart';
import 'package:url_launcher/url_launcher.dart';

enum SavingsPlanType { flexSave, secureSave, goalSave }

enum Frequency { single, daily, weekly, monthly }

class CreateSecureSave extends StatefulWidget {
  const CreateSecureSave({super.key});

  @override
  State<CreateSecureSave> createState() => _CreateSecureSaveState();
}

class _CreateSecureSaveState extends State<CreateSecureSave> {
  final TextEditingController _amount = TextEditingController();
  final TextEditingController recipient = TextEditingController();
  late ConnectLogicProvider logicProvider;
  late Future<dynamic> priceFeed;
  late String id;
  late Timer _timer;

  String amount = '0';
  double gweiAmount = 0.0;
  double ethPrice = 0.0;
  String ethConversion = '0';
  bool loading = false;
  bool isListerning = true;
  String? _dropdownDuration;
  late List<dynamic> savingsPlans;
  final _formKey = GlobalKey<FormState>();
  SmartcontractService smartcontractService = SmartcontractService();

  @override
  void initState() {
    fetchPriceData();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchPriceData();
    });
    priceFeed = PriceFeed().getUSD();
    savingsPlans =
        Provider.of<ReadcontractService>(context, listen: false).savingsPlans;
    _amount.addListener(() {
      setState(() {
        amount = _amount.text;
        if (amount.isNotEmpty) {
          gweiAmount = (int.parse(amount) * 10000000000) / ethPrice;
          ethConversion = (double.parse(amount) / ethPrice).toStringAsFixed(5);
        }
      });
    });
    super.initState();
  }

  Future<List<dynamic>> getSavingsplans() async {
    await Future.delayed(const Duration(seconds: 5));
    return savingsPlans;
  }

  // Convert Dart enum to the corresponding uint8 value
  int getSavingsPlanTypeValue(SavingsPlanType type) {
    return type.index; // Dart enum index will match Solidity's uint8
  }

  int getFrequencyValue(Frequency frequency) {
    return frequency.index; // Dart enum index will match Solidity's uint8
  }

  @override
  void dispose() {
    super.dispose();
    _amount.dispose();
    recipient.dispose();
    _timer.cancel();
  }

  void dropdownDuration(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownDuration = selectedValue;
      });
    }
  }

  Future<dynamic> fetchPriceData() async {
    await Future.delayed(const Duration(seconds: 3));
    return priceFeed;
  }

  @override
  Widget build(BuildContext context) {
    logicProvider = Provider.of<ConnectLogicProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColor.white,
        title: const Text('Create A SecureSave Plan'),
        centerTitle: true,
      ),
      body: Consumer<ConnectLogicProvider>(
        builder: (context, logic, child) {
          double nativeToken =
              (int.parse(logic.tokens['native']) / 1000000000000000000);
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'How long do you want to save?',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black),
                              ),
                              child: DropdownButton(
                                isExpanded: true,
                                hint:
                                    const Text('Select your savings duration'),
                                underline: const SizedBox(),
                                padding: const EdgeInsets.all(3),
                                style: const TextStyle(color: Colors.black),
                                dropdownColor: Colors.white,
                                items: const [
                                  DropdownMenuItem(
                                      value: '15552000',
                                      child: Text('6 Months')),
                                  DropdownMenuItem(
                                    value: '31536000',
                                    child: Text('12 Months'),
                                  ),
                                  DropdownMenuItem(
                                    value: '63072000',
                                    child: Text('24 Months'),
                                  ),
                                  DropdownMenuItem(
                                    value: '126144000',
                                    child: Text('48 Months'),
                                  ),
                                ],
                                elevation: 15,
                                value: _dropdownDuration,
                                onChanged: dropdownDuration,
                                iconSize: 42,
                                iconEnabledColor: AppColor.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'How much do you want to save?',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: _amount,
                              hintText: "Amount in USD",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the Amount';
                                } else if (int.parse(value) < 1) {
                                  return 'Please the amount should be greater than  5 USD';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                const Expanded(child: Divider()),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: FutureBuilder<dynamic>(
                                      future: fetchPriceData(),
                                      builder: (context, snapshot) {
                                        ethPrice = snapshot.data ?? 0;
                                        if (snapshot.hasData) {
                                          return Text(
                                              "USD $amount = $ethConversion ${logic.currChainInfo.nativeCurrency.symbol} ");
                                        } else if (snapshot.hasError) {
                                          return const Text('Network Error');
                                        } else {
                                          return SpinKitCircle(
                                            color: AppColor.primaryColor,
                                            size: 20.0,
                                          );
                                        }
                                      }),
                                ),
                                const Expanded(child: Divider()),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          PaymentInfo(
                            topic:
                                'Amount Deposit in ${logic.currChainInfo.nativeCurrency.symbol}',
                            name:
                                '$ethConversion ${logic.currChainInfo.nativeCurrency.symbol}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      CustomButton(
                        name: loading ? 'Loading...' : 'Create Now',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            if (double.parse(ethConversion) <= nativeToken) {
                              setState(() {
                                loading = true;
                              });

                              // await smartcontractService.evmSendNative(
                              //   publicAddress:
                              //       logic.connectedAccounts[0].publicAddress,
                              //   wallet: parseWalletType(
                              //       logic.connectedAccounts[0].walletType),
                              //   amount: BigInt.from(
                              //     (gweiAmount * 100000000).round(),
                              //   ),
                              // );

                              await smartcontractService.secureSaveContract(
                                wallet: parseWalletType(
                                    logic.connectedAccounts[0].walletType),
                                publicAddress:
                                    logic.connectedAccounts[0].publicAddress,
                                amount: BigInt.from(
                                  (gweiAmount * 100000000).round(),
                                ),
                                // uuid: uuidToBytes32(id),
                                savingsPlanType: getSavingsPlanTypeValue(
                                    SavingsPlanType.secureSave),
                                duration:
                                    BigInt.from(int.parse(_dropdownDuration!)),
                              );

                              // ignore: use_build_context_synchronously
                              customBottomSheet(context);
                            } else {
                              return 'Insufficient Fund';
                            }
                          }
                        },
                      ),
                      Visibility(
                        visible: loading,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            child: parseWalletType(logic
                                        .connectedAccounts[0].walletType) !=
                                    WalletType.authCore
                                ? const Text(
                                    'Open your wallet and approve payment',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  )
                                : const SizedBox.shrink()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> customBottomSheet(BuildContext context) {
    setState(() {
      loading = false;
    });
    return showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: StreamBuilder<String>(
            stream: fetchData(),
            builder: (context, txnsnapshot) {
              // print('Test7 ${smartcontractService.message}');

              if (txnsnapshot.hasData &&
                  smartcontractService.message.contains('User rejected')) {
                return const CusBottomSheet(
                  imageUrl: 'assets/images/cancel.png',
                  widget: Column(
                    children: [
                      Text(
                        'Payment Declined',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Try Again',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (txnsnapshot.hasData &&
                  smartcontractService.message.startsWith('0x')) {
                final Uri url = Uri.parse(
                    '${logicProvider.currChainInfo.blockExplorerUrl}/tx/${smartcontractService.message}');
                return FutureBuilder<List<dynamic>>(
                    future: getSavingsplans(),
                    builder: (context, confsnapshot) {
                      if (confsnapshot.hasData) {
                        isListerning = false;
                        return CusBottomSheet(
                          imageUrl: 'assets/images/sucess.png',
                          widget: Column(
                            children: [
                              const Text(
                                'Plan Created Successfully🎉',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Text(
                              //   'You have transfered GH₵$amount to ${recipient.text}',
                              //   style: const TextStyle(
                              //     fontSize: 15,
                              //   ),
                              // ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  launchUrl(url);
                                },
                                child: const Text(
                                  'View Transaction',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 2, 98, 177)),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return CusBottomSheet(
                          imageUrl: 'assets/images/wait.png',
                          widget: Column(
                            children: [
                              const Text(
                                'Waiting for Confirmation',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Confirmation in Progress...',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SpinKitCircle(
                                    color: AppColor.black,
                                    size: 25.0,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  launchUrl(url);
                                },
                                child: const Text(
                                  'View Transaction Status',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 2, 98, 177)),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    });
              } else {
                return const CusBottomSheet(
                  imageUrl: 'assets/images/wait.png',
                  widget: Text(
                    'Waiting for Approval....',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Stream<String> fetchData() async* {
    while (isListerning) {
      await Future.delayed(const Duration(seconds: 5));
      yield smartcontractService.message;
    }
  }
}
