import 'package:flutter/material.dart';
import 'package:trustfund_app/styles/colors.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        backgroundColor: AppColor.black,
        foregroundColor: AppColor.white,
        title: const Text('Rewards'),
        centerTitle: true,
      ),
    );
  }
}
