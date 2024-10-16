import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustfund_app/provider/connect_logic_provider.dart';
import 'package:trustfund_app/screen/bottom_nav.dart';
import 'package:trustfund_app/screen/signup_login_screen.dart';
import 'package:trustfund_app/screen/splash_screen.dart';

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
    final connectProvider =
        Provider.of<ConnectLogicProvider>(context, listen: false);
    connectProvider.init();
    connectProvider.refreshConnectedAccounts();
    // connectProvider.getTokens();
    // Provider.of<ReadcontractService>(context, listen: false)
    //     .readSavingsPlansContract(
    //         connectProvider.connectedAccounts[0].publicAddress);

    account = connectProvider.connectedAccounts.isNotEmpty;
    initialization();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   Provider.of<ConnectLogicProvider>(context, listen: false).init();
  //   Provider.of<ConnectLogicProvider>(context, listen: false)
  //       .refreshConnectedAccounts();
  //   Provider.of<ReadcontractService>(context, listen: false).savingsPlans;
  //   account = Provider.of<ConnectLogicProvider>(context, listen: false)
  //       .connectedAccounts
  //       .isNotEmpty;
  //   initialization();
  // }

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
                if (snapshot.hasData &&
                    logic.connectedAccounts.isNotEmpty &&
                    snapshot.connectionState == ConnectionState.done) {
                  return const BottomNav();
                } else if (snapshot.hasData &&
                    logic.connectedAccounts.isEmpty &&
                    snapshot.connectionState == ConnectionState.done) {
                  return const SignupLoginScreen();
                } else {
                  return const SplashScreen();
                }
              },
            );
          }),
    );
  }
}
