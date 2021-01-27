// External Import
import 'package:flutter/material.dart';

// Internal Import
import '../screens/add_new_note_screen.dart';
import '../screens/all_notes_screen.dart';
import '../screens/favorite_notes_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/tabs-screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      {'page': AllNotesScreen(), 'title': 'All Notes'},
      {'page': FavoriteNotesScreen(), 'title': 'Favorites'}
    ];
  }

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title']),
        ),
        drawer: MainDrawer(),
        body: _pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.note,
              ),
              label: 'All',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Favorites',
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.note_add,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(AddNewNoteScreen.routeName);
          },
        ),
      ),
    );
  }
}
