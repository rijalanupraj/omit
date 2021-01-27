// External Import
import 'package:flutter/material.dart';

// Internal Import
import '../constants.dart';
import '../screens/settings_screen.dart';
import '../screens/home_screen.dart';

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
              'Home',
              style: kAppBarListTextStyle,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
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