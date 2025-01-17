// External Import
import 'package:flutter/material.dart';
import 'package:omit/widgets/dismiss_swipe_background.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:hive/hive.dart';

// Internal Import
import '../providers/notes.dart';
import '../providers/note.dart';
import '../screens/edit_note_screen.dart';
import '../constants.dart';

class NoteListItem extends StatelessWidget {
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
        icon: Icons.archive,
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
              .archiveNote(currentNote.id, currentNote);
        }
      },
      child: InkWell(
        onLongPress: () {
          Clipboard.setData(ClipboardData(
              text: "${currentNote.title}\n${currentNote.content}"));
          toast.Fluttertoast.showToast(
              msg: "Text Copied",
              toastLength: toast.Toast.LENGTH_SHORT,
              gravity: toast.ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Theme.of(context).primaryColor,
              textColor: Theme.of(context).accentColor,
              fontSize: 16.0);
        },
        onTap: () => Navigator.of(context)
            .pushNamed(EditNoteScreen.routeName, arguments: currentNote.id),
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
              trailing: Consumer<Note>(
                builder: (context, note, child) {
                  return IconButton(
                    icon: note.isFavorite
                        ? Icon(
                            Icons.favorite,
                            color: Theme.of(context).accentColor,
                            size: 30,
                          )
                        : Icon(
                            Icons.favorite_border_outlined,
                            color: Theme.of(context).accentColor,
                            size: 30,
                          ),
                    onPressed: () async {
                      await Provider.of<Notes>(context, listen: false)
                          .toggleFavoriteHive(
                              currentNote.id, currentNote, !note.isFavorite);
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
