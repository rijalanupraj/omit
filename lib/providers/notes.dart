// External Import
import 'package:flutter/foundation.dart';

// Internal Import
import '../providers/note.dart';

class Notes with ChangeNotifier {
  List<Note> _items = [
    Note(
        id: 'jlkldjsf',
        title: 'This is first note',
        dateCreated: DateTime.now(),
        dateUpdated: DateTime.now(),
        content: 'This is isjdfl jlkjdfslkf ijfoisd'),
    Note(
        id: 'jlfsdfsf',
        title: 'This is second note',
        dateCreated: DateTime.now(),
        dateUpdated: DateTime.now(),
        content: 'fsdf fsdjflk  jfsdjf jlkfjsd lj lkjfds lkj')
  ];

  List<Note> get items {
    return [..._items];
  }

  List<Note> get favoriteItems {
    return _items.where((note) {
      return note.isFavorite;
    }).toList();
  }

  void addNewNote(Note newNote) {
    Note note = Note(
      id: DateTime.now().toString(),
      content: newNote.content,
      dateCreated: DateTime.now(),
      dateUpdated: DateTime.now(),
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
      _items[noteIndex] = newNote;
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _items.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
