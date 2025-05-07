import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pupdoc/services/firebase_functions.dart';
import '../../../../classes/profilePicture.dart';
import '../../../../classes/style.dart';
import '../../../logregpages/loginpage.dart';

class AccPage extends StatefulWidget{
  final userName;

  const AccPage({super.key, this.userName});

  @override
  State<AccPage> createState() => _AccPageState();
}

class _AccPageState extends State<AccPage> {

  final user = FirebaseAuth.instance.currentUser;
  String? nickName;

  @override
  void initState(){
    super.initState();
    _loadNickName();
  }

  Future<void> _loadNickName() async{
    final nickNameBase = await FirebaseFunctions.getUserNickname();
    if(nickNameBase != null){
      setState(() {
        nickName = nickNameBase;
      });
    }
  }

  Future<void> _signOut() async {
    await FirebaseFunctions.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("lib/assets/png/background/accountBackground/cianBackground.png"),
          fit: BoxFit.cover
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Аккаунт", style: TextStyles.SansReg.copyWith(fontSize: 25),),
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.65,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)
                  )
                ),
              ),
            ),
            nickName == null
              ? Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                    color: Color.fromRGBO(109, 220, 225, 1.0)
                  ),
                ),
              )
                : Center(
              child: Padding(
                padding: EdgeInsets.only(top: 150),
                child: Column(
                  children: [
                    ProfilePicture(size: 120),
                    Text(widget.userName, style: TextStyles.SansReg.copyWith(fontSize: 25)),
                    Text("@$nickName", style: TextStyles.SansReg),
                    Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          onPressed: _signOut,
                          child: Text("Выйти", style: TextStyles.SansReg.copyWith(fontSize: 15))),
                      )
                  ],
                ),
              ),
            )
          ],
        )
      )
      // body: Center(
      //   child: Column(
      //     children: [
      //       GestureDetector(
      //         onTap: (){},
      //           child: ProfilePicture()
      //       ),
      //       ElevatedButton(
      //           onPressed: (){
      //             signOut();
      //             },
      //           child: Text("Выйти", style: TextStyles.SansReg,))
      //     ],
      //   )
      // ),

    );
  }
}
