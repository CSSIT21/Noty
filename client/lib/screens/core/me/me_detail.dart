import 'package:flutter/material.dart';

class MeDetail extends StatelessWidget {
  final String title;
  final String content;
  const MeDetail({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          SizedBox(
            width: 200,
            child: Text(
              content,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }
}
