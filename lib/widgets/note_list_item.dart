// External Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Internal Import
import '../providers/notes.dart';
import '../providers/note.dart';
import '../screens/edit_note_screen.dart';

class NoteListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentNote = Provider.of<Note>(context, listen: false);
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(EditNoteScreen.routeName, arguments: currentNote.id),
      child: Dismissible(
        key: ValueKey(currentNote.id),
        background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40.0,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(
            right: 20,
          ),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to delete the note permanantely?'),
              actions: [
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                ),
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                ),
              ],
            ),
          );
        },
        onDismissed: (direction) {
          Provider.of<Notes>(context, listen: false).deleteNote(currentNote.id);
        },
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              title: Text(currentNote.title),
              subtitle: Text(currentNote.content),
              trailing: Consumer<Note>(
                builder: (context, note, child) {
                  return IconButton(
                    icon: note.isFavorite
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border_outlined),
                    onPressed: () {
                      note.toggleFavorite();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
