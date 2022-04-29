import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noty_client/models/folder.dart';
import 'package:noty_client/models/notes.dart';
import 'package:noty_client/screens/core/me/me_detail.dart';
import 'package:noty_client/screens/core/me/me_overview.dart';
import 'package:noty_client/screens/start/login.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/header_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeFragement extends StatefulWidget {
  final List<Folder> folders;
  final List<Notes> notes;
  final TabController tabController;
  const MeFragement(
      {Key? key,
      required this.folders,
      required this.notes,
      required this.tabController})
      : super(key: key);

  @override
  State<MeFragement> createState() => _MeFragementState();
}

class _MeFragementState extends State<MeFragement> {
  late SharedPreferences prefs;

  deleteUserData() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Image.asset(
              "assets/images/profile.png",
              width: 150,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const HeaderText(text: "Yae Miko", size: Size.medium)),
          CurvedCard(
            child: Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                children: const [
                  MeDetail(title: "Name", content: "Yae Miko"),
                  MeDetail(title: "Email", content: "yae@miko.com"),
                  MeDetail(
                      title: "User ID", content: "507f1f77bcf86cd799439011"),
                ],
              ),
            ),
            margin: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MeOverview(
                icon: CupertinoIcons.pencil_outline,
                title: "Notes",
                count: widget.notes.length,
              ),
              MeOverview(
                icon: CupertinoIcons.folder_fill,
                title: "Folders",
                count: widget.folders.length,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              MeOverview(
                icon: CupertinoIcons.list_bullet,
                title: "Reminders",
                count: 5,
              ),
              MeOverview(
                icon: Icons.sell_rounded,
                title: "Tags",
                count: 23,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
                child: const Text("Sign Out"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () {
                  deleteUserData();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                }),
          )
        ],
      ),
    );
  }
}
