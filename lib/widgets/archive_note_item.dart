// External Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:hive/hive.dart';

// Internal Import
import '../providers/notes.dart';
import '../providers/note.dart';
import '../screens/edit_note_screen.dart';
import '../constants.dart';
import '../widgets/dismiss_swipe_background.dart';

class ArchiveNoteItem extends StatelessWidget {
  String limitText(String currentText) {
    String modifiedText = '';
    List textList = currentText.split('\n');
    if (textList[0] != '') {
      modifiedText = textList[0];
    }
    if (modifiedText.length > 50) {
      modifiedText = modifiedText.substring(0, 50);
      modifiedText += '  ......';
    }
    return modifiedText;
  }

  @override
  Widget build(BuildContext context) {
    final currentNote = Provider.of<Note>(context, listen: false);
    var themeBox = Hive.box(kSettingsBox);
    var askDelete = themeBox.get(kAskDelete, defaultValue: true);

    return Dismissible(
      key: ValueKey(currentNote.id),
      background: DismissSwipeBackground(
        backgroundColor: Colors.red,
        icon: Icons.delete,
        isLeft: true,
        iconColor: Colors.white,
      ),
      secondaryBackground: DismissSwipeBackground(
        backgroundColor: Colors.green,
        icon: Icons.unarchive,
        isLeft: false,
        iconColor: Colors.white,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          if (!askDelete) {
            return Future.value(true);
          }
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
                  child: Text(
                    'DELETE',
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                ),
              ],
            ),
          );
        } else if (direction == DismissDirection.endToStart) {
          return Future.value(true);
        } else {
          return Future.value(false);
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          Provider.of<Notes>(context, listen: false).deleteNote(currentNote.id);
        }
        if (direction == DismissDirection.endToStart) {
          Provider.of<Notes>(context, listen: false)
              .unArchiveNote(currentNote.id, currentNote);
        }
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            title: Text(
              currentNote.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              limitText(currentNote.content),
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
