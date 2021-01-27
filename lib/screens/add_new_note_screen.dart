// External Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Internal Import
import '../providers/note.dart';
import '../providers/notes.dart';

class AddNewNoteScreen extends StatefulWidget {
  static const String routeName = '/add-new-note-screen';
  @override
  _AddNewNoteScreenState createState() => _AddNewNoteScreenState();
}

class _AddNewNoteScreenState extends State<AddNewNoteScreen> {
  final _form = GlobalKey<FormState>();
  Note _editedNote = Note(
      id: null,
      content: '',
      title: '',
      dateCreated: DateTime.now(),
      dateUpdated: DateTime.now());

  void _saveForm() {
    var isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Provider.of<Notes>(context, listen: false).addNewNote(_editedNote);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Note'),
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
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedNote = Note(
                      id: _editedNote.id,
                      title: value,
                      content: _editedNote.content,
                      dateCreated: _editedNote.dateCreated,
                      dateUpdated: _editedNote.dateUpdated);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Content',
                ),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 15,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value';
                  }

                  return null;
                },
                onSaved: (value) {
                  _editedNote = _editedNote = Note(
                      id: _editedNote.id,
                      title: _editedNote.title,
                      content: value,
                      dateCreated: _editedNote.dateCreated,
                      dateUpdated: _editedNote.dateUpdated);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
