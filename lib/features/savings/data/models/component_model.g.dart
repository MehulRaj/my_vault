// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComponentModelAdapter extends TypeAdapter<ComponentModel> {
  @override
  final int typeId = 0;

  @override
  ComponentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ComponentModel(
      totalA: fields[0] == null ? 0.0 : fields[0] as double,
      totalB: fields[1] == null ? 0.0 : fields[1] as double,
      savings:
          fields[3] == null ? [] : (fields[3] as List).cast<SavingsModel>(),
      withdraws:
          fields[2] == null ? [] : (fields[2] as List).cast<WithdrawModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ComponentModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.totalA)
      ..writeByte(1)
      ..write(obj.totalB)
      ..writeByte(2)
      ..write(obj.withdraws)
      ..writeByte(3)
      ..write(obj.savings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComponentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
