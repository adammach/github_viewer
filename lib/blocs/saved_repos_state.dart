part of 'saved_repos_bloc.dart';

@immutable
abstract class SavedReposState {}

class SavedReposInitial extends SavedReposState {}
class SavedReposLoading extends SavedReposState {}
class SavedReposLoaded extends SavedReposState {
  final List<String> repos;
  SavedReposLoaded(this.repos);
}
