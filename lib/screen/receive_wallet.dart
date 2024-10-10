import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trustfund_app/provider/connect_logic_provider.dart';
import 'package:trustfund_app/styles/colors.dart';
import 'package:trustfund_app/widgets/address_qr_wid.dart';

class ReceiveWallet extends StatefulWidget {
  const ReceiveWallet({super.key});

  @override
  State<ReceiveWallet> createState() => _ReceiveWalletState();
}

class _ReceiveWalletState extends State<ReceiveWallet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColor.black,
        foregroundColor: AppColor.white,
        title: const Text('Wallet or Exchange'),
        centerTitle: true,
      ),
      body: Consumer<ConnectLogicProvider>(
        builder: (context, logic, child) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Text(
                  'Send Only ${logic.currChainInfo.fullname} to this address',
                  style: TextStyle(
                    color: AppColor.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: AddressQrWid(
                    address: logic.connectedAccounts[0].publicAddress,
                    icon: logic.currChainInfo.icon,
                    name: logic.currChainInfo.fullname,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                    icon: const Icon(Icons.share),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 80),
                        foregroundColor: Colors.white,
                        backgroundColor: AppColor.primaryColor),
                    onPressed: () {
                      Share.share(
                          'Hi, send me some ${logic.currChainInfo.fullname} using my address ${logic.connectedAccounts[0].publicAddress}');
                    },
                    label: const Text(
                      'Share Address',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
