import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noty_client/models/response/me/me_infomation.dart';

import 'package:noty_client/screens/core/me/me_detail.dart';
import 'package:noty_client/screens/core/me/me_overview.dart';
import 'package:noty_client/screens/start/login.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/header_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeFragement extends StatefulWidget {
  const MeFragement({Key? key}) : super(key: key);

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
    MeData meData = context.watch<ProfileProvider>().meData;

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
              child: HeaderText(
                  text: meData.firstname + " " + meData.lastname,
                  size: Size.medium)),
          CurvedCard(
            child: Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                children: [
                  MeDetail(
                    title: "Name",
                    content: meData.firstname + " " + meData.lastname,
                  ),
                  MeDetail(title: "Email", content: meData.email),
                  MeDetail(title: "User ID", content: meData.userId),
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
                count: meData.notes,
              ),
              MeOverview(
                icon: CupertinoIcons.folder_fill,
                title: "Folders",
                count: meData.folders,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MeOverview(
                icon: CupertinoIcons.list_bullet,
                title: "Reminders",
                count: meData.reminders,
              ),
              MeOverview(
                icon: Icons.sell_rounded,
                title: "Tags",
                count: meData.tags,
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
