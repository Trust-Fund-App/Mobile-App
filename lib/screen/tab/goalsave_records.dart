import 'package:flutter/material.dart';

class GoalSaveRecords extends StatelessWidget {
  const GoalSaveRecords({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const SizedBox(
        child: Center(
          child: Text(
            'No GoalSave Records Available',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}