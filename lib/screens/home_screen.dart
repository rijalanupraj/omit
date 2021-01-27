// Package Import
import 'package:flutter/material.dart';

// Internal Import
import '../widgets/main_drawer.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home-screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Omit'),
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
