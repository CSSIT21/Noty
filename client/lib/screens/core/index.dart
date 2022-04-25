import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:motion_tab_bar_v2/motion-tab-bar.dart' as motion_tab_bar;
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/models/folder.dart';
import 'package:noty_client/models/note_detail.dart';
import 'package:noty_client/models/notes.dart';
import 'package:noty_client/screens/core/me/me.dart';
import 'package:noty_client/screens/core/note/note.dart';
import 'package:noty_client/screens/core/reminder/reminder.dart';
import 'package:noty_client/screens/core/tag/tag.dart';
import 'package:noty_client/widgets/typography/appbar_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  List<Folder> _folders = [];
  List<Notes> _notes = [];

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

  Future<void> _readJson() async {
    final response = await http.get(
        Uri.parse('https://mock-noty.mixkoap.com/test-payload.json'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        });
    final Map<String, dynamic> datas = await json.decode(response.body);

    List<dynamic> foldersData = datas["folders"];
    List<dynamic> notesData = datas["notes"];

    List<Folder> tempFolders = foldersData.map((folder) {
      return Folder(
          folderId: folder["folder_id"],
          title: folder["title"],
          count: folder["count"]);
    }).toList();

    List<Notes> tempNotes = notesData.map((note) {
      List<dynamic> tempNoteDetail = note["note_detail"];
      List<NoteDetail> noteDetails = tempNoteDetail.map((noteDetail) {
        List<dynamic> tempTags = noteDetail["tags"] ?? [];
        List<String> tags = tempTags.map((tag) => tag.toString()).toList();
        return NoteDetail(
            type: noteDetail["type"],
            detail: noteDetail["detail"] ?? "",
            createdAt: noteDetail["created_at"] ?? "",
            reminderId: noteDetail["reminder_id"] ?? "",
            tags: tags);
      }).toList();
      return Notes(
        id: note["id"],
        userId: note["user_id"],
        title: note["title"],
        folderId: note["folder_id"],
        createdAt: note["created_at"],
        noteDetail: noteDetails,
      );
    }).toList();

    if (mounted) {
      setState(() {
        _folders = tempFolders;
        _notes = tempNotes;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  material.Widget build(material.BuildContext context) {
    _readJson();

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
                    onPressed: () {},
                    child: const Text("Edit"),
                  )
                ],
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
                            fontSize: 14),
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
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: material.TabBarView(
            physics: const material
                .NeverScrollableScrollPhysics(), // Swipe navigation handling is not supported
            controller: _tabController,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              NotesFragment(
                folders: _folders,
                notes: _notes,
              ),
              const ReminderFragment(),
              TagFragment(
                notes: _notes,
              ),
              MeFragement(
                numFolder: _folders.length,
                numNote: _notes.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
