import 'package:flutter/material.dart';


class AccPage extends StatefulWidget{
  const AccPage({super.key});

  @override
  _AccPageState createState() => _AccPageState();

}

class _AccPageState extends State<AccPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          title: Text('AccountPage'),
          backgroundColor: Colors.transparent
      ),
      body: Center(
        child: Image.network("https://i.pinimg.com/736x/b6/c0/db/b6c0dbd109752cd04842500496c30a07.jpg",
            height: 350),
      ),
    );
  }
}