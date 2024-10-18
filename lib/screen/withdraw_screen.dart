import 'package:flutter/material.dart';
import 'package:trustfund_app/styles/colors.dart';
import 'package:trustfund_app/widgets/soon_alert.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  void infoDialog() {
    showDialog(
      context: context,
      builder: (_) => const CustomAlert(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColor.black,
        foregroundColor: AppColor.white,
        title: const Text('Withdraw Fund'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            ListTile(
              leading: Image.asset(
                'assets/images/mtn.png',
                width: 30,
                height: 30,
              ),
              title: const Text(
                'MTN Mobile Money',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: infoDialog,
            ),
            ListTile(
              leading: Image.asset(
                'assets/images/bank.png',
                width: 30,
                height: 30,
              ),
              title: const Text(
                'Bank Account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: infoDialog,
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(),
                  ),
                ),
                Text('Or Withdraw Funds To'),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: Image.asset(
                'assets/images/bw.png',
                width: 30,
                height: 30,
              ),
              title: const Text(
                'Wallet or Exchange',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: infoDialog,
            ),
          ],
        ),
      ),
    );
  }
}
