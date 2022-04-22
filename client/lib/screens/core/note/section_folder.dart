import 'package:flutter/material.dart';
import 'package:noty_client/models/folder.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/utils/widget/divider_insert.dart';
import 'package:noty_client/widgets/list/folder_list_item.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/header_text.dart';

class FolderSection extends StatelessWidget {
  final List<Folder> folders;

  const FolderSection({Key? key, required this.folders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: const HeaderText(text: "Folders", size: Size.medium),
          margin: const EdgeInsets.only(bottom: 20),
        ),
        CurvedCard(
          child: Column(
            children: dividerInsert(
                folders
                    .map(
                      (folder) => FolderListItem(
                          title: folder.title, count: folder.count),
                    )
                    .toList(),
                const Divider(
                  color: Color(0xff434345),
                  indent: 50,
                )),
          ),
        ),
      ],
    );
  }
}
