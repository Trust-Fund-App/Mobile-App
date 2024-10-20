import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timestamp_to_string/timestamp_to_string.dart';
import 'package:trustfund_app/provider/connect_logic_provider.dart';
import 'package:trustfund_app/screen/add_fund_screen.dart';
import 'package:trustfund_app/widgets/internet_connection.dart';
import 'package:trustfund_app/widgets/load_widget.dart';
import 'package:trustfund_app/screen/save_fund.dart';
import 'package:trustfund_app/screen/withdraw_screen.dart';
import 'package:trustfund_app/provider/readcontract_service.dart';
import 'package:trustfund_app/utils/currency_api.dart';
import 'package:trustfund_app/styles/colors.dart';
import 'package:trustfund_app/widgets/round_button.dart';

enum SavingsPlanType { flexSave, secureSave, goalSave }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<double> priceFeed;
  late Timer _timer;
  late String account;
  late ConnectLogicProvider connectLogic;
  late ReadcontractService readContract;

  @override
  void initState() {
    super.initState();
    connectLogic = Provider.of<ConnectLogicProvider>(context, listen: false);
    readContract = Provider.of<ReadcontractService>(context, listen: false);

    account = connectLogic.connectedAccounts[0].publicAddress;
    readContract.readTotalSavingsContract(account);
    readContract.readCreditScoreContract(account);
    readContract.readSavingsPlansContract(account);
    connectLogic.getTokens();
    priceFeed = PriceFeed().getUSD();
    fetchPriceFeed();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchPriceFeed();
    });
  }

  Future<double> fetchPriceFeed() async {
    await Future.delayed(const Duration(seconds: 5));
    connectLogic.getTokens();
    return priceFeed;
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      connectLogic.getTokens();
      // Provider.of<ConnectLogicProvider>(context, listen: false).getTokens();
    });
  }

  // Future<List<dynamic>> getSavingsplans() async {
  //   await Future.delayed(const Duration(seconds: 10));
  //   return savingsPlans;
  // }

  // Uint8List uuidToBytes32(String uuid) {
  //   var uuidBytes = Uuid.parse(uuid);
  //   var bytes32 = Uint8List(32);
  //   bytes32.setRange(0, uuidBytes.length, uuidBytes);
  //   return bytes32;
  // }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  SavingsPlanType getSavingsPlanTypeFromUint8(int value) {
    switch (value) {
      case 0:
        return SavingsPlanType.flexSave;
      case 1:
        return SavingsPlanType.secureSave;
      case 2:
        return SavingsPlanType.goalSave;
      default:
        throw Exception('Unknown SavingsPlanType: $value');
    }
  }

  @override
  Widget build(BuildContext context) {
    final rContractprovider =
        Provider.of<ReadcontractService>(context, listen: false);
    final connectProvider =
        Provider.of<ConnectLogicProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      //backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.black,
        leading: IconButton(
          iconSize: 26,
          onPressed: () {},
          icon: const Icon(Icons.apps),
        ),
        actions: [
          IconButton(
            iconSize: 26,
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: FutureBuilder<double>(
        future: fetchPriceFeed(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            double nativeToken = (int.parse(connectProvider.tokens['native']) /
                1000000000000000000);
            String totalAmount =
                (double.parse(rContractprovider.totalSavings.last.toString()) /
                        1000000000000000000)
                    .toStringAsFixed(4);
            //  print('TestMe ${logic.tokens}');
            return SafeArea(
              child: RefreshIndicator(
                onRefresh: () {
                  return _refreshData();
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          //color: Colors.black,
                          margin: const EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // SizedBox(
                                  //   width: 30.0,
                                  //   height: 30.0,
                                  //   child: ClipOval(
                                  //     child: logic.connectedAccounts[0].icons !=
                                  //                 null &&
                                  //             logic.connectedAccounts[0].icons!
                                  //                 .isNotEmpty &&
                                  //             parseWalletType(logic
                                  //                     .connectedAccounts[0]
                                  //                     .walletType) !=
                                  //                 WalletType.authCore
                                  //         ? Image.network(
                                  //             logic.connectedAccounts[0].icons!
                                  //                     .firstOrNull ??
                                  //                 '',
                                  //             fit: BoxFit.fill,
                                  //           )
                                  //         : logic.connectedAccounts[0].icons !=
                                  //                     null &&
                                  //                 logic.connectedAccounts.first
                                  //                     .icons!.isNotEmpty &&
                                  //                 parseWalletType(logic
                                  //                         .connectedAccounts[0]
                                  //                         .walletType) ==
                                  //                     WalletType.authCore
                                  //             ? Image.asset(
                                  //                 'assets/images/round_logo.png',
                                  //                 fit: BoxFit.cover,
                                  //               )
                                  //             : const SizedBox.shrink(),
                                  //   ),
                                  // ),

                                  // const Center(
                                  //   child: Text(
                                  //     'Trust Fund',
                                  //     style: TextStyle(
                                  //         color: Colors.white,
                                  //         fontSize: 22,
                                  //         fontWeight: FontWeight.w600),
                                  //   ),
                                  // ),
                                  // Image.network(
                                  //   logic.currChainInfo.icon,
                                  //   height: 30,
                                  // ),
                                ],
                              ),
                              // const SizedBox(height: 10),
                              Center(
                                child: Text(
                                  '\$${((snapshot.data ?? 0) * double.parse(nativeToken.toString())).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      nativeToken.toStringAsFixed(5),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      connectProvider.currChainInfo.fullname,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                              // Center(
                              //   child: Text(
                              //     logic.connectedAccounts.first.publicAddress,
                              //     style: TextStyle(
                              //       color: Colors.grey[300],
                              //       fontSize: 12,
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          const Text(
                                            'Amount Saved',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 40,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: AppColor.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '$totalAmount ${connectProvider.currChainInfo.nativeCurrency.symbol}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 20),
                                      SizedBox(
                                        height: 70,
                                        child: VerticalDivider(
                                          color: AppColor.primaryColor,
                                          thickness: 2,
                                          width: 15,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        children: [
                                          const Text(
                                            'Credit Score',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 40,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: AppColor.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                              child: rContractprovider
                                                          .savingsPlans[0]
                                                          .length <
                                                      1
                                                  ? const Text(
                                                      '0%',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )
                                                  : Text(
                                                      '${rContractprovider.creditScore[0].toString()}%',
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.grey[100],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RoundButton(
                                icon: Icons.account_balance,
                                name: 'Add Fund',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AddFundScreen(),
                                    ),
                                  );
                                },
                              ),
                              RoundButton(
                                icon: Icons.currency_exchange_outlined,
                                name: 'Save Fund',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SaveFundScreen(),
                                    ),
                                  );
                                },
                              ),
                              RoundButton(
                                icon: Icons.send_to_mobile,
                                name: 'Withdraw',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const WithdrawScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 20,
                                          left: 20,
                                          bottom: 10,
                                        ),
                                        child: Text(
                                          'Transactions',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              //  const SizedBox(height: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: rContractprovider.savingsPlans[0].isEmpty
                          ? Container(
                              color: Colors.grey[100],
                              child: Center(
                                child: Text(
                                  'No Transactions Available',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : Container(
                              color: Colors.grey[100],
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      rContractprovider.savingsPlans[0].length,
                                  itemBuilder: (context, index) {
                                    List savingsPlans =
                                        rContractprovider.savingsPlans.last;
                                    List savingsPlansReversed =
                                        savingsPlans.reversed.toList();
                                    List savingsPlan =
                                        savingsPlansReversed[index];
                                    return ListTile(
                                      leading: Container(
                                        height: 45,
                                        width: 45,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.south_east_outlined,
                                          color: Colors.green,
                                        ),
                                      ),
                                      title: Text(
                                        getSavingsPlanTypeFromUint8(
                                          int.parse(
                                            savingsPlan[1].toString(),
                                          ),
                                        ).name,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: TimestampToString.dddmmmddyyyy(
                                        savingsPlan[9].toString(),
                                      ),
                                      trailing: Text(
                                        '${(double.parse(
                                              savingsPlan[8].toString(),
                                            ) / 1000000000000000000).toStringAsFixed(4)} ${connectProvider.currChainInfo.nativeCurrency.symbol}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    );

                                    //     return null;
                                  }),
                            ),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const InternetConnection();
          } else {
            return const LoadScreen();
          }
        },
      ),
    );
  }
}
