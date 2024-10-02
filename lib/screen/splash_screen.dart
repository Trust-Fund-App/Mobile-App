import 'package:flutter/material.dart';
import 'package:trustfund_app/styles/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: AppColor.primaryColor,
                child: Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/text_logo.png',
                        fit: BoxFit.contain,
                        width: 250,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
