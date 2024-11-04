import "package:flutter/material.dart";
import "package:vumc_demo_valle/objects/repo_object.dart";

import "../repo_detail_screen.dart";

class RepoTile extends StatelessWidget {
  final RepoObject repoObject;

  const RepoTile({required this.repoObject, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RepoDetailScreen(repoObject: repoObject),
        ),
      ),
      title: Text(
        repoObject.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(repoObject.description),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("${repoObject.stars} "),
          const Icon(Icons.star),
        ],
      ),
    );
  }
}
