// External Import
import 'package:flutter/material.dart';

class Note with ChangeNotifier {
  final String id;
  final String title;
  final String content;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  bool isFavorite;

  Note({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.dateCreated,
    @required this.dateUpdated,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
