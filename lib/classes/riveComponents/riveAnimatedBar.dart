import 'package:flutter/cupertino.dart';
import 'package:pupdoc/classes/style.dart';

class AnimatedBar extends StatelessWidget{
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context){
    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: 2),
      height: 5,
      width: isActive ? 20 : 0,

      duration: const Duration(milliseconds: 200),

      decoration: BoxDecoration(
          color: ColorsPalette.Cian,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
    );
  }
}