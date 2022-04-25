import 'package:flutter/material.dart';
import 'package:noty_client/screens/core/me/me_detail.dart';
import 'package:noty_client/screens/core/me/me_overview.dart';
import 'package:noty_client/screens/start/login.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/header_text.dart';

class MeFragement extends StatefulWidget {
  final int numNote;
  final int numFolder;
  const MeFragement({Key? key, required this.numFolder, required this.numNote})
      : super(key: key);

  @override
  State<MeFragement> createState() => _MeFragementState();
}

class _MeFragementState extends State<MeFragement> {
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
            child: Column(
              children: const [
                MeDetail(title: "Name", content: "Yae Miko"),
                MeDetail(title: "Email", content: "yae@miko.com"),
                MeDetail(title: "User ID", content: "507f1f77bcf86cd799439011"),
              ],
            ),
            margin: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MeOverview(
                icon: Icons.article_rounded,
                title: "Notes",
                count: widget.numNote,
              ),
              MeOverview(
                icon: Icons.folder_rounded,
                title: "Folders",
                count: widget.numFolder,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              MeOverview(
                icon: Icons.format_list_bulleted_rounded,
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
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
                child: const Text("Sign Out"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () {
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
