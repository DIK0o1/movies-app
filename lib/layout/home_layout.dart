import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/constants/app_colors.dart';

import '../core/screens/browse_screen/browse_screen.dart';
import '../core/screens/home_screen/home_screen.dart';
import '../core/screens/search_screen/search_screen.dart';
import '../core/screens/watch_list_screen/watch_list_screen.dart';


class HomeLayout extends StatefulWidget {
  static const routeName = 'home_layout';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    BrowseScreen(),
    WatchListScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Theme(
          data:
          Theme.of(context).copyWith(canvasColor: AppColors.blackColor),
          child: BottomNavigationBar(
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            currentIndex: selectedIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'HOME',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'SEARCH',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: 'BROWSE',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.playlist_add_outlined),
                label: 'WATCHLIST',
              ),
            ],
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: screens[selectedIndex],
        ),
      ),
    );
  }
}
