import 'package:chopper/chopper.dart';
import 'package:github_viewer/models/revision.dart';
import 'package:github_viewer/repository/chopper_service.dart';
import 'package:github_viewer/repository/repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RestRepository implements Repository {
  static late ChopperClient _chopperClient;

  static Repository create() {
    GithubService service = GithubService.create();
    _chopperClient = ChopperClient(services: [service], converter: JsonConverter());
    return RestRepository();
  }

  @override
  Future<List<Revision>> fetchCommits(String repoName, String owner) async {
    final githubService = _chopperClient.getService<GithubService>();
    try {
      final response = await githubService.getRevisions(owner, repoName);
      if (response.isSuccessful) {
        List<Revision> revisions = List<Revision>.from(response.body?.map((element) => Revision.fromJson(element)));
        await saveRepo(repoName, revisions);
        return revisions;
      } else {
        throw RepoReaderException("Cannot read repository");
      }
    } catch (e) {
      throw RepoReaderException("Something wrong has happened :(");
    }

  }

  @override
  Future<List<String>> fetchSavedRepos() async {
    Box reposBox = await Hive.openBox('repos');
    List<String> repoNames = List<String>.from(reposBox.keys.map((repoName) => repoName as String));
    return repoNames;
  }

  @override
  Future<void> saveRepo(String repoName, List<Revision> commits) async {
    Box reposBox = await Hive.openBox('repos');
    if (reposBox.get(repoName) != null) {
      // something to do / nothing to do ?
    } else {
      await reposBox.put(repoName, commits);
    }
  }

  @override
  Future<List<Revision>> loadRepo(String repoName) async {
    Box reposBox = await Hive.openBox('repos');
    List<Revision> revisions = reposBox.get(repoName).map<Revision>((e) => e as Revision).toList();
    return revisions;
  }
}

class RepoReaderException implements Exception {
  String cause;
  RepoReaderException(this.cause);
}