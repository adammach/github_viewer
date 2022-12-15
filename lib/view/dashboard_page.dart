import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_viewer/blocs/saved_repos_bloc.dart';
import 'package:github_viewer/repository/repository..dart';
import 'package:github_viewer/view/loader.dart';
import 'package:github_viewer/view/repo_details_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Gihub repo viewer"),
      ),
      body: BlocBuilder<SavedReposBloc, SavedReposState>(
        bloc: SavedReposBloc(RepositoryProvider.of<Repository>(context))
          ..add(GetSavedRepos()),
        builder: (context, state) {
          if (state is SavedReposLoaded) {
            if (state.repos.isNotEmpty) {
              return _buildSavedRepos(state.repos);
            } else {
              return _buildEmptyList();
            }
          } else if (state is SavedReposLoading) {
            return _showProgress();
          } else {
            return Container(width: 0,);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool refresh = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => RepoDetailsPage()));
          if (refresh) {
            setState(() {
            });
          }
        },
        tooltip: 'New repo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildEmptyList() {
    return const Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Text("No repos saved."),
    );
  }

  Widget _buildSavedRepos(List<String> repos) {
    return ListView.builder(
        itemCount: repos.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            trailing: const Icon(Icons.arrow_forward),
            title: Text("Name of repo: ${repos[index]}"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  RepoDetailsPage(repoName: repos[index])));
            },
          );
        });
  }

  Widget _showProgress() {
    return LoaderWidget();
  }
}
