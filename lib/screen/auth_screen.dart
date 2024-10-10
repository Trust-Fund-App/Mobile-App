import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustfund_app/provider/connect_logic_provider.dart';
import 'package:trustfund_app/screen/bottom_nav.dart';
import 'package:trustfund_app/screen/signup_login_screen.dart';
import 'package:trustfund_app/screen/splash_screen.dart';
import 'package:trustfund_app/utils/readcontract_service.dart';

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

    Provider.of<ReadcontractService>(context, listen: false).savingsPlans;
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
                  return const BottomNav();
                } else if (snapshot.hasData &&
                    logic.connectedAccounts.isEmpty) {
                  return const SignupLoginScreen();
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Check Networks'));
                } else {
                  return const SplashScreen();
                }
              },
            );
          }),
    );
  }
}
