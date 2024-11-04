class RepoObject {
  final String repositoryId;
  final String name;
  final String url;
  final DateTime createdDate;
  final DateTime lastPushDate;
  final String description;
  final int stars;

  RepoObject({
    required this.repositoryId,
    required this.name,
    required this.url,
    required this.createdDate,
    required this.lastPushDate,
    required this.description,
    required this.stars,
  });

  factory RepoObject.fromJson(Map<String, dynamic> json) {
    return RepoObject(
      repositoryId: json["id"].toString(),
      name: json["name"] ?? "",
      url: json["html_url"] ?? "",
      // parse from iso8601 string
      createdDate: DateTime.parse(json["created_at"]),
      lastPushDate: DateTime.parse(json["pushed_at"]),
      description: json["description"] ?? "No description available",
      stars: json["stargazers_count"] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": repositoryId,
      "name": name,
      "html_url": url,
      "created_at": createdDate.toIso8601String(),
      "pushed_at": lastPushDate.toIso8601String(),
      "description": description,
      "stargazers_count": stars,
    };
  }
}
