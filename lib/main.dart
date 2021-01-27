// Package Import
import 'package:flutter/material.dart';
import 'package:omit/screens/settings_screen.dart';

// Internal Import
import './screens/home_screen.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        SettingScreen.routeName: (context) => SettingScreen(),
      },
    );
  }
}
