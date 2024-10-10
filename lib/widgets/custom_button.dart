import 'package:flutter/material.dart';
import 'package:trustfund_app/styles/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap, required this.name});
  final String name;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColor.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 12),
      ),
      child: Text(
        name,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
