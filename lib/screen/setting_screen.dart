import 'package:flutter/material.dart';
import 'package:particle_connect/model/wallet_type.dart';
import 'package:particle_connect/particle_connect.dart';
import 'package:provider/provider.dart';
import 'package:trustfund_app/provider/connect_logic_provider.dart';
import 'package:trustfund_app/styles/colors.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.white,
        //  backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<ConnectLogicProvider>(
            builder: (context, logic, chhild) {
              return ListTile(
                iconColor: AppColor.red,
                leading: const Icon(Icons.logout),
                title: const Text('Disconnect Account'),
                trailing: const Icon(Icons.navigate_next),
                style: ListTileStyle.drawer,
                onTap: () {
                  logic.disconnect(
                      parseWalletType(
                        logic.connectedAccounts[0].walletType,
                      ),
                      logic.connectedAccounts[0].publicAddress);
                },
              );
            },
          ),
          // ListTile(
          //   iconColor: AppColor.primaryColor,
          //   leading: const Icon(Icons.dark_mode),
          //   title: const Text('Dark Mode'),
          //   trailing: CupertinoSwitch(
          //     value:
          //         Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
          //     onChanged: (value) =>
          //         Provider.of<ThemeProvider>(context, listen: false)
          //             .toggleTheme(),
          //   ),
          //   style: ListTileStyle.drawer,
          // ),
        ],
      ),
    );
  }
}
