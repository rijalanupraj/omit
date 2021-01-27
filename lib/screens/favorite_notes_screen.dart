// Package Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Internal Import
import '../providers/notes.dart';
import '../providers/note.dart';
import '../widgets/note_list_item.dart';

class FavoriteNotesScreen extends StatelessWidget {
  static const String routeName = '/favorite-notes-screen';
  @override
  Widget build(BuildContext context) {
    final loadedNotes = Provider.of<Notes>(context).favoriteItems;

    return ListView.builder(
      itemCount: loadedNotes.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider<Note>.value(
        value: loadedNotes[i],
        child: NoteListItem(),
      ),
    );
  }
}