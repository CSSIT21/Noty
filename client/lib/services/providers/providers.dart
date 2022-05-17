import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:noty_client/constants/manifest.dart';
import 'package:noty_client/models/response/error/error_response.dart';
import 'package:noty_client/models/response/folder/note_list.dart';
import 'package:noty_client/models/response/info_response.dart';
import 'package:noty_client/models/response/me/me_infomation.dart';
import 'package:noty_client/models/response/notes/add_note_response.dart';
import 'package:noty_client/models/response/notes/folder_data.dart';
import 'package:noty_client/models/response/notes/note_data.dart';
import 'package:noty_client/models/response/notes/note_detail_data.dart';
import 'package:noty_client/models/response/notes/note_detail_details.dart';
import 'package:noty_client/models/response/notes/notes_response.dart';
import 'package:noty_client/models/response/reminder/add_reminder.dart';
import 'package:noty_client/models/response/reminder/independent_reminder.dart';
import 'package:noty_client/models/response/reminder/notes_reminder.dart';
import 'package:noty_client/models/response/reminder/reminder_in_note.dart';
import 'package:noty_client/models/response/reminder/reminder_response.dart';
import 'package:noty_client/models/response/tag/filter_tag_list.dart';
import 'package:noty_client/models/response/tag/search_tag_response.dart';
import 'package:noty_client/models/response/tag/tag_response.dart';
import 'package:noty_client/services/folder_service.dart';
import 'package:noty_client/services/me.dart';
import 'package:noty_client/services/notes_sevice.dart';
import 'package:noty_client/services/notification_sevice.dart';
import 'package:noty_client/services/reminder_service.dart';
import 'package:noty_client/services/tag_service.dart';
import 'package:noty_client/utils/compare_date.dart';
import 'package:noty_client/utils/parse_date.dart';

class NotesProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<FolderData> folders = [];
  List<NoteData> notes = [];
  NoteDetailData noteDetails = NoteDetailData(
      id: "", updatedAt: "", title: "", details: [], tags: [], folderId: "");
  List<NoteData> folderNoteList = [];
  int currentTextFieldIndex = -1;

  void setFoldersData(List<FolderData> data) {
    folders = data;
    notifyListeners();
  }

  void setNotesData(List<NoteData> data) {
    notes = data;
    notifyListeners();
  }

  void setNoteDetails(NoteDetailData data) {
    noteDetails = data;
    notifyListeners();
  }

  void setFolderNoteList(List<NoteData> data) {
    folderNoteList = data;
    notifyListeners();
  }

  Future<void> readJsonData() async {
    var response = await NoteService.getData();
    if (response is NotesResponse) {
      setFoldersData(response.data.folders);
      setNotesData(response.data.notes);
    }
    notifyListeners();
  }

  Future<void> readFolderNoteListJson(String folderId) async {
    var folderNoteList = await NoteService.getNoteListFolder(folderId);
    if (folderNoteList is NoteListFolderResponse) {
      setFolderNoteList(folderNoteList.data);
    }
    notifyListeners();
  }

  void clearNoteDetail() {
    noteDetails = NoteDetailData(
        id: "", updatedAt: "", title: "", details: [], tags: [], folderId: "");
    notifyListeners();
  }

  Future<void> addFolder(String title, BuildContext context) async {
    var response = await FolderService.add(title);
    if (response is InfoResponse) {
      readJsonData();
    } else if (response is ErrorResponse) {
      var error = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
        content: Text(response.message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
    notifyListeners();
  }

  void editFolder(String title, String folderId, BuildContext context) async {
    var response = await FolderService.edit(folderId, title);
    if (response is InfoResponse) {
      readJsonData();
    } else if (response is ErrorResponse) {
      var error = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(left: 15, right: 15),
        content: Text(response.message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
    notifyListeners();
  }

  void deleteFolder(String folderId, BuildContext context) async {
    var response = await FolderService.delete(folderId);
    if (response is InfoResponse) {
      readJsonData();
    } else if (response is ErrorResponse) {
      var error = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
        content: Text(response.message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
    notifyListeners();
  }

  Future<void> readNoteDetailJson(String noteId) async {
    var noteDetails = await NoteService.getNoteDetail(noteId);
    if (noteDetails is NoteDetailResponse) {
      setNoteDetails(noteDetails.data);
    }
    notifyListeners();
  }

  Future<dynamic> addNote(String folderId, BuildContext context) async {
    var response = await NoteService.addNote(folderId);
    if (response is AddNoteResponse) {
      readJsonData();
      return response.data.noteId;
    } else if (response is ErrorResponse) {
      var error = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
        content: Text(response.message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
      return response.success;
    }
    notifyListeners();
  }

  Future<void> deleteNote(String noteId, BuildContext context) async {
    var response = await NoteService.deleteNote(noteId);
    if (response is InfoResponse) {
      readJsonData();
    } else if (response is ErrorResponse) {
      var error = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
        content: Text(response.message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
    notifyListeners();
  }

  Future<void> moveNote(
      String folderId, String noteId, BuildContext context) async {
    var response = await NoteService.moveNote(folderId, noteId);
    if (response is InfoResponse) {
      readJsonData();
    } else if (response is ErrorResponse) {
      var error = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(left: 15, right: 15),
        content: Text(response.message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
    notifyListeners();
  }

  Future<void> editNote(BuildContext context) async {
    Map<String, dynamic> details = {
      'folder_id': noteDetails.folderId,
      'note_id': noteDetails.id,
      'title': noteDetails.title,
      'note_details': noteDetails.details,
    };
    var response = await NoteService.editNote(details);
    if (response is InfoResponse) {
      readNoteDetailJson(noteDetails.id);
    } else if (response is ErrorResponse) {
      var error = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
        content: Text(response.message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
    notifyListeners();
  }

  void editNoteText(int index, String text) {
    noteDetails.details[index].data!.content = text;
    notifyListeners();
  }

  void addNoteDetail(String noteId, String type) {
    noteDetails.details
        .add(NoteDetailDataDetails(type: type, data: DetailsData(content: "")));
    notifyListeners();
  }

  void deleteNoteDetail(int index) {
    noteDetails.details.removeAt(index);
    notifyListeners();
  }

  void setCurrentTfIndex(int index) {
    currentTextFieldIndex = index;
    notifyListeners();
  }

  void addNoteDetailReminder(String noteId, String reminderId) {
    noteDetails.details.add(NoteDetailDataDetails(
        type: "reminder", data: DetailsData(content: reminderId)));
    notifyListeners();
  }

  void deleteReminderFromNote(String reminderId, BuildContext context) {
    noteDetails.details
        .removeWhere((element) => element.data!.content == reminderId);
    editNote(context);
    notifyListeners();
  }
}

class ProfileProvider with ChangeNotifier, DiagnosticableTreeMixin {
  MeData meData = MeData(
      email: "",
      firstname: "",
      lastname: "",
      pictureId: "",
      userId: "",
      notes: 0,
      folders: 0,
      reminders: 0,
      tags: 0);

  String email = '';

  void setMeData(MeData data) {
    meData = data;
    notifyListeners();
  }

  void readMeJson() async {
    var meResponse = await ProfileService.getProfile();
    if (meResponse is MeResponse) {
      setMeData(meResponse.data);
    }
    notifyListeners();
  }

  void setFirstname(String text) {
    meData.firstname = text;
    notifyListeners();
  }

  void setLastname(String text) {
    meData.lastname = text;
    notifyListeners();
  }

  void setResetEmail(String text) {
    email = text;
    notifyListeners();
  }
}

class ReminderProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<IndependentReminder> independentReminder = [];
  List<NoteReminders> noteReminders = [];

  void setIndependentReminder(List<IndependentReminder> data) {
    independentReminder = data;
    notifyListeners();
  }

  void setNoteReminders(List<NoteReminders> data) {
    noteReminders = data;
    notifyListeners();
  }

  Future<void> readReminderJson() async {
    var response = await ReminderService.getReminder();
    if (response is ReminderResponse) {
      setIndependentReminder(response.data.independentReminders);
      setNoteReminders(response.data.notesReminders);
    }
    notifyListeners();
  }

  Future<dynamic> addReminder(String title, String description,
      String remindDate, BuildContext context) async {
    if (remindDate != "0001-01-01T00:00:00.000Z") {
      remindDate = remindDate + "Z";
    }
    var response =
        await ReminderService.addReminder(title, description, remindDate);
    if (response is AddReminderResponse) {
      readReminderJson().then((_) => {
            setLocalReminder(),
          });
      return response.data.reminderId;
    } else if (response is ErrorResponse) {
      var error = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
        content: Text(response.message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
      return response.success;
    }
    notifyListeners();
  }

  void editReminder(String title, String description, String remindDate,
      String reminderId, bool success, BuildContext context) async {
    if (!remindDate.endsWith("Z")) {
      remindDate = remindDate + "Z";
    }
    var response = await ReminderService.editReminder(
        title, description, reminderId, remindDate, success);
    if (response is InfoResponse) {
      readReminderJson().then((_) => {
            setLocalReminder(),
          });
    } else if (response is ErrorResponse) {
      var error = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
        content: Text(response.message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
    notifyListeners();
  }

  void deleteReminder(String reminderId, BuildContext context) async {
    var response = await ReminderService.deleteReminder(reminderId);
    if (response is InfoResponse) {
      readReminderJson().then((_) => {
            setLocalReminder(),
          });
    } else if (response is ErrorResponse) {
      var error = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
        content: Text(response.message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
    notifyListeners();
  }

  void updateReminderProgress(
      String reminderId, bool success, BuildContext context) async {
    var response = await ReminderService.updateReminder(reminderId, success);
    if (response is InfoResponse) {
      readReminderJson().then((_) => {
            setLocalReminder(),
          });
    } else if (response is ErrorResponse) {
      var error = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
        content: Text(response.message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
    notifyListeners();
  }

  Future<dynamic> getReminderInNoteTitle(
      String reminderId, BuildContext context) async {
    var response = await ReminderService.getReminderInfo(reminderId);
    if (response is ReminderInNote) {
      return response;
    } else if (response is ErrorResponse) {
      var error = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
        content: Text(response.message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
    notifyListeners();
  }

  void setLocalReminder() {
    for (var i = 0; i < independentReminder.length; i++) {
      if (compareDate(parseDate(independentReminder[i].remindDate)) &&
          !independentReminder[i].success) {
        NotificationService.showScheduledNotification(
            id: int.parse(independentReminder[i].reminderId.substring(8, 15),
                radix: 16),
            title: ManifestConstant.notificationTitle,
            body: independentReminder[i].title,
            scheduledDate: parseDate(independentReminder[i].remindDate));
      }
    }
    for (var j = 0; j < noteReminders.length; j++) {
      for (var k = 0; k < noteReminders[j].reminders.length; k++) {
        if (compareDate(parseDate(noteReminders[j].reminders[k].remindDate)) &&
            !noteReminders[j].reminders[k].success) {
          NotificationService.showScheduledNotification(
            id: int.parse(noteReminders[j].reminders[k].id.substring(8, 15),
                radix: 16),
            title: ManifestConstant.notificationTitle,
            body: noteReminders[j].title,
            scheduledDate: parseDate(noteReminders[j].reminders[k].remindDate),
          );
        }
      }
    }
    notifyListeners();
  }
}

class TagProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<String> tagname = [];
  List<TagListData> tagList = [];
  List<FilterTag> filterTagList = [];
  List<NoteData> filteredNote = [];

  void setTagName(List<String> data) {
    tagname = data;
    filterTagList.clear();
    for (var i = 0; i < data.length; i++) {
      filterTagList.add(FilterTag(name: data[i], selected: false));
    }
    notifyListeners();
  }

  void setTagList(List<TagListData> data) {
    tagList = data;
    notifyListeners();
  }

  void setFilteredNote(List<NoteData> data) {
    filteredNote = data;
    notifyListeners();
  }

  Future<void> readTagJson() async {
    var response = await TagService.getTagData();
    if (response is TagResponse) {
      setTagName(response.data.tagName);
      setTagList(response.data.tagList);
    }
    notifyListeners();
  }

  Future<void> searchTag(String tagName) async {
    var response = await TagService.searchTag(tagName);
    if (response is SearchTagResponse) {
      setFilteredNote(response.notes);
      tagList.clear();
      tagList.add(TagListData(name: tagName, notes: response.notes));
    }

    notifyListeners();
  }
}
