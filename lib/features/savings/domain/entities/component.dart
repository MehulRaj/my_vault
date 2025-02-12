import 'package:my_vault/features/savings/domain/entities/savings.dart';
import 'package:my_vault/features/savings/domain/entities/withdraw.dart';

class Component {
  final double totalA;
  final double totalB;
  final List<Component> components;
  final List<Withdraw> withdraws;
  final List<Saving> savings;

  Component(
      {required this.totalA,
      required this.totalB,
      required this.withdraws,
      required this.savings,
      required this.components});

  copyWith({totalA, totalB, savings, withdraws, components}) {
    return Component(
        totalA: totalA,
        savings: savings,
        withdraws: withdraws,
        components: components,
        totalB: totalB);
  }
}
