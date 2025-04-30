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
      body: Center(
        child: Image.network("https://i.pinimg.com/736x/7f/6e/7b/7f6e7b1650c13dc6ae1c88de9a71569c.jpg",
            height: 250),
      ),
    );
  }
}