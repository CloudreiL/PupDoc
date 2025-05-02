import 'package:flutter/material.dart';
import 'package:pupdoc/classes/riveComponents/riveAnimatedBar.dart';
import 'package:pupdoc/classes/riveComponents//riveModelBar.dart';
import 'package:pupdoc/classes/riveComponents//riveUtils.dart';
import 'package:pupdoc/pages/mainpages/settingspage.dart';
import 'package:rive/rive.dart';
import '../pages/mainpages/accountpage.dart';
import '../pages/mainpages/forum.dart';
import '../pages/mainpages/searchpage.dart';


//TODO: replace bottomnavbar
class BottomNavBar extends StatefulWidget{
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>{

  RiveAsset selectedBottomNav = bottomNavBar.first;

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return AccPage();
      case 1:
        return SearchPage();
      case 2:
        return ForumPage();
      case 3:
        return SettingsPage();
      default:
        return AccPage();
    }
  }

  int _selectedPageIndex = 0;
  
  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: _getPage(_selectedPageIndex),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                color: Color.fromRGBO(69, 123, 196, 0.9),
                borderRadius: BorderRadius.all(Radius.circular(24))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  ...List.generate(bottomNavBar.length, (index) => GestureDetector(
                    onTap: (){
                      if(bottomNavBar[index] != selectedBottomNav){
                        setState(() {
                          selectedBottomNav = bottomNavBar[index];
                        });
                        setState(() {
                          _selectedPageIndex = index;
                        });
                      }
                      bottomNavBar[index].input!.change(true);
                      Future.delayed(const Duration(seconds: 1), (){
                        bottomNavBar[index].input!.change(false);
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBar(
                            isActive: bottomNavBar[index] == selectedBottomNav),
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 200),
                            opacity: bottomNavBar[index] ==
                                selectedBottomNav ? 1: 0.5,
                            child: RiveAnimation.asset(
                              bottomNavBar.first.src,
                              artboard: bottomNavBar[index].artboard,
                              onInit: (artboard){
                                StateMachineController controller =
                                RiveUtils.getRiveController(artboard,
                                    stateMachineName: bottomNavBar[index].stateMachineName);
                                bottomNavBar[index].input =
                                controller.findSMI("active") as SMIBool;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),)
              ],
            ),
          ),
        ),
    );
  }
}



