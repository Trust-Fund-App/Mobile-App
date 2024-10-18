import 'package:flutter/material.dart';

class InternetConnection extends StatelessWidget {
  const InternetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 6),
          Text(
            'Check Internet Connection',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ));
  }
}
