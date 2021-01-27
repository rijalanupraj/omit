// Package Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Internal Import
import '../widgets/main_drawer.dart';
import '../providers/notes.dart';
import '../providers/note.dart';
import '../widgets/note_list_item.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home-screen';
  @override
  Widget build(BuildContext context) {
    final loadedNotes = Provider.of<Notes>(context).items;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Omit'),
        ),
        drawer: MainDrawer(),
        body: ListView.builder(
          itemCount: loadedNotes.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider<Note>.value(
            value: loadedNotes[i],
            child: NoteListItem(),
          ),
        ),
      ),
    );
  }
}
