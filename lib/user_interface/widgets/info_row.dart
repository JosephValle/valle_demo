import "package:flutter/material.dart";

class InfoRow extends StatelessWidget {
  final String name;
  final Widget widget;

  const InfoRow({required this.name, required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$name:", style: const TextStyle(fontWeight: FontWeight.bold)),
          widget,
        ],
      ),
    );
  }
}
