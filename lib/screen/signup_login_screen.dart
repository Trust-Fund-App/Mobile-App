import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustfund_app/provider/connect_logic_provider.dart';
import 'package:trustfund_app/styles/colors.dart';

class SignupLoginScreen extends StatefulWidget {
  const SignupLoginScreen({super.key});

  @override
  State<SignupLoginScreen> createState() => _SignupLoginScreenState();
}

class _SignupLoginScreenState extends State<SignupLoginScreen> {
  late bool isConnect;

  @override
  void initState() {
    super.initState();
    // Provider.of<ConnectLogicProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //     // Status bar color
        //     //statusBarColor: AppColor.primaryColor,
        //     ),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Trust Fund',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  'Your Financial Fredom',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[300]),
                ),
              ],
            ),
          ),
          // const Expanded(child: Spacer()),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Theme.of(context).colorScheme.surface,
              ),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(height: 10),
                Text(
                  "",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                const SizedBox(height: 25),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                Consumer<ConnectLogicProvider>(
                  builder: (context, logic, child) {
                    return ElevatedButton.icon(
                      icon: const Icon(Icons.account_balance_wallet),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 40),
                          foregroundColor: Colors.white,
                          backgroundColor: AppColor.primaryColor),
                      onPressed: () {
                        logic.connectWithConnectKit();
                        //navigate();
                      },
                      label: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Connect with Email or Wallet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                //const SizedBox(height: 10),
              ]),
            ),
          ),
          // Container(
          //   height: 30,
          //   color: Colors.white,
          // ),
        ],
      ),
    );
  }

  // Future<void> navigate() async {
  //   for (int i = 0; i < 240; i++) {
  //     await Future.delayed(
  //       const Duration(seconds: 1),
  //       () {
  //         setState(() {
  //           isConnect =
  //               Provider.of<ConnectLogicProvider>(context, listen: false)
  //                   .connectedAccounts
  //                   .isNotEmpty;
  //         });
  //         if (isConnect) {
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => const HomeScreen(),
  //             ),
  //           );
  //         }
  //       },
  //     );

  //     if (isConnect) return;
  //   }
  // }
}
