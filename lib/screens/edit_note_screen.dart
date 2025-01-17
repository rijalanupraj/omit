// External Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

// Internal Import
import '../providers/note.dart';
import '../providers/notes.dart';
import '../constants.dart';

class EditNoteScreen extends StatefulWidget {
  static const String routeName = '/edit-note-screen';
  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final _form = GlobalKey<FormState>();
  Note _editedNote = Note(
    id: null,
    content: '',
    title: '',
    dateCreated: DateTime.now(),
    dateUpdated: DateTime.now(),
  );

  var _initValues = {
    'title': '',
    'content': '',
  };

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final noteId = ModalRoute.of(context).settings.arguments;
      if (noteId != null) {
        _editedNote =
            Provider.of<Notes>(context, listen: false).findById(noteId);
        _initValues = {
          'title': _editedNote.title,
          'content': _editedNote.content,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    var isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Provider.of<Notes>(context, listen: false)
        .updateNote(_editedNote.id, _editedNote);
    Navigator.of(context).pop();
  }

  Future<bool> _onWillPop() async {
    var themeBox = Hive.box(kSettingsBox);
    var askDiscard = themeBox.get(kAskDiscard, defaultValue: true);
    if (!askDiscard) {
      return Future.value(true);
    }
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Changes made won\'t be save.'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('OK'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Note'),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveForm,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'The title cannot be empty';
                    }
                    if (value.length > 50) {
                      return 'The Character count must be less than 50';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedNote = Note(
                        id: _editedNote.id,
                        title: value,
                        content: _editedNote.content,
                        dateCreated: _editedNote.dateCreated,
                        dateUpdated: _editedNote.dateUpdated,
                        isFavorite: _editedNote.isFavorite);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['content'],
                  decoration: InputDecoration(
                    labelText: 'Content',
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 15,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'The content cannot be empty';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _editedNote = _editedNote = Note(
                        id: _editedNote.id,
                        title: _editedNote.title,
                        content: value,
                        dateCreated: _editedNote.dateCreated,
                        dateUpdated: _editedNote.dateUpdated,
                        isFavorite: _editedNote.isFavorite);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                DateTimeShow(
                    label: 'Date Created: ', time: _editedNote.dateCreated),
                DateTimeShow(
                    label: 'Date Updated: ', time: _editedNote.dateUpdated),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateTimeShow extends StatelessWidget {
  final DateTime time;
  final String label;

  const DateTimeShow({this.time, this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.green,
              fontSize: 15,
            ),
          ),
          Text('${DateFormat.yMd().add_jm().format(time)}')
        ],
      ),
    );
  }
}
