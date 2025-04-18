import 'package:flutter/material.dart';
import 'package:pupdoc/pages/logregpages/loginpage.dart';
import 'package:pupdoc/pages/logregpages/questionnairepage.dart';
import 'package:pupdoc/pages/logregpages/registerpage.dart';
import 'classes/bottombar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: LoginPage()
    );
  }
}