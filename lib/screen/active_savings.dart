import 'dart:async';

import 'package:flutter/material.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:trustfund_app/provider/connect_logic_provider.dart';
import 'package:trustfund_app/widgets/load_widget.dart';
import 'package:trustfund_app/screen/savings_plan_details.dart';
import 'package:trustfund_app/styles/colors.dart';
import 'package:trustfund_app/provider/readcontract_service.dart';

enum SavingsPlanType { flexSave, secureSave, goalSave }

enum Frequency { single, daily, weekly, monthly }

class ActiveSavings extends StatefulWidget {
  const ActiveSavings({super.key});

  @override
  State<ActiveSavings> createState() => _ActiveSavingsState();
}

class _ActiveSavingsState extends State<ActiveSavings> {
  late String account;
  late ReadcontractService rContractprovider;

  @override
  void initState() {
    super.initState();
    account = Provider.of<ConnectLogicProvider>(context, listen: false)
        .connectedAccounts[0]
        .publicAddress;
    rContractprovider =
        Provider.of<ReadcontractService>(context, listen: false);
    rContractprovider.readSavingsPlansContract(account);
  }

  Future<List<dynamic>> getSavingsplans() async {
    await Future.delayed(const Duration(seconds: 5));
    return rContractprovider.savingsPlans;
  }

  int timestampToDays(int timestamp) {
    // Convert the timestamp from seconds to a Duration
    Duration duration = Duration(seconds: timestamp);

    // Return the number of days
    return duration.inDays;
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
    final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
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
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done &&
                  logic.savingsPlans[0].isEmpty) {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                        child: Container(
                      color: Colors.grey[100],
                      child: Center(
                        child: Text(
                          'No Savings Plan Available',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                  ],
                );
              } else if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done &&
                  logic.savingsPlans[0].isNotEmpty) {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                          itemCount: logic.savingsPlans[0].length,
                          itemBuilder: (context, index) {
                            List savingsPlans = logic.savingsPlans.last;
                            List savingsPlansReversed =
                                savingsPlans.reversed.toList();
                            List savingsPlan = savingsPlansReversed[index];

                            final daysLeft = timestampToDays(
                              (int.parse(savingsPlan[3].toString())) -
                                  ((currentTime)),
                            );
                            List<Segment> segments = [
                              Segment(
                                value: timestampToDays(
                                        int.parse(savingsPlan[7].toString())) -
                                    daysLeft,
                                color: Colors.green,
                              ),
                            ];
                            final progressBar = PrimerProgressBar(
                              maxTotalValue: timestampToDays(
                                  int.parse(savingsPlan[7].toString())),
                              segments: segments,
                              showLegend: false,
                              barStyle: SegmentedBarStyle(
                                  backgroundColor: Colors.grey[300],
                                  size: 12,
                                  padding: const EdgeInsets.all(2)),
                            );
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 18),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SavingsPlanDetails(
                                        planId: savingsPlan[0].toString(),
                                        savingsPlan: savingsPlan[1].toString(),
                                        amount: savingsPlan[8].toString(),
                                        frequency: savingsPlan[6].toString(),
                                        interestRate: savingsPlan[4].toString(),
                                        startDate: savingsPlan[2].toString(),
                                        maturityDate: savingsPlan[3].toString(),
                                        duration: savingsPlan[7].toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  height: 170,
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                      (savingsPlan[8]
                                                          .toString()),
                                                    ) / 1000000000000000000).toStringAsFixed(4)} ETH',
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 3, 68, 121),
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Days Left',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              Text(
                                                '$daysLeft days',
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // Text(
                                              //   '${savingsPlan[4].toString()}%',
                                              //   style: const TextStyle(
                                              //       fontSize: 18,
                                              //       fontWeight:
                                              //           FontWeight.bold),
                                              // ),
                                            ],
                                          ),

                                          // TimestampToString.noFormater(
                                          //   savingsPlan[3].toString(),
                                          // ),
                                        ],
                                      ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Column(
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //       children: [
                                      //         Text(
                                      //           'Start Date',
                                      //           style: TextStyle(
                                      //               color: Colors.grey[600]),
                                      //         ),
                                      //         TimestampToString.dddmmmddyyyy(
                                      //           savingsPlan[2].toString(),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //     Column(
                                      //       children: [
                                      //         Text(
                                      //           'Maturity Date',
                                      //           style: TextStyle(
                                      //             color: Colors.grey[600],
                                      //           ),
                                      //         ),
                                      //         TimestampToString.dddmmmddyyyy(
                                      //           savingsPlan[3].toString(),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ],
                                      // ),

                                      // StepProgressIndicator(
                                      //   totalSteps: int.parse(
                                      //       savingsPlan[3].toString()),
                                      //   currentStep: DateTime.now()
                                      //           .millisecondsSinceEpoch ~/
                                      //       1000,
                                      //   size: 8,
                                      //   padding: 0,
                                      //   selectedColor: Colors.yellow,
                                      //   unselectedColor: Colors.cyan,
                                      //   roundedEdges: const Radius.circular(10),
                                      //   selectedGradientColor:
                                      //       const LinearGradient(
                                      //     begin: Alignment.topLeft,
                                      //     end: Alignment.bottomRight,
                                      //     colors: [
                                      //       Colors.yellowAccent,
                                      //       Colors.deepOrange
                                      //     ],
                                      //   ),
                                      //   unselectedGradientColor:
                                      //       const LinearGradient(
                                      //     begin: Alignment.topLeft,
                                      //     end: Alignment.bottomRight,
                                      //     colors: [Colors.black, Colors.blue],
                                      //   ),
                                      // ),
                                      Center(
                                        child: progressBar,
                                      ),
                                    ],
                                  ),
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
