import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_vault/features/savings/domain/entities/savings.dart';
import 'package:my_vault/features/savings/domain/entities/withdraw.dart';

import '../../core/constants.dart';
import '../providers/savings_provider.dart';
import '../providers/withdraw_provider.dart';

class SavingsHistoryScreen extends ConsumerStatefulWidget {
  const SavingsHistoryScreen({super.key});

  @override
  SavingsHistoryScreenState createState() => SavingsHistoryScreenState();
}

class SavingsHistoryScreenState extends ConsumerState<SavingsHistoryScreen> {
  int selectedTabIndex = 0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var history = selectedTabIndex == 0
        ? ref.watch(savingListNotifierProvider)
        : ref.watch(withdrawListNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text(Constant.history)),
      body: Column(
        children: [
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
                    ))
                  ],
                ),
              )
            ],
          ),
          (history.isEmpty)
              ? Expanded(
                  child: Center(child: Text(Constant.noHistoryAvailable)))
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final entry = history.toList()[index];
                      if (selectedTabIndex == 0) {
                        entry as Saving;
                      } else {
                        entry as Withdraw;
                      }
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Text(
                            selectedTabIndex == 0
                                ? "Year: ${(entry as Saving).date.year},Savings: ${(entry).saving}"
                                : "Year: ${(entry as Withdraw).date.year},Savings: ${entry.amount},Component: ${entry.component}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }

  void onTapSavings() {
    selectedTabIndex = 0;
    setState(() {});
  }

  void onTapWithdraw() {
    selectedTabIndex = 1;
    setState(() {});
  }

  Future<void> getData() async {
    Future.microtask(() async {
      await ref.read(savingListNotifierProvider.notifier).loadSavings();
      await ref.read(withdrawListNotifierProvider.notifier).loadWithdraws();
    });
    setState(() {});
  }
}
