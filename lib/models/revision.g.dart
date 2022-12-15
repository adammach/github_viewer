// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revision.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RevisionAdapter extends TypeAdapter<Revision> {
  @override
  final int typeId = 2;

  @override
  Revision read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Revision(
      sha: fields[0] as String,
      commit: fields[1] as Commit,
      author: fields[2] as Author,
    );
  }

  @override
  void write(BinaryWriter writer, Revision obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.sha)
      ..writeByte(1)
      ..write(obj.commit)
      ..writeByte(2)
      ..write(obj.author);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RevisionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Revision _$RevisionFromJson(Map<String, dynamic> json) => Revision(
      sha: json['sha'] as String,
      commit: Commit.fromJson(json['commit'] as Map<String, dynamic>),
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RevisionToJson(Revision instance) => <String, dynamic>{
      'sha': instance.sha,
      'commit': instance.commit,
      'author': instance.author,
    };
