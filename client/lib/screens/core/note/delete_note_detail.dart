import 'package:flutter/material.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:provider/provider.dart';

class DeleteNoteDetail extends StatefulWidget {
  final int index;
  const DeleteNoteDetail({Key? key, required this.index}) : super(key: key);

  @override
  State<DeleteNoteDetail> createState() => _DeleteNoteDetailState();
}

class _DeleteNoteDetailState extends State<DeleteNoteDetail> {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<NotesProvider>(context, listen: false)
        .noteDetails
        .details[widget.index]
        .data!
        .content
        .isEmpty) {
      return IconButton(
        onPressed: () {},
        // deleteNoteDetail(i),
        icon: const Icon(
          Icons.clear,
          size: 20,
        ),
        padding: const EdgeInsets.all(0),
        splashColor: Colors.transparent,
      );
    } else {
      return Container(
        width: 0,
      );
    }
  }
}
