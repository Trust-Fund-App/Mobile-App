import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:trustfund_app/screen/claim_screen.dart';
import 'package:trustfund_app/screen/home_screen.dart';
import 'package:trustfund_app/screen/rewardscreen.dart';
import 'package:trustfund_app/screen/setting_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void selectedTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> tabs = [
    const HomeScreen(),
    const ClaimScreen(),
    const RewardScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: currentIndex,
        children: tabs,
      ),
      bottomNavigationBar: StyleProvider(
        style: Style(),
        child: ConvexAppBar(
          style: TabStyle.react,
          height: 56,
          top: -16,
          elevation: 5,
          //shadowColor: Colors.grey[400],
          activeColor: Colors.black,
          color: Colors.grey[600],
          backgroundColor: Colors.white,
          initialActiveIndex: currentIndex,
          onTap: selectedTap,
          items: const [
            TabItem(
              icon: Icons.account_balance_wallet,
              title: 'Wallet',
            ),
            TabItem(
              icon: Icons.savings,
              title: 'Savings',
            ),
            TabItem(
              icon: Icons.wallet_giftcard,
              title: 'Rewards',
            ),
            TabItem(
              icon: Icons.settings,
              title: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 28;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 25;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(fontSize: 14, color: color, fontFamily: fontFamily);
  }
}
