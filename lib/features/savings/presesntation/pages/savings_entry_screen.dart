import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants.dart';
import '../../core/helpers/local_storage_helper.dart';
import '../../domain/entities/savings.dart';
import '../providers/savings_provider.dart';

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
    initPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                double saving = double.tryParse(savingsController.text) ?? 0;
                final savingItem = Saving(
                  saving: saving,
                  date: DateTime.now(),
                );
                ref
                    .read(savingListNotifierProvider.notifier)
                    .addNewSaving(savingItem);
                saveDataAndNavigate(saving);
              },
              child: const Text(Constant.submit),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  //save values to preferences
  Future<void> saveDataAndNavigate(saving) async {
    var newAValue =
        ((LocalStorageHelper.getDouble(Constant.componentAValue) ?? 0.0) +
            (_currentSliderValue * saving) / 100);
    var newBValue =
        ((LocalStorageHelper.getDouble(Constant.componentBValue) ?? 0.0) +
            ((100 - _currentSliderValue) * saving) / 100);

    await LocalStorageHelper.setDouble(Constant.componentAValue, newAValue);
    await LocalStorageHelper.setDouble(Constant.componentBValue, newBValue);
    Navigator.pop(context, {'newAValue': newAValue, 'newBValue': newBValue});
  }
}
