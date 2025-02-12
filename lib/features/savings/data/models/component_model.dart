import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/component.dart';
import '../../domain/entities/savings.dart';

part 'component_model.g.dart';

@HiveType(typeId: 0)
class ComponentModel {
  @HiveField(0)
  final double? saving;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final List<Component> components;

  ComponentModel({
    required this.date,
    required this.components,
    required this.saving,
  });

  // Conversion from Entity to Model
  factory ComponentModel.fromEntity(Component trip) => ComponentModel(
    saving: trip.saving,
    date: trip.date,
    components: trip.components
  );

  // Conversion from Model to Entity
  Component toEntity() => Component(date: date, saving: saving, components: components);
}
