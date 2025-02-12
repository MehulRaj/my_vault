// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saving_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavingModelAdapter extends TypeAdapter<SavingModel> {
  @override
  final int typeId = 0;

  @override
  SavingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavingModel(
      date: fields[3] as DateTime,
      saving: fields[0] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, SavingModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.saving)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
