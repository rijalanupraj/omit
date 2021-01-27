// External Import
import 'package:flutter/material.dart';

// Internal Import
import '../widgets/main_drawer.dart';

class SettingScreen extends StatefulWidget {
  static const String routeName = '/settings-screen';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var currentValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          )
        ],
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
                  value: currentValue,
                  subtitle: Text('More info about'),
                  onChanged: (value) {
                    setState(() {
                      currentValue = value;
                    });
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
