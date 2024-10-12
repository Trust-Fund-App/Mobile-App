import 'package:flutter/material.dart';
import 'package:trustfund_app/screen/tab/goalsave_records.dart';
import 'package:trustfund_app/screen/tab/saveflex_records.dart';
import 'package:trustfund_app/screen/tab/securesave_records.dart';
import 'package:trustfund_app/styles/colors.dart';

class SavingsScreen extends StatelessWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          title: const Text('Savings Plan'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TabBar(
              padding: const EdgeInsets.only(top: 25),
              labelStyle: TextStyle(
                color: AppColor.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(
                  text: 'SaveFlex',
                ),
                Tab(
                  text: 'SecureSave',
                ),
                Tab(
                  text: 'GoalSave',
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(children: [
                SaveFlexRecords(),
                SecureSaveRecords(),
                GoalSaveRecords(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
