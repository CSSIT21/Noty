import 'package:flutter/material.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/header_text.dart';

class MeOverview extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;
  const MeOverview(
      {Key? key, required this.icon, required this.title, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth / 2 - 30,
      child: CurvedCard(
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      child: Icon(
                        icon,
                        size: 32,
                      ),
                    ),
                    Text(title)
                  ],
                ),
                HeaderText(text: count.toString(), size: Size.medium),
              ],
            ),
          ),
          margin: 20),
    );
  }
}
