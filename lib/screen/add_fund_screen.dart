import 'package:flutter/material.dart';
import 'package:trustfund_app/screen/receive_wallet.dart';
import 'package:trustfund_app/styles/colors.dart';
import 'package:trustfund_app/widgets/soon_alert.dart';

class AddFundScreen extends StatefulWidget {
  const AddFundScreen({super.key});

  @override
  State<AddFundScreen> createState() => _AddFundScreenState();
}

class _AddFundScreenState extends State<AddFundScreen> {
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
        title: const Text('Add Fund'),
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
                'assets/images/vima.png',
                width: 30,
                height: 30,
              ),
              title: const Text(
                'Visa/Master Card',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
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
                Text('Or Add Funds From'),
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceiveWallet(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
