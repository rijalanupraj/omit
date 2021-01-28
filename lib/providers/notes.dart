// External Import
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

// Internal Import
import '../providers/note.dart';
import '../constants.dart';

class Notes with ChangeNotifier {
  List<Note> _items = [];

  List<Note> get items {
    return [..._items];
  }

  void getItem() async {
    final box = await Hive.openBox<Note>(kHiveNoteMainLocation);
    _items = box.values.toList();
    notifyListeners();
  }

  List<Note> get favoriteItems {
    return _items.where((note) {
      return note.isFavorite;
    }).toList();
  }

  void addNewNote(Note newNote) async {
    getItem();
    DateTime curretDateTime = DateTime.now();
    Note note = Note(
      id: curretDateTime.toString(),
      content: newNote.content,
      dateCreated: curretDateTime,
      dateUpdated: curretDateTime,
      title: newNote.title,
    );
    final box = await Hive.openBox<Note>(kHiveNoteMainLocation);
    box.add(note);

    // _items.insert(0, note); Prvious add
    notifyListeners();
  }

  Note findById(String id) {
    getItem();
    return _items.firstWhere((note) {
      return note.id == id;
    });
  }

  void updateNote(String id, Note newNote) async {
    getItem();
    final noteIndex = _items.indexWhere((note) => note.id == id);
    if (noteIndex >= 0) {
      Note note = Note(
          id: newNote.id,
          content: newNote.content,
          dateCreated: newNote.dateCreated,
          dateUpdated: DateTime.now(),
          title: newNote.title,
          isFavorite: newNote.isFavorite);
      final box = await Hive.openBox<Note>(kHiveNoteMainLocation);
      box.putAt(noteIndex, note);
      // _items[noteIndex] = note; // Previous update
      notifyListeners();
    }
  }

  Future<void> deleteNote(String id) async {
    final noteIndex = _items.indexWhere((note) => note.id == id);
    _items.removeAt(noteIndex);
    final box = await Hive.openBox<Note>(kHiveNoteMainLocation);
    await box.deleteAt(noteIndex);
    getItem();
    notifyListeners();
  }

  Future<void> toggleFavoriteHive(
      String id, Note currentNote, bool isFavorite) async {
    final noteIndex = _items.indexWhere((note) => note.id == id);
    if (noteIndex >= 0) {
      Note note = Note(
          id: currentNote.id,
          content: currentNote.content,
          dateCreated: currentNote.dateCreated,
          dateUpdated: currentNote.dateUpdated,
          title: currentNote.title,
          isFavorite: isFavorite);
      final box = await Hive.openBox<Note>(kHiveNoteMainLocation);
      box.putAt(noteIndex, note);
      // _items[noteIndex] = note; // Previous update
    }
  }
}
