import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../classes/profilePicture.dart';
import '../../../../classes/style.dart';
import '../../../logregpages/loginpage.dart';

class AccPage extends StatefulWidget{
  const AccPage({super.key});

  @override
  State<AccPage> createState() => _AccPageState();
}

class _AccPageState extends State<AccPage> {

  final user = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        )
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Аккаунт", style: TextStyles.SansReg.copyWith(fontSize: 25),),
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){},
                child: ProfilePicture()
            ),
            ElevatedButton(
                onPressed: (){
                  signOut();
                  },
                child: Text("Выйти", style: TextStyles.SansReg,))
          ],
        )
      ),

    );
  }
}
