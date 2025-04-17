import 'package:flutter/material.dart';

class TextStyles{
  static TextStyle SansReg = TextStyle(
    fontSize: 20, fontFamily: 'SansationRegular', color: Colors.black
  );
  static TextStyle SansBold = TextStyle(
    fontSize: 20, fontFamily: 'SansationBold', color: Colors.black
  );
}

class ContainerDecor{
  static BoxDecoration WhiteCont = BoxDecoration(
    color: Colors.white,
      borderRadius: BorderRadius.circular(20)
  );
}

class TextFields{
  // static InputDecoration FieldDec = InputDecoration(
  //   enabledBorder: OutlineInputBorder(
  //       borderSide: BorderSide(color: Colors.black),
  //       borderRadius: BorderRadius.circular(20)),
  //   focusedBorder: OutlineInputBorder(
  //       borderSide: BorderSide(color: Colors.black),
  //       borderRadius: BorderRadius.circular(20)),
  //   labelStyle: TextStyles.SansReg,
  //   filled: true,
  //   fillColor: Colors.transparent
  // );
  static InputDecoration FieldDec = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    labelStyle: TextStyle(
      fontFamily: "SansationRegular"
    ),
  );
}

