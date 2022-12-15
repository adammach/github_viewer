import 'package:github_viewer/models/revision.dart';
import 'package:github_viewer/models/saved_repo.dart';

abstract class Repository {
  Future<List<Revision>> fetchCommits (String repoName, String owner);
  Future<List<String>> fetchSavedRepos();
  Future<void> saveRepo(String repoName, List<Revision> commits);
  Future<List<Revision>> loadRepo(String repoName);
}