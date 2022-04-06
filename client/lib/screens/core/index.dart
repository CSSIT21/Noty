import 'package:flutter/material.dart' as material;
import 'package:motion_tab_bar_v2/motion-tab-bar.dart' as motion_tab_bar;

class CoreScreen extends material.StatefulWidget {
  const CoreScreen({material.Key? key}) : super(key: key);

  @override
  material.State<CoreScreen> createState() => _CoreScreenState();
}

class _CoreScreenState extends material.State<CoreScreen> with material.TickerProviderStateMixin {
  late material.TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = material.TabController(
      initialIndex: 1,
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
        title: const material.Text("Main"),
      ),
      bottomNavigationBar: motion_tab_bar.MotionTabBar(
        initialSelectedTab: "Home",
        useSafeArea: true, // default: true, apply safe area wrapper
        labels: const ["Dashboard", "Home", "Profile", "Settings"],
        icons: const [material.Icons.dashboard, material.Icons.home, material.Icons.people_alt, material.Icons.settings],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const material.TextStyle(
          fontSize: 12,
          color: material.Colors.black,
          fontWeight: material.FontWeight.w500,
        ),
        tabIconColor: material.Colors.blue[600],
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: material.Colors.blue[900],
        tabIconSelectedColor: material.Colors.white,
        tabBarColor: const material.Color(0xFFAFAFAF),
        onTabItemSelected: (int value) {
          setState(() {
            _tabController!.index = value;
          });
        },
      ),
      body: material.TabBarView(
        physics: const material.NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
        controller: _tabController,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const material.Center(
            child: material.Text("Dashboard"),
          ),
          const material.Center(
            child: material.Text("Home"),
          ),
          const material.Center(
            child: material.Text("Profile"),
          ),
          const material.Center(
            child: material.Text("Settings"),
          ),
        ],
      ),
    );
  }
}
