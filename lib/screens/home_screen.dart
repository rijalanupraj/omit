// Package Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Internal Import
import '../widgets/main_drawer.dart';
import '../providers/notes.dart';
import '../widgets/note_list_item.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home-screen';
  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context).items;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Omit'),
        ),
        drawer: MainDrawer(),
        body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return NoteListItem(
              id: notes[index].id,
              title: notes[index].title,
              content: notes[index].content,
              isFavorite: notes[index].isFavorite,
              dateCreated: notes[index].dateCreated,
              dateUpdated: notes[index].dateUpdated,
            );
          },
        ),
      ),
    );
  }
}
