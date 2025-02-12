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
      totalA: fields[0] as double,
      totalB: fields[1] as double,
      components: (fields[2] as List).cast<Component>(),
      savings: (fields[4] as List).cast<Saving>(),
      withdraws: (fields[3] as List).cast<Withdraw>(),
    );
  }

  @override
  void write(BinaryWriter writer, ComponentModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.totalA)
      ..writeByte(1)
      ..write(obj.totalB)
      ..writeByte(2)
      ..write(obj.components)
      ..writeByte(3)
      ..write(obj.withdraws)
      ..writeByte(4)
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
