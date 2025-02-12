import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants.dart';
import '../providers/component_provider.dart';

class SavingsHistoryScreen extends ConsumerStatefulWidget {
  const SavingsHistoryScreen({super.key});

  @override
  SavingsHistoryScreenState createState() => SavingsHistoryScreenState();
}

class SavingsHistoryScreenState extends ConsumerState<SavingsHistoryScreen> {
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final historyData = ref.watch(transactionStreamProvider);
    return Scaffold(
        appBar: AppBar(title: const Text(Constant.history)),
        body: Column(children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: onTapSavings,
                      child: Container(
                          color: selectedTabIndex == 0
                              ? Colors.blue
                              : Colors.blue.withAlpha(50),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Center(child: Text(Constant.savingsHistory)),
                          )),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: onTapWithdraw,
                      child: Container(
                          color: selectedTabIndex == 1
                              ? Colors.blue
                              : Colors.blue.withAlpha(50),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child:
                                Center(child: Text(Constant.withdrawHistory)),
                          )),
                    )),
                  ],
                ),
              ),
              historyData.when(
                data: (data) {
                  if (data!.components.isEmpty) {
                    return Expanded(
                        child:
                            Center(child: Text(Constant.noHistoryAvailable)));
                  }
                  if (data.savings.isNotEmpty && selectedTabIndex == 0) {
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: data.savings.length,
                        itemBuilder: (context, index) {
                          final entry = data.savings.toList()[index];
                          return Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              title: Text(
                                "Year: ${entry.date.year},Savings: ${entry.saving}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  if (data.withdraws.isNotEmpty && selectedTabIndex != 1) {
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: data.withdraws.length,
                        itemBuilder: (context, index) {
                          final entry = data.withdraws.toList()[index];
                          return Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              title: Text(
                                "Year: ${entry.date.year},Withdraw: ${entry.amount}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return SizedBox();
                },
                error: (err, stack) => Center(
                  child: Text("Error: $err"),
                ),
                loading: () => Center(child: CircularProgressIndicator()),
              )
            ],
          ),
        ]));
  }

  void onTapSavings() {
    selectedTabIndex = 0;
    setState(() {});
  }

  void onTapWithdraw() {
    selectedTabIndex = 1;
    setState(() {});
  }
}
