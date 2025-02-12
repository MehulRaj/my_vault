import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/savings.dart';

part 'saving_model.g.dart';

@HiveType(typeId: 0)
class SavingModel {
  @HiveField(0)
  final double? saving;
  @HiveField(3)
  final DateTime date;

  SavingModel({
    required this.date,
    required this.saving,
  });

  // Conversion from Entity to Model
  factory SavingModel.fromEntity(Saving trip) => SavingModel(
        saving: trip.saving,
        date: trip.date,
      );

  // Conversion from Model to Entity
  Saving toEntity() => Saving(date: date, saving: saving);
}
