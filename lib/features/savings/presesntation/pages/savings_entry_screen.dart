import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_vault/features/savings/data/models/component_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants.dart';
import '../../data/models/savings_model.dart';
import '../providers/component_provider.dart';

class SavingsEntryScreen extends ConsumerStatefulWidget {
  const SavingsEntryScreen({super.key});

  @override
  SavingsEntryScreenState createState() => SavingsEntryScreenState();
}

class SavingsEntryScreenState extends ConsumerState<SavingsEntryScreen> {
  final TextEditingController savingsController = TextEditingController();
  int _currentSliderValue = 20;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(transactionNotifierProvider.notifier);
    var component = ref.watch(transactionFutureProvider).value;
    return Scaffold(
      appBar: AppBar(title: const Text(Constant.enterSavings)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: savingsController,
              decoration:
                  InputDecoration(labelText: Constant.enterAnnualSavings),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Center(child: const Text(Constant.divideSaving)),
            Row(
              children: [
                Column(
                  children: [
                    Text(Constant.A),
                    Text('${_currentSliderValue.toInt()}%'),
                  ],
                ),
                Expanded(
                  child: Slider(
                    value: _currentSliderValue.toDouble(),
                    max: 100,
                    divisions: 100,
                    label: _currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value.toInt();
                      });
                    },
                  ),
                ),
                Column(
                  children: [
                    Text(Constant.B),
                    Text('${100 - _currentSliderValue.toInt()}%'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  double saving = double.tryParse(savingsController.text) ?? 0;
                  var savingA = (_currentSliderValue * saving) / 100;
                  var savingB = ((100 - _currentSliderValue) * saving) / 100;
                  component ??= ComponentModel(
                      totalA: 0.0, savings: [], withdraws: [], totalB: 0.0);

                  var updatedData = component!.copyWith(
                    totalA: component!.totalA + savingA,
                    totalB: component!.totalB + savingB,
                    savings: [
                      ...component!.savings,
                      SavingsModel(saving: saving, date: DateTime.now())
                    ],
                    withdraws: component!.withdraws,
                  );


                  if (!context.mounted) return;
                  await notifier.update(updatedData);

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                } catch (e) {
                }
              },
              child: const Text(Constant.submit),
            ),
          ],
        ),
      ),
    );
  }
}
