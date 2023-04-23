import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:test2/providers/dark_theme_provider.dart';
import 'package:test2/screens/cart/cart_screen.dart';
import 'package:test2/screens/home.dart';
import 'package:test2/screens/user.dart';

import 'categories.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  final List _page = [
    {'page': const Home(), 'title': 'Home Screen'},
    {'page': Categories(), 'title': 'Categories Screen'},
    {'page': const CartScreen(), 'title': 'Cart Screen'},
    {'page': UserScreen(),

      'title': 'User Screen'},
  ];

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    bool _isDark = themeState.getDarkTheme;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_page[_selectedIndex]['title']),
      // ),

      body:

      _page[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        unselectedItemColor: _isDark ? Colors.white10 : Colors.black12,
        selectedItemColor: _isDark ? Colors.lightBlue.shade200 : Colors.black87,
        onTap: _selectedPage,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(IconlyLight.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(IconlyLight.category), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(IconlyLight.buy), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(IconlyLight.user2), label: "User"),
        ],
      ),
    );
  }
}
