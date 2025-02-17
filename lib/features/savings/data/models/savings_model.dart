import 'package:hive_flutter/hive_flutter.dart';

part 'savings_model.g.dart';

@HiveType(typeId: 2)
class SavingsModel extends HiveObject {
  @HiveField(0, defaultValue: 0.0)
  final double saving;
  @HiveField(1)
  final DateTime? date; // Make it nullable


  SavingsModel({
    required this.saving,
    required this.date,
  });

  // Conversion from Entity to Model
  factory SavingsModel.fromEntity(SavingsModel trip) => SavingsModel(
        saving: trip.saving,
        date: trip.date,
      );

  // Conversion from Model to Entity
  SavingsModel toEntity() => SavingsModel(
        saving: saving,
        date: date,
      );
}
