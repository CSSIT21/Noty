import 'package:flutter/material.dart';
import 'package:noty_client/widgets/leading_button.dart';
import 'package:noty_client/widgets/typography/appbar_text.dart';

class FolderDetailScreen extends StatefulWidget {
  final String folderName;
  const FolderDetailScreen({Key? key, required this.folderName})
      : super(key: key);

  @override
  State<FolderDetailScreen> createState() => _FolderDetailScreenState();
}

class _FolderDetailScreenState extends State<FolderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: widget.folderName),
        centerTitle: true,
        leadingWidth: 100,
        leading: const LeadingButton(
          text: "Folders",
        ),
      ),
    );
  }
}
