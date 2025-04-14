import 'package:flutter/material.dart';


class ForumPage extends StatefulWidget{
  const ForumPage({super.key});

  @override
  _ForumPageState createState() => _ForumPageState();

}

class _ForumPageState extends State<ForumPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            title: Text('ForumPage'),
            backgroundColor: Colors.transparent
        ),
    );
  }
}