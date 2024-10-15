import 'dart:async';

import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:timestamp_to_string/timestamp_to_string.dart';
import 'package:trustfund_app/screen/loading_screen.dart';
import 'package:trustfund_app/styles/colors.dart';

enum SavingsPlanType { flexSave, secureSave, goalSave }

enum Frequency { single, daily, weekly, monthly }

class SavingsPlanDetails extends StatefulWidget {
  final String planId;
  final String savingsPlan;
  final String startDate;
  final String maturityDate;
  final String interestRate;
  final String frequency;
  final String duration;
  final String amount;

  const SavingsPlanDetails({
    super.key,
    required this.planId,
    required this.savingsPlan,
    required this.startDate,
    required this.maturityDate,
    required this.interestRate,
    required this.frequency,
    required this.duration,
    required this.amount,
  });

  @override
  State<SavingsPlanDetails> createState() => _SavingsPlanDetailsState();
}

class _SavingsPlanDetailsState extends State<SavingsPlanDetails> {
  late String account;
  late List<dynamic> savingsPlansDetails;

  @override
  void initState() {
    super.initState();
    // account = Provider.of<ConnectLogicProvider>(context, listen: false)
    //     .connectedAccounts[0]
    //     .publicAddress;
    // final rContractprovider =
    //     Provider.of<ReadcontractService>(context, listen: false);
    // rContractprovider.getSavingsPlansDetailsContract(
    //     publicAddress: account, planId: BigInt.parse(widget.planId));
    // savingsPlansDetails = rContractprovider.savingsPlansDetails;
  }

  Future<bool> getSavingsplansDetails() async {
    return widget.planId.isNotEmpty;
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
        title: Text('${getSavingsPlanTypeFromUint8(int.parse(
          widget.savingsPlan,
        )).name} Plan Details'),
        centerTitle: true,
      ),
      body: FutureBuilder<bool>(
        future: getSavingsplansDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                    child: Container(
                  color: Colors.grey[100],
                  child: const Center(
                    child: Text(
                      'No Network Available',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
              ],
            );
          } else if (snapshot.hasData) {
            return Column(
              children: [
                // Account Details Card
                SizedBox(
                  height: 210,
                  child: Card(
                    elevation: 10,
                    // surfaceTintColor: Theme.of(context).colorScheme.primary,
                    color: AppColor.primaryColor,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    shadowColor: Colors.grey.withOpacity(0.6),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/map.png',
                            fit: BoxFit.contain,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  const Text(
                                    'Total Balance',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${(double.parse(
                                          widget.amount,
                                        ) / 1000000000000000000).toStringAsFixed(4)} ETH',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 230,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Savings Plan Type',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Text(
                                  getSavingsPlanTypeFromUint8(
                                    int.parse(
                                      widget.savingsPlan,
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
                                        widget.amount,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Saving Frequency',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Text(
                                  getFrequencyFromUint8(
                                    int.parse(
                                      widget.frequency,
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
                                  '${widget.interestRate}%',
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start Date',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                TimestampToString.dddmmmddyyyy(
                                  widget.startDate,
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
                                  widget.maturityDate,
                                ),
                              ],
                            ),
                          ],
                        ),
                        StepProgressIndicator(
                          totalSteps: int.parse(widget.maturityDate),
                          currentStep:
                              DateTime.now().millisecondsSinceEpoch ~/ 1000,
                          size: 8,
                          padding: 0,
                          selectedColor: Colors.yellow,
                          unselectedColor: Colors.cyan,
                          roundedEdges: const Radius.circular(10),
                          selectedGradientColor: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.yellowAccent, Colors.deepOrange],
                          ),
                          unselectedGradientColor: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.black, Colors.blue],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const LoadScreen();
          }
        },
      ),
    );
  }
}
