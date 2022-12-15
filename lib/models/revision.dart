import 'package:github_viewer/models/author.dart';
import 'package:github_viewer/models/commit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'revision.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class Revision extends HiveObject{
      @HiveField(0)
      final String sha;
      @HiveField(1)
      final Commit commit;
      @HiveField(2)
      final Author author;

      Revision({required this.sha, required this.commit, required this.author});

      factory Revision.fromJson(Map<String, dynamic> json) => _$RevisionFromJson(json);

      /// Connect the generated [_$PersonToJson] function to the `toJson` method.
      Map<String, dynamic> toJson() => _$RevisionToJson(this);

}