import 'package:flutter/material.dart';
import 'package:trustfund_app/screen/add_saveflex.dart';
import 'package:trustfund_app/styles/colors.dart';
import 'package:trustfund_app/widgets/soon_alert.dart';

class SaveFundScreen extends StatefulWidget {
  const SaveFundScreen({super.key});

  @override
  State<SaveFundScreen> createState() => _SaveFundScreenState();
}

class _SaveFundScreenState extends State<SaveFundScreen> {
  void infoDialog() {
    showDialog(
      context: context,
      builder: (_) => const CustomAlert(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: AppColor.black,
        foregroundColor: AppColor.white,
        title: const Text('Select A New Plan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            PlanCard(
              title: 'SaveFlex',
              description:
                  'Save daily, weekly, or monthly with complete flexibility over a specified time',
              color: Colors.purpleAccent.shade100,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddSaveFlex(),
                  ),
                );
              },
            ),
            PlanCard(
              title: 'SecureSave',
              description: 'Lock your funds for a set period and earn interest',
              color: Colors.redAccent.shade100,
              onTap: infoDialog,
            ),
            PlanCard(
              title: 'GoalSave',
              description:
                  'Create personalized savings goals for specific life events or spending purposes',
              color: Colors.blueAccent.shade100,
              onTap: infoDialog,
            ),
            PlanCard(
              title: 'P2PSave',
              description:
                  'A rotating savings collective where members contribute funds to support each other financially',
              color: Colors.yellowAccent.shade100,
              onTap: infoDialog,
            ),
          ],
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final Function()? onTap;
  const PlanCard({
    super.key,
    required this.title,
    required this.description,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(4.0, 4.0),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ],
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
                            fontSize: 20,
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
          ],
        ),
      ),
    );
  }
}
