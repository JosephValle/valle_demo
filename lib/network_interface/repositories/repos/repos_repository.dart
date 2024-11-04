import "package:vumc_demo_valle/network_interface/api_clients/github_api_client.dart";
import "package:vumc_demo_valle/network_interface/repositories/repos/base_repos_repository.dart";
import "package:vumc_demo_valle/objects/repo_object.dart";
import "../../api_clients/database_api_client.dart";

class ReposRepository implements BaseReposRepository {
  final GithubApiClient _githubApiClient = GithubApiClient();
  final DataBaseService _databaseService = DataBaseService();

  @override
  Future<List<RepoObject>> getRepos({required int page}) async {
    // Attempt to read from local SQL
    final List<RepoObject> localRepos = await readFromLocalSQL(page: page);

    if (localRepos.isNotEmpty) {
      return localRepos;
    } else {
      final List<RepoObject> fetchedRepos =
          (await _githubApiClient.fetchMostStarredPHPRepos(page: page))
              .repoObjects;
      await writeToLocalSQL(fetchedRepos);
      return fetchedRepos;
    }
  }

  @override
  Future<List<RepoObject>> writeToLocalSQL(List<RepoObject> repos) async {
    await _databaseService.insertRepos(repos);
    return repos;
  }

  @override
  Future<List<RepoObject>> readFromLocalSQL({required int page}) async {
    return await _databaseService.getAllRepos(page: page);
  }

  @override
  Future<void> flushSQL() async {
    await _databaseService.clearRepos();
  }
}
