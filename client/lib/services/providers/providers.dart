import 'package:flutter/foundation.dart';
import 'package:noty_client/models/folder.dart';
import 'package:noty_client/models/note_detail.dart';
import 'package:noty_client/models/notes.dart';
import 'package:noty_client/models/response/me/me_infomation.dart';

class NotesProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<Folder> folders = [];
  List<Notes> notes = [];

  void setFoldersData(List<Folder> foldersData) {
    folders = foldersData;
    notifyListeners();
  }

  void setNotesData(List<Notes> notesData) {
    notes = notesData;
    notifyListeners();
  }

  void addNoteDetail(int index, String type) {
    notes[index].noteDetail.add(NoteDetail(type: type));
    notifyListeners();
  }

  void deleteNoteDetail(int noteIndex, int noteDetailIndex) {
    notes[noteIndex].noteDetail.removeAt(noteDetailIndex);
    notifyListeners();
  }

  void addFolder(String title) {
    folders.add(Folder(title: title, count: 0));
    notifyListeners();
  }

  void deleteFolder(int index) {
    folders.removeAt(index);
    notifyListeners();
  }

  void editFolderName(int index, String title) {
    folders[index].title = title;
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

  void setFirstname(String text) {
    meData.firstname = text;
    notifyListeners();
  }

  void setLastname(String text) {
    meData.lastname = text;
    notifyListeners();
  }
}
