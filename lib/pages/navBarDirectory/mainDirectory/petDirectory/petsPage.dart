import 'package:flutter/material.dart';

import '../../../../classes/style.dart';

class PetsPage extends StatelessWidget{
  const PetsPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Питомцы", style: TextStyles.SansReg),
      ),
      body: Center(
        child: Image.network("https://i.pinimg.com/736x/7f/6e/7b/7f6e7b1650c13dc6ae1c88de9a71569c.jpg",
            height: 250),
      ),
    );
  }
}