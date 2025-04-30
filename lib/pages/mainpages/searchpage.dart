import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget{
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();

}

class _SearchPageState extends State<SearchPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          title: Text('SearchPage'),
          backgroundColor: Colors.transparent
      ),
      body: Center(
        child: Image.network("https://i.pinimg.com/736x/13/4d/c2/134dc20bc02e7b2f6ca507fcf9c63929.jpg",
        height: 300),
      ),
    );
  }
}