import "../../../objects/repo_object.dart";

abstract class BaseReposRepository {
  /// Fetches the most starred PHP repositories from the Github API
  Future<List<RepoObject>> getRepos({required int page});

  /// Writes the fetched repositories to the local SQL database
  Future<List<RepoObject>> writeToLocalSQL(List<RepoObject> repos);

  /// Reads the repositories from the local SQL database
  Future<List<RepoObject>> readFromLocalSQL({required int page});

  /// Clears the local SQL database
  Future<void> flushSQL();
}
