import 'package:rive/rive.dart';

class RiveUtils{
  static StateMachineController getRiveController(Artboard artboard,
      {stateMachineName = 'StateMachine1'}){
    StateMachineController? controller =
        StateMachineController.fromArtboard(
            artboard, stateMachineName
        );
    artboard.addController(controller!);
    return controller;
  }
}