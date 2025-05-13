import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pupdoc/services/firebase_functions.dart';
import '../../../../classes/profilePicture.dart';
import '../../../../classes/style.dart';
import '../../../../services/firebase_stream.dart';

class AccPage extends StatefulWidget{
  final userName;

  const AccPage({super.key, this.userName});

  @override
  State<AccPage> createState() => _AccPageState();
}

class _AccPageState extends State<AccPage> {

  final user = FirebaseAuth.instance.currentUser;
  String? nickName;
  Color userNicknameColor = Colors.black;

  @override
  void initState(){
    super.initState();
    _loadNickName();
    _loadUserColor();
  }

  Future<void> _loadNickName() async{
    final nickNameBase = await FirebaseFunctions.getUserNickname();
    if(nickNameBase != null){
      setState(() {
        nickName = nickNameBase;
      });
    }
  }
  Future<void> _loadUserColor() async{
    final userRoleBase = await FirebaseFunctions.getUserRole();
    print(userRoleBase);
    if(userRoleBase == 'owner'){
      setState(() {
        userNicknameColor = ColorsPalette.DarkCian;
      });
    }else if(userRoleBase == 'vet'){
      setState(() {
        userNicknameColor = ColorsPalette.DarkGreen;
      });
    }
  }

  Future<void> _signOut() async {
    await FirebaseFunctions.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const FirebaseStream()),
          (Route<dynamic> route) => false,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Вы успешно вышли из аккаунта'),
        duration: Duration(seconds: 2),
      ),
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
                    Text("@$nickName", style: TextStyles.SansReg.copyWith(color: userNicknameColor)),
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
