import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/screens/core/folder/folder_move_list.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/utils/widget/divider_insert.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/appbar_text.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class FolderMoveDialog extends StatefulWidget {
  final String folderId;
  final String noteId;
  const FolderMoveDialog(
      {Key? key, required this.folderId, required this.noteId})
      : super(key: key);

  @override
  State<FolderMoveDialog> createState() => _FolderMoveDialogState();
}

class _FolderMoveDialogState extends State<FolderMoveDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarText(text: "Select a folder"),
        centerTitle: true,
        leadingWidth: 100,
        toolbarHeight: 60,
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Text(
                  "Cancel",
                  style: TextStyle(
                      fontSize: 17, color: ThemeConstant.colorPrimaryLight),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 18, 12, 18),
        child: CurvedCard(
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
                            .moveNote(folder.folderId, widget.noteId, context);
                        context
                            .read<NotesProvider>()
                            .readFolderNoteListJson(widget.folderId);
                        Navigator.pop(context);
                      },
                      child: FolderMoveList(
                        title: folder.name,
                        currentFolderId: widget.folderId,
                        folderId: folder.folderId,
                      ),
                    ),
                  )
                  .toList(),
              const Divider(
                color: Color(0xff434345),
                indent: 50,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
