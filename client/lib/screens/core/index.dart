import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:motion_tab_bar_v2/motion-tab-bar.dart' as motion_tab_bar;
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/screens/core/fragment_me.dart';
import 'package:noty_client/screens/core/fragment_notes.dart';
import 'package:noty_client/widgets/typography/app_bar_text.dart';

class CoreScreen extends material.StatefulWidget {
  const CoreScreen({material.Key? key}) : super(key: key);

  @override
  material.State<CoreScreen> createState() => _CoreScreenState();
}

class _CoreScreenState extends material.State<CoreScreen>
    with material.TickerProviderStateMixin {
  late material.TabController _tabController;
  final List<String> titleList = ["Notes", "Reminders", "Tags", "Me"];
  final List<material.IconData> iconList = [
    material.Icons.article_rounded,
    material.Icons.format_list_bulleted_rounded,
    material.Icons.sell_rounded,
    material.Icons.person_rounded
  ];
  late String currentTitle;
  late TextEditingController _textController;

  @override
  void initState() {
    currentTitle = titleList[0];
    _tabController = material.TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _tabController.addListener(changeTitle);
    _textController = TextEditingController(text: '');
    super.initState();
  }

  void changeTitle() {
    setState(() {
      // get index of active tab & change current appbar title
      currentTitle = titleList[_tabController.index];
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  material.Widget build(material.BuildContext context) {
    return material.WillPopScope(
      onWillPop: () async => false,
      child: material.Scaffold(
        appBar: currentTitle == "Me"
            ? material.AppBar(
                title: AppBarText(text: currentTitle),
                centerTitle: true,
                automaticallyImplyLeading: false,
              )
            : material.AppBar(
                toolbarHeight: 85,
                title: SizedBox(
                  height: 65,
                  child: material.Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppBarText(text: currentTitle),
                      CupertinoSearchTextField(
                        controller: _textController,
                        style: TextStyle(
                            color: ThemeConstant.textColorPrimary,
                            fontSize: 16),
                        itemColor: ThemeConstant.colorPrimaryLight,
                      ),
                    ],
                  ),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
        bottomNavigationBar: motion_tab_bar.MotionTabBar(
          initialSelectedTab: "Notes",
          useSafeArea: true,
          // Apply safe area wrapper
          labels: const ["Notes", "Reminders", "Tags", "Me"],
          icons: iconList,
          tabSize: 50,
          tabBarHeight: 55,
          textStyle: material.TextStyle(
            fontSize: 12,
            color: ThemeConstant.colorPrimaryLight,
            fontWeight: material.FontWeight.w500,
          ),
          tabIconColor: const material.Color(0xff828282),
          tabIconSize: 28.0,
          tabIconSelectedSize: 26.0,
          tabSelectedColor: ThemeConstant.colorPrimaryLight,
          tabIconSelectedColor: ThemeConstant.textColorPrimary,
          tabBarColor: ThemeConstant.appBarColor,
          onTabItemSelected: (int value) {
            setState(() {
              _tabController.index = value;
            });
          },
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
          child: material.TabBarView(
            physics: const material
                .NeverScrollableScrollPhysics(), // Swipe navigation handling is not supported
            controller: _tabController,
            // ignore: prefer_const_literals_to_create_immutables
            children: const [
              NotesFragment(),
              material.Center(
                child: material.Text("Home"),
              ),
              material.Center(
                child: material.Text("Profile"),
              ),
              MeFragement(),
            ],
          ),
        ),
      ),
    );
  }
}
