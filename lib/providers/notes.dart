// External Import
import 'package:flutter/foundation.dart';

// Internal Import
import '../models/note.dart';

class Notes with ChangeNotifier {
  List<Note> _items = [];

  List<Note> get items {
    return [..._items];
  }

  void addNewNotes(
    String title,
    String content,
  ) {
    var newNote = Note(
      title: title,
      dateCreated: DateTime.now(),
      content: content,
      id: DateTime.now().toString(),
      dateUpdated: DateTime.now(),
    );
    _items.insert(0, newNote);
    notifyListeners();
  }

  Note findById(String id) {
    return _items.firstWhere((note) {
      return note.id == id;
    });
  }
}
