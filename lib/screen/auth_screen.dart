import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:trustfund_app/provider/connect_logic_provider.dart';
import 'package:trustfund_app/screen/home_screen.dart';
import 'package:trustfund_app/screen/signup_login_screen.dart';
import 'package:trustfund_app/styles/colors.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late bool account;
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectLogicProvider>(context, listen: false).init();
    Provider.of<ConnectLogicProvider>(context, listen: false)
        .refreshConnectedAccounts();
    account = Provider.of<ConnectLogicProvider>(context, listen: false)
        .connectedAccounts
        .isNotEmpty;
    initialization();
  }

  Future<bool> initialization() async {
    await Future.delayed(const Duration(seconds: 5));
    return account;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
          future: initialization(),
          builder: (context, snapshot) {
            return Consumer<ConnectLogicProvider>(
              builder: (context, logic, child) {
                if (snapshot.hasData && logic.connectedAccounts.isNotEmpty) {
                  return const HomeScreen();
                } else if (snapshot.hasData &&
                    logic.connectedAccounts.isEmpty) {
                  return const SignupLoginScreen();
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Check Networks'));
                } else {
                  return Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SpinKitWave(
                        color: AppColor.primaryColor,
                        size: 40.0,
                      ),
                      const SizedBox(height: 15),
                      AnimatedTextKit(
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            speed: const Duration(milliseconds: 80),
                            'Savings Made Simple And Secure',
                            // 'Connect Your Web3 Wallet',
                            textStyle: const TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w500),
                          ),
                          // TypewriterAnimatedText(
                          //   speed: const Duration(milliseconds: 75),
                          //   'Pay in Local Currency',
                          //   textStyle: const TextStyle(
                          //       fontSize: 22, fontWeight: FontWeight.w500),
                          // ),
                          // TypewriterAnimatedText(
                          //   speed: const Duration(milliseconds: 75),
                          //   'Anytime, Anywhere',
                          //   textStyle: const TextStyle(
                          //       fontSize: 22, fontWeight: FontWeight.w500),
                          // ),
                        ],
                      ),
                    ],
                  ));
                }
              },
            );
          }),
    );
  }
}
