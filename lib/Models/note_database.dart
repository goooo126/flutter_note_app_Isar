import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:note/Models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;
  // init database
  static Future<void> initialize() async {
    final dir = await getApplicationCacheDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  // list of notes
  final List<Note> currentNotes = [];

  // create
  Future<void> addNote(String textFromUser) async {
    final newNote = Note()..text = textFromUser;

    await isar.writeTxn(() => isar.notes.put(newNote));

    getAllNotes();
    notifyListeners();
  }

  // read
  Future<void> getAllNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();

    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  // delete
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await getAllNotes();
    notifyListeners();
  }

  // update
  Future<void> updateNote(int id, String newText) async {
    final oldNote = await isar.notes.get(id);

    if (oldNote != null) {
      oldNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(oldNote));
      await getAllNotes();
      notifyListeners();
    }
  }
}
