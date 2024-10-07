import 'package:flutter/material.dart';
import 'package:trustfund_app/styles/colors.dart';

class SaveFundScreen extends StatelessWidget {
  const SaveFundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColor.black,
        foregroundColor: AppColor.white,
        title: const Text('Create A New Plan'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          PlanCard(
            title: 'SaveFlex',
            description:
                'Save daily, weekly, or monthly with complete flexibility over a specified time',
            color: Colors.purple[200]!,
          ),
          PlanCard(
            title: 'SecureSave',
            description: 'Lock your funds for a set period and earn interest',
            color: Colors.red[200]!,
          ),
          PlanCard(
            title: 'GoalSave',
            description:
                'Create personalized savings goals for specific life events or spending purposes',
            color: Colors.blue[200]!,
          ),
        ],
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  const PlanCard({
    super.key,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 15,
                      //fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_forward_ios_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
