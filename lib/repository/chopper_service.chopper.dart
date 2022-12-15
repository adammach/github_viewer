// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chopper_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$GithubService extends GithubService {
  _$GithubService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = GithubService;

  @override
  Future<Response<dynamic>> getRevisions(
    String owner,
    String repo,
  ) {
    final Uri $url =
        Uri.parse('https://api.github.com/repos/${owner}/${repo}/commits');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
