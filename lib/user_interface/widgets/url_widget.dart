import "package:flutter/material.dart";
import "package:url_launcher/url_launcher_string.dart";

class UrlWidget extends StatelessWidget {
  final String? title;
  final String url;

  const UrlWidget({required this.url, this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async =>
          launchUrlString(url, mode: LaunchMode.externalApplication),
      child: Text(title ?? url),
    );
  }
}
