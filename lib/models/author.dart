import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'author.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Author{
  @HiveField(0)
  final String? email;
  @HiveField(1)
  final String? name;
  Author({required this.email, required this.name});

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}