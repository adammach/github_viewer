import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:github_viewer/models/revision.dart';

part "chopper_service.chopper.dart";

@ChopperApi(baseUrl: "https://api.github.com")
abstract class GithubService extends ChopperService {

  static GithubService create([ChopperClient? client]) =>
      _$GithubService(client);

  @Get(path: 'repos/{owner}/{repo}/commits')
  Future<Response> getRevisions( @Path() String owner, @Path() String repo);
}