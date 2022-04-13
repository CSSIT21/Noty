import 'package:flutter/material.dart' as material;
import 'package:motion_tab_bar_v2/motion-tab-bar.dart' as motion_tab_bar;
import 'package:noty_client/screens/core/fragment_notes.dart';

class CoreScreen extends material.StatefulWidget {
  const CoreScreen({material.Key? key}) : super(key: key);

  @override
  material.State<CoreScreen> createState() => _CoreScreenState();
}

class _CoreScreenState extends material.State<CoreScreen>
    with material.TickerProviderStateMixin {
  late material.TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = material.TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  material.Widget build(material.BuildContext context) {
    return material.Scaffold(
      appBar: material.AppBar(
        title: const material.Text("Noty"),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: motion_tab_bar.MotionTabBar(
        initialSelectedTab: "Notes",
        useSafeArea: true,
        // Apply safe area wrapper
        labels: const ["Notes", "Reminders", "Tags", "Me"],
        icons: const [
          //todo: Change logo
          material.Icons.dashboard,
          material.Icons.home,
          material.Icons.people_alt,
          material.Icons.settings
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const material.TextStyle(
          fontSize: 12,
          color: material.Color(0xFFBA68C8),
          fontWeight: material.FontWeight.w500,
        ),
        tabIconColor: material.Colors.purple[300],
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: material.Colors.purple[300],
        tabIconSelectedColor: material.Colors.white,
        tabBarColor: const material.Color(0xFFFFFFFF),
        onTabItemSelected: (int value) {
          setState(() {
            _tabController.index = value;
          });
        },
      ),
      body: material.TabBarView(
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
          material.Center(
            child: material.Text("Settings"),
          ),
        ],
      ),
    );
  }
}
