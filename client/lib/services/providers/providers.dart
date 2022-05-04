import 'package:flutter/foundation.dart';
import 'package:noty_client/models/response/me/me_infomation.dart';
import 'package:noty_client/models/response/notes/folder_data.dart';
import 'package:noty_client/models/response/notes/note_data.dart';
import 'package:noty_client/models/response/notes/note_detail_data.dart';

class NotesProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<FolderData> folders = [];
  List<NoteData> notes = [];
  NoteDetailData noteDetails =
      NoteDetailData(id: "", updatedAt: "", title: "", details: []);
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

  // void addNoteDetail(int index, String type) {
  //   notes[index].noteDetail.add(NoteDetail(type: type));
  //   notifyListeners();
  // }

  // void deleteNoteDetail(int noteIndex, int noteDetailIndex) {
  //   notes[noteIndex].noteDetail.removeAt(noteDetailIndex);
  //   notifyListeners();
  // }

  // void addFolder(String title) {
  //   folders.add(Folder(title: title, count: 0));
  //   notifyListeners();
  // }

  // void deleteFolder(int index) {
  //   folders.removeAt(index);
  //   notifyListeners();
  // }

  // void editFolderName(int index, String title) {
  //   folders[index].title = title;
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
