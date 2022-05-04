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
import 'package:noty_client/models/response/notes/notes_response.dart';
import 'package:noty_client/services/folder_service.dart';
import 'package:noty_client/services/notes_sevice.dart';

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

  void readJsonData() async {
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

  void readNoteDetailJson(String noteId) async {
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

  void deleteNote(String noteId, BuildContext context) async {
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

  void moveNote(String folderId, String noteId, BuildContext context) async {
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

  // void addNoteDetail(int index, String type) {
  //   notes[index].noteDetail.add(NoteDetail(type: type));
  //   notifyListeners();
  // }

  // void deleteNoteDetail(int noteIndex, int noteDetailIndex) {
  //   notes[noteIndex].noteDetail.removeAt(noteDetailIndex);
  //   notifyListeners();
  // }
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

  void setFirstname(String text) {
    meData.firstname = text;
    notifyListeners();
  }

  void setLastname(String text) {
    meData.lastname = text;
    notifyListeners();
  }
}
