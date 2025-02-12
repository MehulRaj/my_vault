import 'package:flutter/material.dart';
import 'features/savings/core/constants.dart';
import 'features/savings/presesntation/pages/home_screen.dart';
import 'features/savings/presesntation/pages/saving_history_screen.dart';
import 'features/savings/presesntation/pages/savings_entry_screen.dart';
import 'features/savings/presesntation/pages/withdrawal_screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Constant.savingEntryScreenPath:
        return MaterialPageRoute(builder: (_) => const SavingsEntryScreen());
      case Constant.savingHistoryScreenPath:
        return MaterialPageRoute(builder: (_) => const SavingsHistoryScreen());
      case Constant.withdrawScreenPath:
        return MaterialPageRoute(builder: (_) => const WithdrawalScreen());
      case Constant.mainScreenPath:
      default:
        return MaterialPageRoute(builder: (_) => const MainScreen());
    }
  }
}
