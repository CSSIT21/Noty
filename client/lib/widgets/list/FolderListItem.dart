import 'package:flutter/material.dart';

class FolderListItem extends StatelessWidget {
  final String name;
  final int count;

  const FolderListItem({Key? key, required this.name, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(count.toString()),
        )
      ],
    );
  }
}
