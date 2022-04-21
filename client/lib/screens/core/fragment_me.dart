import 'package:flutter/material.dart';

class MeFragement extends StatefulWidget {
  const MeFragement({Key? key}) : super(key: key);

  @override
  State<MeFragement> createState() => _MeFragementState();
}

class _MeFragementState extends State<MeFragement> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [Text("Hi")],
    );
  }
}
