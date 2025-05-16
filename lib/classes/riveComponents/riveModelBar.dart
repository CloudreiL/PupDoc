import 'package:rive/rive.dart';

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