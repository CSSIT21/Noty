import 'package:flutter/material.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/header_text.dart';

class MeFragement extends StatefulWidget {
  const MeFragement({Key? key}) : super(key: key);

  @override
  State<MeFragement> createState() => _MeFragementState();
}

class _MeFragementState extends State<MeFragement> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text("Name"), Text("Yae Miko")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text("Email"), Text("mixko@nahee.com")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("User ID"),
                      Text("507f1f77bcf86cd799439011")
                    ],
                  )
                ],
              ),
              margin: 10)
        ],
      ),
    );
  }
}
