import 'package:flutter/material.dart';
import 'package:trustfund_app/styles/colors.dart';

class ClaimScreen extends StatelessWidget {
  const ClaimScreen({super.key});

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
        title: const Text('Claims'),
        centerTitle: true,
      ),
      body: SizedBox(
        child: Center(
          child: Center(
            child: Text(
              'No Claims Available',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
