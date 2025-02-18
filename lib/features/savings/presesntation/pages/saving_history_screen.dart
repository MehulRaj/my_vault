import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants.dart';
import '../providers/component_provider.dart';

class SavingsHistoryScreen extends ConsumerStatefulWidget {
  const SavingsHistoryScreen({super.key});

  @override
  SavingsHistoryScreenState createState() => SavingsHistoryScreenState();
}

class SavingsHistoryScreenState e xtends ConsumerState<SavingsHistoryScreen> {
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final historyData = ref.watch(transactionFutureProvider);
    return Scaffold(
        appBar: AppBar(title: const Text(Constant.history)),
        body: Column(
          children: [
            Row(
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
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: onTapWithdraw,
                    child: Container(
                        color: selectedTabIndex == 1
                            ? Colors.blue
                            : Colors.blue.withAlpha(50),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Center(child: Text(Constant.withdrawHistory)),
                        )),
                  ),
                ),
              ],
            ),
            historyData.when(
              data: (data) {
                if (data == null ||
                    (data.savings.isEmpty && data.withdraws.isEmpty)) {
                  return const Expanded(
                    child: Center(child: Text(Constant.noHistoryAvailable)),
                  );
                }

                if (selectedTabIndex == 0 && data.savings.isNotEmpty) {
                  return Expanded(
                    // 🔹 Add Expanded to avoid infinite height issue
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: data.savings.length,
                      itemBuilder: (context, index) {
                        final entry = data.savings[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            title: Text(
                              "Year: ${entry.date?.year}, Savings: ${entry.saving}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }

                if (selectedTabIndex == 1 && data.withdraws.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: data.withdraws.length,
                      itemBuilder: (context, index) {
                        final entry = data.withdraws[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            title: Text(
                              "Year: ${entry.date?.year}, Withdraw: ${entry.amount}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox(); // Default empty widget
              },
              error: (err, stack) => Expanded(
                child: Center(child: Text("Error: $err")),
              ),
              loading: () => const Expanded(
                child: Center(child: CircularProgressIndicator()),
              ),
            )
          ],
        ));
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
