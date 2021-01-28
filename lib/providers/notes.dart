// External Import
import 'package:flutter/foundation.dart';

// Internal Import
import '../providers/note.dart';

class Notes with ChangeNotifier {
  List<Note> _items = [];

  List<Note> get items {
    return [..._items];
  }

  List<Note> get favoriteItems {
    return _items.where((note) {
      return note.isFavorite;
    }).toList();
  }

  void addNewNote(Note newNote) {
    DateTime curretDateTime = DateTime.now();
    Note note = Note(
      id: curretDateTime.toString(),
      content: newNote.content,
      dateCreated: curretDateTime,
      dateUpdated: curretDateTime,
      title: newNote.title,
    );

    _items.insert(0, note);
    notifyListeners();
  }

  Note findById(String id) {
    return _items.firstWhere((note) {
      return note.id == id;
    });
  }

  void updateNote(String id, Note newNote) {
    final noteIndex = _items.indexWhere((note) => note.id == id);
    if (noteIndex >= 0) {
      print(newNote.id);
      print(newNote.isFavorite);
      Note note = Note(
          id: newNote.id,
          content: newNote.content,
          dateCreated: newNote.dateCreated,
          dateUpdated: DateTime.now(),
          title: newNote.title,
          isFavorite: newNote.isFavorite);
      _items[noteIndex] = note;
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _items.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
