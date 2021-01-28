// Package Import
import 'package:flutter/material.dart';
import 'package:omit/providers/note.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

// Internal Import
import './screens/all_notes_screen.dart';
import './providers/notes.dart';
import './screens/tabs_screen.dart';
import './screens/favorite_notes_screen.dart';
import './screens/settings_screen.dart';
import './screens/add_new_note_screen.dart';
import './screens/edit_note_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(NoteAdapter());
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Notes(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        initialRoute: TabsScreen.routeName,
        routes: {
          TabsScreen.routeName: (context) => TabsScreen(),
          AllNotesScreen.routeName: (context) => AllNotesScreen(),
          SettingScreen.routeName: (context) => SettingScreen(),
          FavoriteNotesScreen.routeName: (context) => FavoriteNotesScreen(),
          AddNewNoteScreen.routeName: (context) => AddNewNoteScreen(),
          EditNoteScreen.routeName: (context) => EditNoteScreen(),
        },
      ),
    );
  }
}
