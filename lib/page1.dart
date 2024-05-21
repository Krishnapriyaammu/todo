import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/counter.dart';
import 'package:todo/list%20task.dart';
import 'package:todo/login.dart';
import 'package:todo/myhome.dart';
import 'package:todo/profile.dart';
import 'package:todo/timer.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
   int _selectedIndex = 0;

  static  List<Widget> _pages = <Widget>[
    FocusNowPage(), // The main home page
    TimeDate(), // The list task page
    Counter(), // Placeholder for Profile page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Focus Now',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
