import 'package:github_viewer/models/revision.dart';

abstract class Repository {
  /// Get list of commits for selected [repoName] and [owner].
  Future<List<Revision>> fetchCommits (String repoName, String owner);
  /// Get list of names of saved repos.
  Future<List<String>> fetchSavedRepos();
  /// Save repo
  Future<void> saveRepo(String repoName, List<Revision> commits);
  /// Get list of commits for selected [repoName] from local storage
  Future<List<Revision>> loadRepo(String repoName);
}