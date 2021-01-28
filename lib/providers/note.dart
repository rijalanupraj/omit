// External Import
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note with ChangeNotifier {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final DateTime dateCreated;
  @HiveField(4)
  final DateTime dateUpdated;
  @HiveField(5)
  bool isFavorite;

  Note({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.dateCreated,
    @required this.dateUpdated,
    this.isFavorite = false,
  });

  // void toggleFavorite() {
  //   isFavorite = !isFavorite;
  //   notifyListeners();
  // }
}
