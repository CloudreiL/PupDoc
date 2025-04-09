import 'package:flutter/material.dart';

class TextStyles{
  static TextStyle SansReg = TextStyle(
    fontSize: 20, fontFamily: 'Sansation', color: Colors.white
  );
}

class ContainerDecor{
  static BoxDecoration WhiteCont = BoxDecoration(
    color: Colors.white,
      borderRadius: BorderRadius.circular(20)
  );
}

class TextFields{
  static InputDecoration FieldDec = InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(20)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(20)),
    labelStyle: TextStyles.SansReg,
    filled: true,
    fillColor: Colors.transparent
  );
}