import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Internal Import
import '../providers/notes.dart';
import '../providers/note.dart';
import '../widgets/archive_note_item.dart';
import '../widgets/main_drawer.dart';

class ArchiveNoteScreen extends StatelessWidget {
  static const String routeName = '/archive-notes-screen';
  @override
  Widget build(BuildContext context) {
    Provider.of<Notes>(context).getArchiveNotes();
    final allNotes = Provider.of<Notes>(context).archiveNotes;
    final loadedNotes = List.from(allNotes.reversed);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Archvies'),
        ),
        drawer: MainDrawer(),
        body: ListView.builder(
          itemCount: loadedNotes.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider<Note>.value(
            value: loadedNotes[i],
            child: ArchiveNoteItem(),
          ),
        ),
      ),
    );
  }
}
