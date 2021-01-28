// External Import
import 'package:flutter/material.dart';
import 'package:omit/screens/tabs_screen.dart';
import 'package:google_fonts/google_fonts.dart';

// Internal Import
import '../constants.dart';
import '../screens/settings_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'OMIT',
                    style: GoogleFonts.londrinaSolid(
                      color: Theme.of(context).accentColor,
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                  ),
                  Text(
                    'Clear Your Mind',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.baloo(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.note,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                'Notes',
                style: kAppBarListTextStyle,
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(TabsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).accentColor,
              ),
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
      ),
    );
  }
}
