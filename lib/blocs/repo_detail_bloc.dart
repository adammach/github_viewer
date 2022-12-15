import 'package:bloc/bloc.dart';
import 'package:github_viewer/models/revision.dart';
import 'package:github_viewer/repository/repository.dart';
import 'package:github_viewer/repository/rest_repository.dart';
import 'package:meta/meta.dart';

part 'new_repo_event.dart';

part 'repo_detail_state.dart';

class RepoDetailsBloc extends Bloc<RepoDetailsEvent, RepoDetailsState> {
  final Repository repository;

  RepoDetailsBloc(this.repository) : super(RepoDetailsInitial()) {
    on<StartNewRepoEvent>((event, emit) {
      emit(RepoMissing());
    });
    on<CreateNewRepoEvent>((event, emit) async {
      emit(RepoDetailsLoading());
      try {
        List<Revision> commits =
            await repository.fetchCommits(event.repoName, event.owner);
        emit(RepoLoaded(revisions: commits));
      } catch (e) {
        emit(RepoDetailsError((e as RepoReaderException).cause));
      }
    });
    on<LoadRepoEvent>((event, emit) async {
      emit(RepoDetailsLoading());
      List<Revision> commits = await repository.loadRepo(event.repoName);
      emit(RepoLoaded(revisions: commits));
    });
  }
}
