import 'package:flutter/material.dart';


class PetPage extends StatefulWidget{
  const PetPage({super.key});

  @override
  _PetPageState createState() => _PetPageState();

}

class _PetPageState extends State<PetPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          title: Text('PetPage'),
          backgroundColor: Colors.transparent
      ),
    );
  }
}