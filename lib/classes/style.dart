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


// Цвета

class ColorsPalette{
  static Color DarkCian = Color.fromRGBO(69, 123, 196, 1.0);
  static Color Cian = Color.fromRGBO(109, 220, 225, 1.0);
  static Color LightCian = Color.fromRGBO(228, 254, 255, 1);

  static Color DarkGreen = Color.fromRGBO(92, 180, 74, 1.0);
  static Color LightGreen = Color.fromRGBO(219, 255, 212, 1.0);
}

