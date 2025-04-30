import 'package:flutter/material.dart';
import 'package:pupdoc/classes/riveUtils.dart';
import 'package:rive/rive.dart';
import '../pages/mainpages/accountpage.dart';
import '../pages/mainpages/forum.dart';
import '../pages/mainpages/petpage.dart';


//TODO: replace bottomnavbar
class BottomNavBar extends StatefulWidget{
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>{

  RiveAsset selectedBottomNav = bottomNavBar.first;
  
  @override
  Widget build (BuildContext context){
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                color: Color.fromRGBO(61, 66, 85, 0.9),
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

class AnimatedBar extends StatelessWidget{
  const AnimatedBar({
    Key? key,
    required this.isActive,
  }) : super(key:key);

  final bool isActive;

  @override
  Widget build(BuildContext context){
    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: 2),
      height: 5,
      width: isActive ? 20 : 0,

      duration: const Duration(milliseconds: 200),

      decoration: BoxDecoration(
          color: Color.fromRGBO(109, 220, 225, 1.0),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
    );
  }
}

class RiveAsset{
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(this.src,{
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input});

  set setInput(SMIBool status){
    input = status;
  }
}

List<RiveAsset> bottomNavBar = [
  RiveAsset("lib/assets/riveAssets/icons.riv",
  artboard: "USER",
    stateMachineName: "USER_Interactivity",
    title: "User"
  ),
  RiveAsset("lib/assets/riveAssets/icons.riv",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
      title: "Search"
  ),
  RiveAsset("lib/assets/riveAssets/icons.riv",
      artboard: "CHAT",
      stateMachineName: "CHAT_Interactivity",
      title: "Chat"
  ),
  RiveAsset("lib/assets/riveAssets/icons.riv",
      artboard: "SETTINGS",
      stateMachineName: "SETTINGS_Interactivity",
      title: "Settings"
  )
];