import 'package:flutter/material.dart';
import 'package:slac_serve/helpers/screen_navigation.dart';
import 'package:slac_serve/screens/camScreen.dart';
import 'package:slac_serve/widgets/Contributor.dart';
import 'package:slac_serve/widgets/achievement.dart';
import 'package:slac_serve/widgets/request.dart';
import '../screens/profile.dart';
import '../widgets/feedWidget.dart';

class HomeFeed extends StatefulWidget {
  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  List<Map<String, dynamic>> _pages;

  initState() {
    _pages = [
      {'page': ContributorWidget(), 'title': 'FeedC'},
      {'page': ReceiverWidget(), 'title': 'FeedR'},
      {'page': FeedWidget(), 'title': 'FeedHome'},
      {'page': AchievementWidget(), 'title': 'FeedA'},
      {'page': ProfilePage(), 'title': 'Profile'},
    ];

    super.initState();
  }

  int _selectedPageIndex = 2;

  void _selectPage(int index) {
    setState(
      () {
        _selectedPageIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: _selectedPageIndex != 4
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                child: GestureDetector(
                  child: Icon(Icons.camera_alt),
                  onTap: () {
                    changeScreen(context, CamScreen());
                  },
                ),
              )
            : null,
        actions: _selectedPageIndex != 4
            ? [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  child: Icon(Icons.chat),
                ),
              ]
            : null,
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber[800],
        elevation: 0,
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.wifi_tethering),
              title: Text('Contribution')),
          BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.perm_scan_wifi),
              title: Text('Request')),
          BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.home),
              title: Text('Home')),
          BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.accessibility_new),
              title: Text('Achievement')),
          BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.perm_identity),
              title: Text('Profile')),
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
    );
  }
}
