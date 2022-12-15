import 'package:github_viewer/models/author.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CommitToJson(this);
}