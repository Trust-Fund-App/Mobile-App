import 'package:flutter/material.dart';
import 'package:trustfund_app/styles/colors.dart';

class RoundButton extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function()? onTap;

  const RoundButton({
    super.key,
    required this.name,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Card(
            shadowColor: Colors.grey.withOpacity(0.6),
            elevation: 10.0,
            shape: const CircleBorder(),
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: AppColor.primaryColor,
              child: Icon(
                icon,
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
