import 'package:flutter/material.dart';
import 'package:noty_client/screens/core/folder/folder_view.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/utils/widget/divider_insert.dart';
import 'package:noty_client/widgets/list/folder_list_item.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/header_text.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

class FolderSection extends StatefulWidget {
  const FolderSection({Key? key}) : super(key: key);

  @override
  State<FolderSection> createState() => _FolderSectionState();
}

class _FolderSectionState extends State<FolderSection> {
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
          margin: 25,
          child: Column(
            children: dividerInsert(
                context
                    .watch<NotesProvider>()
                    .folders
                    .mapIndexed(
                      (index, folder) => GestureDetector(
                        onTap: () {
                          context
                              .read<NotesProvider>()
                              .readFolderNoteListJson(folder.folderId)
                              .then(
                                (_) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FolderDetailScreen(
                                        folderId: folder.folderId),
                                  ),
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
                                onPressed: (BuildContext cont) {
                                  context
                                      .read<NotesProvider>()
                                      .deleteFolder(folder.folderId, context);
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete_rounded,
                              ),
                            ],
                          ),
                          child: FolderListItem(
                              title: folder.name, count: folder.noteCount),
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
