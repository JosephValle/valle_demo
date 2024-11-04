
import "../repo_object.dart";

class RepoObjectResponse {
  final List<RepoObject> repoObjects;

  RepoObjectResponse({
    required this.repoObjects,
  });

  factory RepoObjectResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> items = json["items"];
    final List<RepoObject> repos = items.map((item) => RepoObject.fromJson(item)).toList();
    return RepoObjectResponse(repoObjects: repos);
  }
}