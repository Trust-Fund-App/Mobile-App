import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:particle_connect/model/account.dart';
import 'package:provider/provider.dart';
import 'package:timestamp_to_string/timestamp_to_string.dart';
import 'package:trustfund_app/provider/connect_logic_provider.dart';
import 'package:trustfund_app/screen/add_fund_screen.dart';
import 'package:trustfund_app/screen/loading_screen.dart';
import 'package:trustfund_app/screen/save_fund.dart';
import 'package:trustfund_app/screen/withdraw_screen.dart';
import 'package:trustfund_app/utils/readcontract_service.dart';
import 'package:trustfund_app/utils/smartcontract_service.dart';
import 'package:trustfund_app/utils/currency_api.dart';
import 'package:trustfund_app/styles/colors.dart';
import 'package:trustfund_app/widgets/round_button.dart';
import 'package:uuid/uuid.dart';

enum SavingsPlanType { flexSave, secureSave, goalSave }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<double> priceFeed;
  late String id;
  late List<Account> account;
  //late Future<List<dynamic>> savingsPlans;

  Uuid uuid = const Uuid();
  SmartcontractService smartcontractService = SmartcontractService();

  @override
  void initState() {
    super.initState();
    account = Provider.of<ConnectLogicProvider>(context, listen: false)
        .connectedAccounts;
    final provider = Provider.of<ReadcontractService>(context, listen: false);
    provider.readSavingsPlansContract(account[0].publicAddress);
    Provider.of<ConnectLogicProvider>(context, listen: false).getTokens();

    fetchPriceFeed();
    // getSavingsplans();
  }

  Future<double> fetchPriceFeed() async {
    await Future.delayed(const Duration(seconds: 5));
    return priceFeed;
  }

  // Future<List<dynamic>> getSavingsplans() async {
  //   //await Future.delayed(const Duration(seconds: 10));
  //   return savingsPlans;
  // }

  Uint8List uuidToBytes32(String uuid) {
    var uuidBytes = Uuid.parse(uuid);
    var bytes32 = Uint8List(32);
    bytes32.setRange(0, uuidBytes.length, uuidBytes);
    return bytes32;
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
    final provider = Provider.of<ReadcontractService>(context, listen: false);
    Provider.of<ConnectLogicProvider>(context, listen: false).getTokens();
    priceFeed = PriceFeed().getUSD();
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
      body: Consumer<ConnectLogicProvider>(
        builder: (context, logic, child) => FutureBuilder<double>(
          future: fetchPriceFeed(),
          builder: (context, snapshot) {
            if (snapshot.hasData && logic.connectedAccounts.isNotEmpty) {
              double nativeToken =
                  (int.parse(logic.tokens['native']) / 1000000000000000000);
              //  print('TestMe ${logic.tokens}');
              return SafeArea(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      //color: Colors.black,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 20),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                fontSize: 28,
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
                                  logic.currChainInfo.fullname,
                                  style: const TextStyle(color: Colors.white),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Amount Saved',
                                        style: TextStyle(color: Colors.white),
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
                                        child: const Center(
                                          child: Text(
                                            '\$ 3420.00',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
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
                                        style: TextStyle(color: Colors.white),
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
                                        child: const Center(
                                          child: Text(
                                            '100%',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
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

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     ElevatedButton(
                          //       onPressed: () async {
                          //         // await smartcontractService.evmSendNative(
                          //         //     logic.connectedAccounts.first.publicAddress);
                          //         id = uuid.v4();
                          //         await smartcontractService.writeContract(
                          //           wallet: parseWalletType(logic
                          //               .connectedAccounts.first.walletType),
                          //           publicAddress: logic.connectedAccounts
                          //               .first.publicAddress,
                          //           amount: BigInt.from(1000000000000000),
                          //           uuid: uuidToBytes32(id),
                          //           recipient: BigInt.from(0593456789),
                          //         );
                          //       },
                          //       child: const Text('Send to Contract'),
                          //     ),
                          //     ElevatedButton(
                          //       onPressed: () async {
                          //         logic.disconnect(
                          //             parseWalletType(
                          //               logic.connectedAccounts.first
                          //                   .walletType,
                          //             ),
                          //             logic.connectedAccounts.first
                          //                 .publicAddress);
                          //       },
                          //       child: const Text('Disconnect'),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.grey[100],
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const ClampingScrollPhysics(),
                            itemCount: provider.savingsPlans[0].length,
                            itemBuilder: (context, index) {
                              List savingsPlan =
                                  provider.savingsPlans[0][index];

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
                                      ) / 1000000000000000000).toStringAsFixed(4)} ETH',
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
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Network Error'),
              );
            } else {
              return const LoadScreen();

              // Center(
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       SpinKitFadingCircle(
              //         color: AppColor.primaryColor,
              //         size: 50.0,
              //       ),
              //       const SizedBox(height: 6),
              //       const Text(
              //         'Loading....',
              //         style: TextStyle(
              //           fontSize: 15,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //     ],
              //   ),
              // );
            }
          },
        ),
      ),
    );
  }
}
