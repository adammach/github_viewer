
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_viewer/blocs/repo_detail_bloc.dart';
import 'package:github_viewer/models/revision.dart';
import 'package:github_viewer/repository/repository.dart';
import 'package:github_viewer/view/loader.dart';
import 'package:share_plus/share_plus.dart';

class RepoDetailsPage extends StatefulWidget {
  final String? repoName;

  const RepoDetailsPage({this.repoName});

  @override
  State<RepoDetailsPage> createState() => _RepoDetailsState();
}

class _RepoDetailsState extends State<RepoDetailsPage> {
  late RepoDetailsBloc _bloc;
  late TextEditingController _ownerController;
  late TextEditingController _repoNameController;
  List<Revision> checkedRevisions = [];

  @override
  void initState() {
    super.initState();
    _ownerController = TextEditingController();
    _repoNameController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Repository repository = RepositoryProvider.of<Repository>(context);
    _bloc = RepoDetailsBloc(repository);
    if (widget.repoName?.isNotEmpty == true) {
      _bloc.add(LoadRepoEvent(repoName: widget.repoName!));
    } else {
      _bloc.add(StartNewRepoEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: const Text("Repo details"),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => {_shareCommits(checkedRevisions)},
              )
            ],
          ),
          body: BlocConsumer<RepoDetailsBloc, RepoDetailsState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is RepoMissing) {
                  _showNewRepoDialog(context);
                }
              },
              builder: (context, state) {
                if (state is RepoDetailsInitial) {
                  return _buildEmptyCommits();
                }
                if (state is RepoLoaded) {
                  return _buildCommitsList(state.revisions);
                } else if (state is RepoDetailsLoading) {
                  return _showProgress();
                } else {
                  return _buildEmptyCommits();
                }
              })),
    );
  }

  Widget _buildEmptyCommits() {
    return const Center(
      child: Text ("No commits to show."),
    );
  }

  Widget _buildCommitsList(List<Revision> revisions) {
    return ListView.builder(
        itemCount: revisions.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
              value: checkedRevisions.contains(revisions[index]),
              onChanged: (bool? value) {
                setState(() {
                  checkedRevisions.add(revisions[index]);
                });
              },
              title: Text("Author: ${revisions[index].commit.author.name}"),
              subtitle: Text(revisions[index].commit.message));
        });
  }

  Future<void> _showNewRepoDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Open new repository'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(hintText: "Name of owner"),
                controller: _ownerController,
              ),
              TextField(
                decoration: const InputDecoration(hintText: "Name of repo"),
                controller: _repoNameController,
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                _bloc.add(CreateNewRepoEvent(
                    _ownerController.text, _repoNameController.text));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _shareCommits(List<Revision> checkedRevisions) {
    List<String> shareMessage = checkedRevisions.map((revision) => revision.sha).toList();
    Share.share(shareMessage.join(";"));
  }

  Widget _showProgress() {
    return LoaderWidget();
  }
}
