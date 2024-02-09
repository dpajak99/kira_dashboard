// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_address_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouriteAddressHiveEntityAdapter
    extends TypeAdapter<FavouriteAddressHiveEntity> {
  @override
  final int typeId = 1;

  @override
  FavouriteAddressHiveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouriteAddressHiveEntity(
      address: fields[0] as String,
      date: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavouriteAddressHiveEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteAddressHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
