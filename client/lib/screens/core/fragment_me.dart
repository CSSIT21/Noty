import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:noty_client/models/folder.dart';

class MeFragement extends StatefulWidget {
  const MeFragement({Key? key}) : super(key: key);

  @override
  State<MeFragement> createState() => _MeFragementState();
}

class _MeFragementState extends State<MeFragement> {
  List<Folder> folders = [];
  Future<void> _readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/items_sample.json');
    final List<Map<String, dynamic>> datas = await json.decode(response);
    List<Folder> temp = datas.map((data) {
      return Folder(id: data["id"], name: data["name"], count: data["count"]);
    }).toList();
    setState(() {
      folders = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    _readJson();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(folders[0].name)],
    );
  }
}
