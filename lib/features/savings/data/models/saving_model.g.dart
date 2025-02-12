// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saving_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavingModelAdapter extends TypeAdapter<SavingModel> {
  @override
  final int typeId = 2;

  @override
  SavingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavingModel(
      date: fields[2] as DateTime,
      saving: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, SavingModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.saving)
      ..writeByte(2)
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
