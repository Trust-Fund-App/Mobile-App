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
  late ConnectLogicProvider connectProvider;
  @override
  void initState() {
    super.initState();
    connectProvider = Provider.of<ConnectLogicProvider>(context, listen: false);
    connectProvider.init();
    connectProvider.refreshConnectedAccounts();
    account = connectProvider.connectedAccounts.isNotEmpty;
    initialization();
  }

  Future<bool> initialization() async {
    await Future.delayed(const Duration(seconds: 5));
    if (account == true) {
      await connectProvider.getTokens();
    }

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
