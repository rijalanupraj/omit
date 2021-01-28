// Package Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Internal Import
import './screens/all_notes_screen.dart';
import './providers/notes.dart';
import './screens/tabs_screen.dart';
import './screens/favorite_notes_screen.dart';
import './screens/settings_screen.dart';
import './screens/add_new_note_screen.dart';
import './screens/edit_note_screen.dart';
import './providers/note.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox(kThemeBox);
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
      child: ValueListenableBuilder(
        valueListenable: Hive.box(kThemeBox).listenable(),
        builder: (context, themeBox, widget) {
          var darkTheme = themeBox.get('darkTheme', defaultValue: false);
          return MaterialApp(
            theme: darkTheme ? ThemeData.dark() : ThemeData.light(),
            initialRoute: TabsScreen.routeName,
            routes: {
              TabsScreen.routeName: (context) => TabsScreen(),
              AllNotesScreen.routeName: (context) => AllNotesScreen(),
              SettingScreen.routeName: (context) => SettingScreen(),
              FavoriteNotesScreen.routeName: (context) => FavoriteNotesScreen(),
              AddNewNoteScreen.routeName: (context) => AddNewNoteScreen(),
              EditNoteScreen.routeName: (context) => EditNoteScreen(),
            },
          );
        },
      ),
    );
  }
}
