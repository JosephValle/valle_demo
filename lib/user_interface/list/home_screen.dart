import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:vumc_demo_valle/user_interface/list/widgets/repo_tile.dart";

import "../../logical_interface/bloc/repos_bloc.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ReposBloc>().add(GetRepos());
    _scrollController.addListener(_onScroll);
  }

  // when they reach the end of the list
  void _onScroll() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      context.read<ReposBloc>().add(GetRepos());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReposBloc, ReposState>(
      listener: (context, state) {},
      builder: (context, state) {

        return Scaffold(
          appBar: AppBar(
            title: const Text("Valle Demo"),
            actions: [
              IconButton(
                onPressed: () => context.read<ReposBloc>().add(FlushRepos()),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: state is ReposError
              ? Center(
                  child: Text(
                    "Error: ${state.error}",
                    textAlign: TextAlign.center,
                  ),
                )
              : state is ReposLoading && !state.silent
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Scrollbar(
                            controller: _scrollController,
                            child: ListView.builder(
                              itemCount: state.repos.length,
                              controller: _scrollController,
                              itemBuilder: (context, index) {
                                final repo = state.repos[index];
                                return RepoTile(repoObject: repo);
                              },
                            ),
                          ),
                        ),
                        if(state is ReposLoading)
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    ),
        );
      },
    );
  }
}
