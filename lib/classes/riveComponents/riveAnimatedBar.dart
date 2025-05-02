import 'package:flutter/cupertino.dart';

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