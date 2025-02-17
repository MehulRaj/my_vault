import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_vault/features/savings/data/models/savings_model.dart';
import 'package:my_vault/features/savings/data/models/withdraw_model.dart';

part 'component_model.g.dart';

@HiveType(typeId: 0)
class ComponentModel extends HiveObject {
  @HiveField(0, defaultValue: 0.0)
  final double totalA;
  @HiveField(1, defaultValue: 0.0)
  final double totalB;
  @HiveField(2, defaultValue: [])
  final List<WithdrawModel> withdraws;
  @HiveField(3, defaultValue: [])
  final List<SavingsModel> savings;

  ComponentModel({
    required this.totalA,
    required this.totalB,
    required this.savings,
    required this.withdraws,
  });

  // Conversion from Entity to Model
  factory ComponentModel.fromEntity(ComponentModel trip) => ComponentModel(
        totalA: trip.totalA,
        totalB: trip.totalB,
        savings: trip.savings,
        withdraws: trip.withdraws,
      );

  // Conversion from Model to Entity
  ComponentModel toEntity() => ComponentModel(
        withdraws: withdraws,
        savings: savings,
        totalA: totalA,
        totalB: totalB,
      );

  ComponentModel copyWith({
    double? totalA,
    double? totalB,
    List<SavingsModel>? savings,
    List<WithdrawModel>? withdraws,
  }) {
    return ComponentModel(
      totalA: totalA ?? this.totalA,
      totalB: totalB ?? this.totalB,
      savings: savings ?? this.savings,
      withdraws: withdraws ?? this.withdraws,
    );
  }
}
