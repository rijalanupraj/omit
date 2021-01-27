// External Import
import 'package:flutter/material.dart';
import 'package:omit/screens/tabs_screen.dart';

// Internal Import
import '../constants.dart';
import '../screens/settings_screen.dart';
import '../screens/all_notes_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          AppBar(
            title: Text('Omit'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Notes',
              style: kAppBarListTextStyle,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: kAppBarListTextStyle,
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(SettingScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
