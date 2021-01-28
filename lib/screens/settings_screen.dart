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

  @override
  void initState() {
    var themeBox = Hive.box(kThemeBox);
    setState(() {
      darkTheme = themeBox.get('darkTheme', defaultValue: false);
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
              'Write something here',
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                SwitchListTile(
                  title: Text('Dark Theme'),
                  value: darkTheme,
                  subtitle: Text('More info about'),
                  onChanged: (value) {
                    setState(() {
                      darkTheme = value;
                    });
                    Hive.box(kThemeBox).put('darkTheme', darkTheme);
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
