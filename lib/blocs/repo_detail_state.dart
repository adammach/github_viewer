part of 'repo_detail_bloc.dart';

@immutable
abstract class RepoDetailsState {}

class RepoDetailsInitial extends RepoDetailsState {}
class RepoDetailsLoading extends RepoDetailsState {}
class RepoDetailsError extends RepoDetailsState {
  final String message;
  RepoDetailsError(this.message);
}
class RepoMissing extends RepoDetailsState {}
class RepoLoaded extends RepoDetailsState {
  final List<Revision> revisions;
  RepoLoaded({required this.revisions});
}
