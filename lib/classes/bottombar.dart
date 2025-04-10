import 'package:pupdoc/pages/accountpage.dart';
import 'package:pupdoc/pages/forum.dart';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pupdoc/pages/petpage.dart';

class BottomNavBar extends StatefulWidget{
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>{
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return ForumPage();
      case 1:
        return PetPage();
      case 2:
        return AccPage();
      default:
        return ForumPage();
    }
  }

  int _selectedIndex = 0;

  @override
  Widget build (BuildContext context){
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
                colors: [Color.fromRGBO(69, 123, 196, 1.0), Color.fromRGBO(109, 220, 225, 1.0)],
              ),
          ),
          child: CurvedNavigationBar(
            index: _selectedIndex,
            color: Colors.black,
            backgroundColor: Colors.transparent,

            animationDuration: Duration(milliseconds: 400),
            animationCurve: Curves.easeInOutCubicEmphasized,
            height: 50,
            buttonBackgroundColor: Colors.transparent,
            items: [
              Icon(Icons.people, color: Colors.white),
              Icon(Icons.pets,color: Colors.white,),
              Icon(Icons.person, color: Colors.white,),
            ],
            onTap: (index){
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
        body: _getPage(_selectedIndex)
    );
  }
}