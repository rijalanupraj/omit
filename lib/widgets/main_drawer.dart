// External Import
import 'package:flutter/material.dart';
import 'package:omit/screens/archive_note_screen.dart';
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
                        color: Theme.of(context).errorColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            DrawerListTile(
              label: 'Notes',
              icon: Icons.note,
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(TabsScreen.routeName);
              },
            ),
            Divider(),
            DrawerListTile(
              label: 'Acrhives',
              icon: Icons.archive,
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ArchiveNoteScreen.routeName);
              },
            ),
            Divider(),
            DrawerListTile(
              label: 'Settings',
              icon: Icons.settings,
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

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onTap;

  const DrawerListTile({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).accentColor,
      ),
      title: Text(
        label,
        style: kAppBarListTextStyle,
      ),
      onTap: onTap,
    );
  }
}
