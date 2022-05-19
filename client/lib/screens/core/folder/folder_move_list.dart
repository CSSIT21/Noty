import 'package:flutter/cupertino.dart';

class FolderMoveList extends StatefulWidget {
  final String title;
  final String currentFolderId;
  final String folderId;
  const FolderMoveList(
      {Key? key,
      required this.title,
      required this.currentFolderId,
      required this.folderId})
      : super(key: key);

  @override
  State<FolderMoveList> createState() => _FolderMoveListState();
}

class _FolderMoveListState extends State<FolderMoveList> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(
                  CupertinoIcons.folder_fill,
                  size: 24,
                ),
              ),
              SizedBox(
                width: screenWidth / 1.8,
                child: Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          widget.currentFolderId == widget.folderId
              ? const Icon(
                  CupertinoIcons.check_mark,
                  size: 16,
                )
              : Container(),
        ],
      ),
    );
  }
}
