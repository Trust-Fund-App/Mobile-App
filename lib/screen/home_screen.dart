import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:particle_connect/particle_connect.dart';
import 'package:provider/provider.dart';
import 'package:trustfund_app/provider/connect_logic_provider.dart';
import 'package:trustfund_app/screen/loading_screen.dart';
import 'package:trustfund_app/utils/akoko_service.dart';
import 'package:trustfund_app/utils/currency_api.dart';
import 'package:trustfund_app/styles/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Account> account;
  late Future<double> priceFeed;
  late String id;

  Uuid uuid = const Uuid();

  AkokoService akokoService = AkokoService();

  @override
  void initState() {
    super.initState();
    // Provider.of<ConnectLogicProvider>(context, listen: false).init();
    // Provider.of<ConnectLogicProvider>(context, listen: false)
    //     .refreshConnectedAccounts();
    // Provider.of<ConnectLogicProvider>(context, listen: false).getTokens();
    // prefs();
    priceFeed = PriceFeed().getGHS();
    fetchPriceFeed();
  }

  Future<double> fetchPriceFeed() async {
    await Future.delayed(const Duration(seconds: 7));
    return priceFeed;
  }

  void prefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('home', true);
  }

  Uint8List uuidToBytes32(String uuid) {
    var uuidBytes = Uuid.parse(uuid);
    var bytes32 = Uint8List(32);
    bytes32.setRange(0, uuidBytes.length, uuidBytes);
    return bytes32;
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ConnectLogicProvider>(context, listen: false).getTokens();
    account = Provider.of<ConnectLogicProvider>(context, listen: false)
        .connectedAccounts;
    return Scaffold(
      backgroundColor: Colors.black,
      //backgroundColor: Colors.grey.shade300,
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      // ),
      body: Consumer<ConnectLogicProvider>(
        builder: (context, logic, child) => FutureBuilder<double>(
          future: fetchPriceFeed(),
          builder: (context, snapshot) {
            if (snapshot.hasData && logic.connectedAccounts.isNotEmpty) {
              double nativeToken =
                  (int.parse(logic.tokens['native']) / 1000000000000000000);
              print('TestMe ${logic.tokens}');
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        //color: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 30.0,
                                  height: 30.0,
                                  child: ClipOval(
                                    child:
                                        logic.connectedAccounts.first
                                                        .icons !=
                                                    null &&
                                                logic.connectedAccounts.first
                                                    .icons!.isNotEmpty &&
                                                parseWalletType(logic
                                                        .connectedAccounts
                                                        .first
                                                        .walletType) !=
                                                    WalletType.authCore
                                            ? Image.network(
                                                logic.connectedAccounts.first
                                                        .icons!.firstOrNull ??
                                                    '',
                                                fit: BoxFit.fill,
                                              )
                                            : logic.connectedAccounts.first
                                                            .icons !=
                                                        null &&
                                                    logic
                                                        .connectedAccounts
                                                        .first
                                                        .icons!
                                                        .isNotEmpty &&
                                                    parseWalletType(logic
                                                            .connectedAccounts
                                                            .first
                                                            .walletType) ==
                                                        WalletType.authCore
                                                ? Image.asset(
                                                    'assets/images/round_logo.png',
                                                    fit: BoxFit.cover,
                                                  )
                                                : const SizedBox.shrink(),
                                  ),
                                ),
                                // const Center(
                                //   child: Text(
                                //     'Trust Fund',
                                //     style: TextStyle(
                                //         color: Colors.white,
                                //         fontSize: 22,
                                //         fontWeight: FontWeight.w600),
                                //   ),
                                // ),
                                Image.network(
                                  logic.currChainInfo.icon,
                                  height: 30,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
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
                                    nativeToken.toString(),
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
                            const SizedBox(height: 10),
                            Center(
                              child: Text(
                                logic.connectedAccounts.first.publicAddress,
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
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
                                              '\$ 3000.00',
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
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                // await akokoService.evmSendNative(
                                //     logic.connectedAccounts.first.publicAddress);
                                id = uuid.v4();
                                await akokoService.writeContract(
                                  wallet: parseWalletType(
                                      logic.connectedAccounts.first.walletType),
                                  publicAddress: logic
                                      .connectedAccounts.first.publicAddress,
                                  amount: BigInt.from(1000000000000000),
                                  uuid: uuidToBytes32(id),
                                  recipient: BigInt.from(0593456789),
                                );
                              },
                              child: const Text('Send to Contract'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                logic.disconnect(
                                    parseWalletType(
                                      logic.connectedAccounts.first.walletType,
                                    ),
                                    logic
                                        .connectedAccounts.first.publicAddress);
                              },
                              child: const Text('Disconnect'),
                            ),
                          ],
                        ),
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
