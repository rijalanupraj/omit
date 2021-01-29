// External Import
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// Internal Import
import '../widgets/main_drawer.dart';
import 'package:omit/constants.dart';

class SettingScreen extends StatefulWidget {
  static const String routeName = '/settings-screen';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var darkTheme = true;
  var askDelete = true;
  var askDiscard = true;

  @override
  void initState() {
    var themeBox = Hive.box(kSettingsBox);
    setState(() {
      darkTheme = themeBox.get(kDarkTheme, defaultValue: false);
      askDelete = themeBox.get(kAskDelete, defaultValue: true);
      askDiscard = themeBox.get(kAskDiscard, defaultValue: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Your Custom Configuration',
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                SwitchListTile(
                  title: Text('Dark Theme'),
                  value: darkTheme,
                  subtitle: Text('Light or Dark?'),
                  onChanged: (value) {
                    setState(() {
                      darkTheme = value;
                    });
                    Hive.box(kSettingsBox).put(kDarkTheme, darkTheme);
                  },
                ),
                SwitchListTile(
                  title: Text('Show Delete Confirmation'),
                  value: askDelete,
                  subtitle:
                      Text('Show Alert Before Performing Delete Operation'),
                  onChanged: (value) {
                    setState(() {
                      askDelete = value;
                    });
                    Hive.box(kSettingsBox).put(kAskDelete, askDelete);
                  },
                ),
                SwitchListTile(
                  title: Text('Show Confirmation While Editing'),
                  value: askDiscard,
                  subtitle: Text(
                      'Will ask you Confiramtion while Navigating back\n-From New Note Screen\nOr Eidt Note Screen'),
                  onChanged: (value) {
                    setState(() {
                      askDiscard = value;
                    });
                    Hive.box(kSettingsBox).put(kAskDiscard, askDiscard);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
