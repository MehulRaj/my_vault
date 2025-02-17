import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants.dart';
import '../providers/component_provider.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  double? componentAValue;
  double? componentBValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final component = ref.watch(transactionFutureProvider).value;
    print("COMPONENT : ${component.toString()}");
    return Scaffold(
      appBar: AppBar(title: const Text(Constant.myVault)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBalanceCard(Constant.componentA,
                    component == null ? 0.0 : component.totalA, Colors.blue),
                _buildBalanceCard(Constant.componentB,
                    component == null ? 0.0 : component.totalB, Colors.green),
              ],
            ),
            const SizedBox(height: 20),
            _buildNavigationButton(context, Constant.enterSavings, Icons.add,
                () async {
              await Navigator.pushNamed(
                  context, Constant.savingEntryScreenPath);
            }),
            _buildNavigationButton(
                context, Constant.viewSavingsHistory, Icons.history, () {
              Navigator.pushNamed(context, Constant.savingHistoryScreenPath);
            }),
            _buildNavigationButton(
                context, Constant.withdrawAmount, Icons.money, () {
              Navigator.pushNamed(context, Constant.withdrawScreenPath);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(String title, double balance, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(0.1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("₹${balance.toStringAsFixed(2)}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, String label,
      IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        icon: Icon(icon),
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }
}
