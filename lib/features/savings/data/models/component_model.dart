import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_vault/features/savings/domain/entities/withdraw.dart';

import '../../domain/entities/component.dart';
import '../../domain/entities/savings.dart';

part 'component_model.g.dart';

@HiveType(typeId: 0)
class ComponentModel {
  @HiveField(0)
  final double totalA;
  @HiveField(1)
  final double totalB;
  @HiveField(2)
  final List<Component> components;
  @HiveField(3)
  final List<Withdraw> withdraws;
  @HiveField(4)
  final List<Saving> savings;

  ComponentModel({
    required this.totalA,
    required this.totalB,
    required this.components,
    required this.savings,
    required this.withdraws,
  });

  // Conversion from Entity to Model
  factory ComponentModel.fromEntity(Component trip) => ComponentModel(
      totalA: trip.totalA,
      totalB: trip.totalB,
      savings: trip.savings,
      withdraws: trip.withdraws,
      components: trip.components);

  // Conversion from Model to Entity
  Component toEntity() => Component(
      withdraws: withdraws,
      savings: savings,
      totalA: totalA,
      totalB: totalB,
      components: components);
}
