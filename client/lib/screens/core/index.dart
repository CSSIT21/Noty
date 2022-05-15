import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:motion_tab_bar_v2/motion-tab-bar.dart' as motion_tab_bar;
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/models/response/error/error_response.dart';
import 'package:noty_client/models/response/me/me_infomation.dart';
import 'package:noty_client/models/response/notes/notes_response.dart';
import 'package:noty_client/screens/core/me/me.dart';
import 'package:noty_client/screens/core/me/me_edit.dart';
import 'package:noty_client/screens/core/note/note.dart';
import 'package:noty_client/screens/core/reminder/reminder.dart';
import 'package:noty_client/screens/core/tag/tag.dart';
import 'package:noty_client/services/me.dart';
import 'package:noty_client/services/notes_sevice.dart';
import 'package:noty_client/services/notification_sevice.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/widgets/typography/appbar_text.dart';
import 'package:provider/provider.dart';

import '../../services/notes_sevice.dart';

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
    CupertinoIcons.pencil_outline,
    CupertinoIcons.list_bullet,
    material.Icons.sell_rounded,
    CupertinoIcons.person_fill,
  ];
  late String currentTitle;
  late TextEditingController _textController;

  void changeTitle() {
    setState(() {
      // get index of active tab & change current appbar title
      currentTitle = titleList[_tabController.index];
    });
  }

  Future<void> _readJson() async {
    var meResponse = await ProfileService.getProfile();
    var notesDataResponse = await NoteService.getData();
    context.read<ReminderProvider>().readReminderJson();
    context.read<TagProvider>().readTagJson();
    if (notesDataResponse is NotesResponse) {
      context
          .read<NotesProvider>()
          .setFoldersData(notesDataResponse.data.folders);
      context.read<NotesProvider>().setNotesData(notesDataResponse.data.notes);
    }
    if (meResponse is ErrorResponse) {
      var error = material.SnackBar(
        behavior: material.SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
        content: Text(meResponse.message),
        action: material.SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      material.ScaffoldMessenger.of(context).showSnackBar(error);
    } else if (meResponse is MeResponse) {
      context.read<ProfileProvider>().setMeData(meResponse.data);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

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
    _readJson();

    super.initState();
    NotificationService.init(initScheduled: true);
    listenNotifications();
    NotificationService.showNotification(
        title: "Reminder", body: "This is a notification from note page");
  }

  void listenNotifications() =>
      NotificationService.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) {
    // setState(() {
    //   _tabController.index = 1;
    // });
  }

  @override
  material.Widget build(material.BuildContext context) {
    MeData meData = context.watch<ProfileProvider>().meData;
    return material.WillPopScope(
      onWillPop: () async => false,
      child: material.Scaffold(
        appBar: currentTitle == "Me"
            ? material.AppBar(
                title: AppBarText(text: currentTitle),
                centerTitle: true,
                automaticallyImplyLeading: false,
                actions: [
                  material.TextButton(
                    onPressed: () {
                      material.Navigator.push(
                        context,
                        material.MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                            firstname: meData.firstname,
                            lastname: meData.lastname,
                          ),
                        ),
                      );
                    },
                    style: material.ElevatedButton.styleFrom(
                      splashFactory: material.NoSplash.splashFactory,
                    ),
                    child: const Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              )
            : material.AppBar(
                // toolbarHeight: 85,
                // title: SizedBox(
                //   height: 65,
                //   child: material.Column(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       AppBarText(text: currentTitle),
                //       CupertinoSearchTextField(
                //         controller: _textController,
                //         style: TextStyle(
                //             color: ThemeConstant.textColorPrimary,
                //             fontSize: 14),
                //         itemColor: ThemeConstant.colorPrimaryLight,
                //       ),
                //     ],
                //   ),
                // ),
                title: AppBarText(text: currentTitle),
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
          padding: currentTitle != "Tags"
              ? const EdgeInsets.fromLTRB(20, 0, 20, 0)
              : null,
          child: material.TabBarView(
            physics: const material
                .NeverScrollableScrollPhysics(), // Swipe navigation handling is not supported
            controller: _tabController,
            children: const [
              NotesFragment(),
              ReminderFragment(),
              TagFragment(),
              MeFragement(),
            ],
          ),
        ),
      ),
    );
  }
}
