// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WithdrawModelAdapter extends TypeAdapter<WithdrawModel> {
  @override
  final int typeId = 1;

  @override
  WithdrawModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WithdrawModel(
      amount: fields[0] == null ? 0.0 : fields[0] as double,
      component: fields[1] == null ? '' : fields[1] as String,
      date: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, WithdrawModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.component)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WithdrawModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
