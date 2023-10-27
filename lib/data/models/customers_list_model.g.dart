// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataAdapterCust extends TypeAdapter<Data> {
  @override
  final int typeId = 2;

  @override
  Data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Data(
      id: fields[0] as int?,
      name: fields[1] as String?,
      profilePic: fields[2] as String?,
      mobileNumber: fields[3] as String?,
      email: fields[4] as String?,
      street: fields[5] as String?,
      streetTwo: fields[6] as String?,
      city: fields[7] as String?,
      pincode: fields[8] as int?,
      country: fields[9] as String?,
      state: fields[10] as String?,
      createdDate: fields[11] as DateTime?,
      createdTime: fields[12] as String?,
      modifiedDate: fields[13] as DateTime?,
      modifiedTime: fields[14] as String?,
      flag: fields[15] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Data obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.profilePic)
      ..writeByte(3)
      ..write(obj.mobileNumber)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.street)
      ..writeByte(6)
      ..write(obj.streetTwo)
      ..writeByte(7)
      ..write(obj.city)
      ..writeByte(8)
      ..write(obj.pincode)
      ..writeByte(9)
      ..write(obj.country)
      ..writeByte(10)
      ..write(obj.state)
      ..writeByte(11)
      ..write(obj.createdDate)
      ..writeByte(12)
      ..write(obj.createdTime)
      ..writeByte(13)
      ..write(obj.modifiedDate)
      ..writeByte(14)
      ..write(obj.modifiedTime)
      ..writeByte(15)
      ..write(obj.flag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataAdapterCust &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
