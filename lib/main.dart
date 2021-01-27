// Package Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Internal Import
import './screens/all_notes_screen.dart';
import './providers/notes.dart';
import './screens/tabs_screen.dart';
import './screens/favorite_notes_screen.dart';
import './screens/settings_screen.dart';

void main() {
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
        },
      ),
    );
  }
}
