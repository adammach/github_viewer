import 'package:github_viewer/models/revision.dart';


class SavedRepository {
  final String name;
  final List<Revision> revisions;
  SavedRepository({required this.name, required this.revisions});
}