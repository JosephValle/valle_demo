import "package:bloc/bloc.dart";
import "package:meta/meta.dart";
import "package:vumc_demo_valle/objects/repo_object.dart";

import "../../network_interface/repositories/repos/repos_repository.dart";

part "repos_event.dart";

part "repos_state.dart";

class ReposBloc extends Bloc<ReposEvent, ReposState> {
  final ReposRepository _reposRepository;
  List<RepoObject> repos = [];
  int page = 0;

  ReposBloc({required ReposRepository reposRepository})
      : _reposRepository = reposRepository,
        super( const ReposLoading(repos: [], silent: false, clearing: true)) {
    on<GetRepos>((event, emit) async {
      if(state is ReposLoading && !state.clearing) {
        return;
      }
      emit(ReposLoading(repos: repos, silent: page != 0));
      repos.addAll( await _reposRepository.getRepos(page: page));
      page++;
      emit(ReposLoaded(repos: repos));
    });

    on<FlushRepos>((event, emit) async {
      repos.clear();
      page = 0;
      emit(ReposLoading(repos: repos, silent: false, clearing: true));
      await _reposRepository.flushSQL();
      add(GetRepos());
    });
  }
}
