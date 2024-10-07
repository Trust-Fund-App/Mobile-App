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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        backgroundColor: AppColor.black,
        foregroundColor: AppColor.white,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Consumer<ConnectLogicProvider>(
            builder: (context, logic, chhild) {
              return Column(
                children: [
                  CustListTile(
                    title: 'Preferences',
                    icon: Icons.extension,
                    color: Colors.green,
                    onTap: () {},
                  ),
                  CustListTile(
                    title: 'Security',
                    icon: Icons.security,
                    color: Colors.deepOrange,
                    onTap: () {},
                  ),
                  CustListTile(
                    title: 'About & Help',
                    icon: Icons.help,
                    color: Colors.blue,
                    onTap: () {},
                  ),
                  CustListTile(
                    title: 'Join Community',
                    icon: Icons.people,
                    color: Colors.deepPurple,
                    onTap: () {},
                  ),
                  CustListTile(
                    title: 'Share App',
                    icon: Icons.share,
                    color: Colors.pink,
                    onTap: () {},
                  ),
                  const SizedBox(height: 50),
                  CustListTile(
                    title: 'Disconnect Account',
                    icon: Icons.logout,
                    color: AppColor.red,
                    onTap: () {
                      logic.disconnect(
                          parseWalletType(
                            logic.connectedAccounts[0].walletType,
                          ),
                          logic.connectedAccounts[0].publicAddress);
                    },
                  ),
                ],
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

class CustListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Function()? onTap;
  const CustListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          iconColor: color,
          leading: ClipOval(
            child: Container(
              color: Colors.grey[300],
              height: 45,
              width: 45,
              child: Icon(
                size: 20,
                icon,
              ),
            ),
          ),
          title: Text(title),
          trailing: const Icon(Icons.navigate_next),
          style: ListTileStyle.drawer,
          onTap: onTap,
        ),
      ),
    );
  }
}
