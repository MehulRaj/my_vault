import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_vault/features/savings/core/helpers/local_storage_helper.dart';
import 'package:my_vault/features/savings/domain/entities/withdraw.dart';
import 'package:my_vault/features/savings/presesntation/providers/withdraw_provider.dart';

import '../../core/constants.dart';

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
                double saving = double.tryParse(withdrawalController.text) ?? 0;
                final withdrawItem = Withdraw(
                  amount: saving,
                  component: selectedComponent,
                  date: DateTime.now(),
                );
                ref
                    .read(withdrawListNotifierProvider.notifier)
                    .addNewWithdraw(withdrawItem);
                //user selected compA
                saveDataAndNavigate(saving);
              },
              child: const Text(Constant.withdraw),
            ),
          ],
        ),
      ),
    );
  }

  //save values to preferences
  Future<void> saveDataAndNavigate(saving) async {
    if (selectedComponent == Constant.components[0]) {
      await LocalStorageHelper.setDouble(
          Constant.componentAValue,
          (LocalStorageHelper.getDouble(Constant.componentAValue) ??
              0.0) -
              saving);
    } else {
      await LocalStorageHelper.setDouble(
          Constant.componentBValue,
          (LocalStorageHelper.getDouble(Constant.componentAValue) ??
              0.0) -
              saving);
    }
    var data = {
      'newAValue':
      LocalStorageHelper.getDouble(Constant.componentAValue),
      'newBValue':
      LocalStorageHelper.getDouble(Constant.componentBValue)
    };
    Navigator.pop(context, data);
  }
}
