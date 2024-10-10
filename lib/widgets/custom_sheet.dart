import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustfund_app/provider/connect_logic_provider.dart';
import 'package:trustfund_app/screen/bottom_nav.dart';
import 'package:trustfund_app/widgets/custom_button.dart';

class CusBottomSheet extends StatelessWidget {
  final String imageUrl;
  final Widget widget;

  const CusBottomSheet({
    super.key,
    required this.imageUrl,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            width: 40,
          ),
          const SizedBox(height: 20),
          widget,
          const SizedBox(height: 30),
          Consumer<ConnectLogicProvider>(
            builder: (context, logic, child) {
              return CustomButton(
                name: 'Close',
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const BottomNav(),
                  //   ),
                  // );
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNav()),
                      (route) => false);
                },
              );
            },
          )
        ],
      )),
    );
  }
}
