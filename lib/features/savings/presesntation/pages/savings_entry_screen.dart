import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants.dart';
import '../../domain/entities/component.dart';
import '../../domain/entities/savings.dart';
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
    var component = ref.watch(transactionStreamProvider).value;
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
                  print("11111");
                  double saving = double.tryParse(savingsController.text) ?? 0;
                  var savingA = (_currentSliderValue * saving) / 100;
                  var savingB = ((100 - _currentSliderValue) * saving) / 100;
                  print("22222");
                  component ??= Component(
                      totalA: 0.0,
                      savings: [],
                      withdraws: [],
                      components: [],
                      totalB: 0.0);
                  print("3333 ${component}");
                  var updatedData = component!.copyWith(
                      totalA: component!.totalA + savingA,
                      totalB: component!.totalB + savingB,
                      savings: [
                        ...component!.savings,
                        Saving(
                          saving: saving,
                          date: DateTime.now(),
                        )
                      ],
                      withdraws: component!.withdraws,
                      components: component!.components);
                  print("11111");
                  await notifier.update(updatedData);
                  Navigator.pop(context);
                } catch (e) {
                  print("ERROR ::: ${e.toString()}");
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
