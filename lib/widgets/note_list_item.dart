// External Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Internal Import
import '../providers/notes.dart';

class NoteListItem extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  final bool isFavorite;

  const NoteListItem(
      {Key key,
      @required this.id,
      @required this.title,
      @required this.content,
      @required this.dateCreated,
      @required this.dateUpdated,
      @required this.isFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
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
        Provider.of<Notes>(context, listen: false).deleteNote(id);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            title: Text(title),
            subtitle: Text(content),
            trailing: IconButton(
              icon: isFavorite
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border_outlined),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
