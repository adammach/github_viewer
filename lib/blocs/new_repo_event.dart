part of 'repo_detail_bloc.dart';

@immutable
abstract class RepoDetailsEvent {}
class StartNewRepoEvent extends RepoDetailsEvent {}
class LoadRepoEvent extends RepoDetailsEvent {
  final String repoName;
  LoadRepoEvent({required this.repoName});
}

class CreateNewRepoEvent extends RepoDetailsEvent {
  final String owner;
  final String repoName;
  CreateNewRepoEvent(this.owner, this.repoName);
}
