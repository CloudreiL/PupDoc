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
      borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          offset: Offset(0, 3),
          spreadRadius: 1,
          blurRadius: 10
      )
    ]
  );
  static BoxDecoration OutlinedCont = BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: Color.fromRGBO(69, 123, 196, 1.0),
      width: 3
    )
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

