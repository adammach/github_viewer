import 'package:github_viewer/models/author.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'commit.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Commit extends HiveObject {
  @HiveField(0)
  final String message;
  @HiveField(1)
  final Author author;
  Commit({required this.message, required this.author});

  factory Commit.fromJson(Map<String, dynamic> json) => _$CommitFromJson(json);

  Map<String, dynamic> toJson() => _$CommitToJson(this);
}