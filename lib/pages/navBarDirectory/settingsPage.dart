import 'package:flutter/material.dart';


class SettingsPage extends StatefulWidget{
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();

}

class _SettingsPageState extends State<SettingsPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          title: Text('SettingsPage'),
          backgroundColor: Colors.transparent
      ),
        // body: Center(
        //   child: Image.network("https://i.pinimg.com/736x/3e/78/cc/3e78ccdb167c249e5a98816d4220e91f.jpg",
        //       height: 350),
      body: Center(
          child: Text("В будущих обновлениях :)"),
        ),
      );
  }
}