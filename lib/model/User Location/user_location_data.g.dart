// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserLocationDbAdapter extends TypeAdapter<UserLocationDb> {
  @override
  final int typeId = 1;

  @override
  UserLocationDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserLocationDb(
      locationName: fields[0] as String,
      latitude: fields[1] as String,
      longitude: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserLocationDb obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.locationName)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLocationDbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
