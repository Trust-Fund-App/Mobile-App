import 'dart:async';

import 'package:flutter/material.dart';
import 'package:particle_connect/particle_connect.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:timestamp_to_string/timestamp_to_string.dart';
import 'package:trustfund_app/provider/connect_logic_provider.dart';
import 'package:trustfund_app/screen/loading_screen.dart';
import 'package:trustfund_app/styles/colors.dart';
import 'package:trustfund_app/provider/readcontract_service.dart';

enum SavingsPlanType { flexSave, secureSave, goalSave }

enum Frequency { single, daily, weekly, monthly }

class SavingsRecords extends StatefulWidget {
  const SavingsRecords({super.key});

  @override
  State<SavingsRecords> createState() => _SavingsRecordsState();
}

class _SavingsRecordsState extends State<SavingsRecords> {
  late List<Account> account;
  late List<dynamic> savingsPlans;

  @override
  void initState() {
    super.initState();
    account = Provider.of<ConnectLogicProvider>(context, listen: false)
        .connectedAccounts;
    final provider = Provider.of<ReadcontractService>(context, listen: false);
    provider.readSavingsPlansContract(account[0].publicAddress);
    savingsPlans =
        Provider.of<ReadcontractService>(context, listen: false).savingsPlans;
  }

  Future<List<dynamic>> getSavingsplans() async {
    await Future.delayed(const Duration(seconds: 5));
    return savingsPlans;
  }

  SavingsPlanType getSavingsPlanTypeFromUint8(int value) {
    switch (value) {
      case 0:
        return SavingsPlanType.flexSave;
      case 1:
        return SavingsPlanType.secureSave;
      case 2:
        return SavingsPlanType.goalSave;
      default:
        throw Exception('Unknown SavingsPlanType: $value');
    }
  }

  Frequency getFrequencyFromUint8(int value) {
    switch (value) {
      case 0:
        return Frequency.single;
      case 1:
        return Frequency.daily;
      case 2:
        return Frequency.weekly;
      case 3:
        return Frequency.monthly;
      default:
        throw Exception('Unknown Frequency: $value');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
      body: Consumer<ReadcontractService>(
        builder: (context, logic, child) {
          return FutureBuilder<List<dynamic>>(
            future: getSavingsplans(),
            builder: (context, snapshot) {
              if (snapshot.hasData & logic.savingsPlans.isEmpty) {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                        child: Container(
                      color: Colors.grey[100],
                      child: const Center(
                        child: Text(
                          'No Savings Plan Available',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                  ],
                );
              } else if (snapshot.hasData & logic.savingsPlans.isNotEmpty) {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                          //reverse: true,
                          itemCount: logic.savingsPlans[0].length,
                          itemBuilder: (context, index) {
                            List savingsPlan = logic.savingsPlans[0][index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 18),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 230,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Savings Plan Type',
                                              style: TextStyle(
                                                  color: Colors.grey[600]),
                                            ),
                                            Text(
                                              getSavingsPlanTypeFromUint8(
                                                int.parse(
                                                  savingsPlan[1].toString(),
                                                ),
                                              ).name,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Amount Saved',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            Text(
                                              '${(double.parse(
                                                    savingsPlan[8].toString(),
                                                  ) / 1000000000000000000).toStringAsFixed(4)} ETH',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),

                                        // TimestampToString.noFormater(
                                        //   savingsPlan[3].toString(),
                                        // ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Saving Frequency',
                                              style: TextStyle(
                                                  color: Colors.grey[600]),
                                            ),
                                            Text(
                                              getFrequencyFromUint8(
                                                int.parse(
                                                  savingsPlan[6].toString(),
                                                ),
                                              ).name,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Interest',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            Text(
                                              '${savingsPlan[4].toString()}%',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),

                                        // TimestampToString.noFormater(
                                        //   savingsPlan[3].toString(),
                                        // ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Start Date',
                                              style: TextStyle(
                                                  color: Colors.grey[600]),
                                            ),
                                            TimestampToString.dddmmmddyyyy(
                                              savingsPlan[2].toString(),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Maturity Date',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            TimestampToString.dddmmmddyyyy(
                                              savingsPlan[3].toString(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    StepProgressIndicator(
                                      totalSteps:
                                          int.parse(savingsPlan[3].toString()),
                                      currentStep: DateTime.now()
                                              .millisecondsSinceEpoch ~/
                                          1000,
                                      size: 8,
                                      padding: 0,
                                      selectedColor: Colors.yellow,
                                      unselectedColor: Colors.cyan,
                                      roundedEdges: const Radius.circular(10),
                                      selectedGradientColor:
                                          const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.yellowAccent,
                                          Colors.deepOrange
                                        ],
                                      ),
                                      unselectedGradientColor:
                                          const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Colors.black, Colors.blue],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              } else {
                return const LoadScreen();
              }
            },
          );
        },
      ),
    );
  }
}
