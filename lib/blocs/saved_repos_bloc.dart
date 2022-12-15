import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:github_viewer/models/saved_repo.dart';
import 'package:github_viewer/repository/repository..dart';
import 'package:meta/meta.dart';

part 'saved_repos_event.dart';
part 'saved_repos_state.dart';

class SavedReposBloc extends Bloc<SavedReposEvent, SavedReposState> {
  final Repository repository;

  SavedReposBloc(this.repository) : super(SavedReposInitial()) {
    on<GetSavedRepos>((event, emit) async {
      emit(SavedReposLoading());
      List<String> repos = await repository.fetchSavedRepos();
      emit(SavedReposLoaded(repos));

    });
  }
}
