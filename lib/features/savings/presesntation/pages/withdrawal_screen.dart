import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_vault/features/savings/data/models/withdraw_model.dart';

import '../../core/constants.dart';
import '../../data/models/component_model.dart';
import '../providers/component_provider.dart';

class WithdrawalScreen extends ConsumerStatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  WithdrawalScreenState createState() => WithdrawalScreenState();
}

class WithdrawalScreenState extends ConsumerState<WithdrawalScreen> {
  final TextEditingController withdrawalController = TextEditingController();
  String selectedComponent = Constant.components[0];

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(transactionNotifierProvider.notifier);
    final component = ref.watch(transactionFutureProvider).value;
    return Scaffold(
      appBar: AppBar(title: const Text(Constant.withdrawAmount)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedComponent,
              onChanged: (newValue) {
                setState(() {
                  selectedComponent = newValue!;
                });
              },
              items: Constant.components.map((comp) {
                return DropdownMenuItem(
                  value: comp,
                  child: Text(comp),
                );
              }).toList(),
            ),
            TextField(
              controller: withdrawalController,
              decoration: const InputDecoration(
                labelText: Constant.enterWithdrawAmount,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  double saving =
                      double.tryParse(withdrawalController.text) ?? 0;
                  ComponentModel? updatedData = component?.copyWith(
                    totalA: component.totalA,
                    totalB: component.totalB,
                    // components: component.components,
                    savings: component.savings,
                    withdraws: [
                      ...component.withdraws,
                      WithdrawModel(
                        amount: saving,
                        component: selectedComponent,
                        date: DateTime.now(),
                      )
                    ],
                  );

                  if (selectedComponent == Constant.components[0]) {
                    updatedData = updatedData?.copyWith(
                        totalA: component!.totalA - saving);
                  } else {
                    updatedData = updatedData?.copyWith(
                        totalB: component!.totalB - saving);
                  }
                  notifier.update(updatedData!);
                } catch (e) {
                  SnackBar(content: Text("Error"));
                }
                Navigator.pop(context);
              },
              child: const Text(Constant.withdraw),
            ),
          ],
        ),
      ),
    );
  }
}
