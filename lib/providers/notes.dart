// External Import
import 'package:flutter/foundation.dart';

// Internal Import
import '../models/note.dart';

class Notes with ChangeNotifier {
  List<Note> _items = [];

  List<Note> get items {
    return [..._items];
  }

  void addNewNote(Note newNote) {
    _items.insert(0, newNote);
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
      _items[noteIndex] = newNote;
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _items.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
