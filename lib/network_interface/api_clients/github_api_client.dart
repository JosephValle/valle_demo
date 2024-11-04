import "package:dio/dio.dart";
import "package:flutter/cupertino.dart";

import "../../objects/response/repos_response.dart";
import "../../utilities/const/constant.dart";

class GithubApiClient {
  final String baseUrl = "https://api.github.com";
  final Dio dio = Dio();

  GithubApiClient() {
    dio.options.headers["Accept"] = "application/vnd.github.v3+json";
    dio.options.headers["User-Agent"] = "VUMC";
  }

  Future<RepoObjectResponse> fetchMostStarredPHPRepos({
    required int page,
  }) async {
    final Map<String, dynamic> queryParameters = {
      "q": "language:php",
      "sort": "stars",
      "order": "desc",
      "per_page": Constants.queryCount,
      "page": page + 1,
    };
    final url = "$baseUrl/search/repositories";

    final response = await dio.get(url, queryParameters: queryParameters);

    if (response.statusCode == 200) {
      return RepoObjectResponse.fromJson(response.data);
    } else {
      debugPrint("Failed to load repositories");
      throw Exception("Failed to load repositories");
    }
  }
}
