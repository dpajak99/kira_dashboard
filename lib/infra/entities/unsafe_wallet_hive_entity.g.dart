// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unsafe_wallet_hive_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UnsafeWalletHiveEntityAdapter
    extends TypeAdapter<UnsafeWalletHiveEntity> {
  @override
  final int typeId = 0;

  @override
  UnsafeWalletHiveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UnsafeWalletHiveEntity(
      extendedMasterKey: fields[0] as String,
      index: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UnsafeWalletHiveEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.extendedMasterKey)
      ..writeByte(1)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnsafeWalletHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
