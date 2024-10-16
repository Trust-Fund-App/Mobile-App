import 'dart:async';

import 'package:flutter/material.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
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
            final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
            final daysLeft = timestampToDays(
              (int.parse(widget.maturityDate)) - ((currentTime)),
            );
            List<Segment> segments = [
              Segment(
                value: timestampToDays(int.parse(widget.duration)) - daysLeft,
                color: Colors.green,
              ),
            ];
            final progressBar = PrimerProgressBar(
              maxTotalValue: timestampToDays(int.parse(widget.duration)),
              segments: segments,
              showLegend: false,
              barStyle: SegmentedBarStyle(
                  backgroundColor: Colors.grey[300],
                  size: 12,
                  padding: const EdgeInsets.all(2)),
            );
            return SingleChildScrollView(
              child: Column(
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
                                    Text(
                                      'Total Balance',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${(double.parse(
                                            widget.amount,
                                          ) / 1000000000000000000).toStringAsFixed(4)} ETH',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Interest Accurred',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[300],
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '${(double.parse(
                                                widget.amount,
                                              ) / 10000000000000).round()} \$LWT',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[300],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.south_east_outlined,
                                color: Colors.grey[300],
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Top-Up',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.north_east_outlined,
                                color: Colors.grey[300],
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Claim',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 130,
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
                                  'Interest',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Text(
                                  'Up to ${widget.interestRate}%',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
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
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Center(
                          child: progressBar,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 18),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
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
                                    'Duration',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    '${timestampToDays(int.parse(widget.duration)).toString()} days',
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
                                      widget.maturityDate),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const LoadScreen();
          }
        },
      ),
    );
  }
}
