import "package:flutter/material.dart";
import "package:vumc_demo_valle/objects/repo_object.dart";
import "package:vumc_demo_valle/user_interface/widgets/info_row.dart";
import "package:vumc_demo_valle/user_interface/widgets/url_widget.dart";
import "package:vumc_demo_valle/utilities/extensions/date_time_extensions.dart";

class RepoDetailScreen extends StatelessWidget {
  final RepoObject repoObject;

  const RepoDetailScreen({required this.repoObject, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repoObject.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              InfoRow(
                name: "Last Update",
                widget: Text(repoObject.lastPushDate.toFormatted()),
              ),
              InfoRow(
                name: "Url",
                widget: UrlWidget(url: repoObject.url, title: repoObject.name),
              ),  InfoRow(
                name: "Created",
                widget: Text(repoObject.createdDate.toFormatted()),
              ),  InfoRow(
                name: "Last Update",
                widget: Text(repoObject.lastPushDate.toFormatted()),
              ),InfoRow(
                name: "Stars",
                widget: Text(repoObject.stars.toString()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(repoObject.description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
