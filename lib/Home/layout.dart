import 'package:evently/Home/favourite.dart';
import 'package:evently/Home/profile.dart';
import 'package:evently/add/adds.dart';

import 'package:flutter/material.dart';

import 'home_screen.dart';

class Layout extends StatefulWidget {
  Layout({super.key});
  static const String routName = "Layout";

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int selectedIndex = 0;
  List<Widget> bar = [HomeScreen(), Profile(), Favourite()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bar[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              activeIcon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: "Favourite",
              activeIcon: Icon(Icons.favorite),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
              activeIcon: Icon(Icons.person),
            ),
          ],
        ),
      ),
      floatingActionButton:
      FloatingActionButton(
          elevation: 0, 
          child: Icon(Icons.add),
          onPressed:(){Navigator.pushNamed(context,Adds.routName);}),
    );
  }
}
