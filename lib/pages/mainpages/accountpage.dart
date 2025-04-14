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
    );
  }
}