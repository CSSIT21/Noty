import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
import 'package:noty_client/models/response/tag/tag_response.dart';
import 'package:noty_client/services/folder_service.dart';
import 'package:noty_client/services/me.dart';
import 'package:noty_client/services/notes_sevice.dart';
import 'package:noty_client/services/reminder_service.dart';
import 'package:noty_client/services/tag_service.dart';

class NotesProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<FolderData> folders = [];
  List<NoteData> notes = [];
  NoteDetailData noteDetails = NoteDetailData(
      id: "", updatedAt: "", title: "", details: [], tags: [], folderId: "");
  List<NoteData> folderNoteList = [];

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

  void readFolderNoteListJson(String folderId) async {
    var folderNoteList = await NoteService.getNoteListFolder(folderId);
    if (folderNoteList is NoteListFolderResponse) {
      setFolderNoteList(folderNoteList.data);
    }
    notifyListeners();
  }

  void addFolder(String title, BuildContext context) async {
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
      readReminderJson();
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
      String reminderId, BuildContext context) async {
    if (!remindDate.endsWith("Z")) {
      remindDate = remindDate + "Z";
    }
    var response = await ReminderService.editReminder(
        title, description, reminderId, remindDate);
    if (response is InfoResponse) {
      readReminderJson();
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
      readReminderJson();
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
      readReminderJson();
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
}

class TagProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<String> tagname = [];
  List<TagListData> tagList = [];

  void setTagName(List<String> data) {
    tagname = data;
    notifyListeners();
  }

  void setTagList(List<TagListData> data) {
    tagList = data;
    notifyListeners();
  }

  void readTagJson() async {
    var response = await TagService.getTagData();
    if (response is TagResponse) {
      setTagName(response.data.tagName);
      setTagList(response.data.tagList);
    }
    notifyListeners();
  }
}
