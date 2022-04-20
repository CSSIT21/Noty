import 'package:flutter/material.dart';

class TagLabel extends StatelessWidget {
  const TagLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff252525),
        borderRadius: BorderRadius.circular(5),
      ),
      width: 45,
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 3),
            child: const Icon(
              Icons.sell_rounded,
              size: 10,
              color: Color(0xff828282),
            ),
          ),
          const Text(
            "Tag",
            style: TextStyle(fontSize: 10, color: Color(0xff828282)),
          )
        ],
      ),
    );
  }
}
