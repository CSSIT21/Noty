import 'package:flutter/material.dart';
import 'package:noty_client/models/folder.dart';
import 'package:noty_client/models/notes.dart';
import 'package:noty_client/screens/core/folder/folder_view.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/utils/widget/divider_insert.dart';
import 'package:noty_client/widgets/list/folder_list_item.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/header_text.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:collection/collection.dart';

class FolderSection extends StatelessWidget {
  final List<Folder> folders;
  final List<Notes> notes;

  const FolderSection({Key? key, required this.folders, required this.notes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: const HeaderText(text: "All Notes", size: Size.medium),
          margin: const EdgeInsets.only(bottom: 20),
        ),
        CurvedCard(
          margin: 25,
          child: Column(
            children: dividerInsert(
                folders
                    .mapIndexed(
                      (index, folder) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FolderDetailScreen(
                                  folderName: folder.title, notes: notes),
                            ),
                          );
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (BuildContext context) {},
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete_rounded,
                              ),
                            ],
                          ),
                          child: FolderListItem(
                              title: folder.title, count: folder.count),
                        ),
                      ),
                    )
                    .toList(),
                const Divider(
                  color: Color(0xff434345),
                  indent: 50,
                  height: 1,
                )),
          ),
        ),
      ],
    );
  }
}
