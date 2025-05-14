import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:pupdoc/pages/logRegDirectory/questionnairePage.dart';
import 'package:pupdoc/pages/logRegDirectory/registerPage.dart';

import '../../classes/style.dart';



class EmailVerification extends StatefulWidget{
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification>{

  bool isVerified = false;
  String? userEmail;
  Timer? timer;

  @override
  void initState(){
    super.initState();

    userEmail = null;

    final user = FirebaseAuth.instance.currentUser;
    isVerified = user!.emailVerified;
    userEmail = user.email;

    if(!isVerified){
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
            (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async{
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    print(isVerified);

    if(isVerified) timer?.cancel();
  }

  Future<void> sendVerificationEmail() async{
    try{
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    }catch(e){
      print(e);
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text(
                'Ошибка $e',
              ),
              duration:Duration(seconds: 2),
            )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => isVerified
  ?const QuizzPage()
  :Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromRGBO(69, 123, 196, 1.0),
            Color.fromRGBO(109, 220, 225, 1.0),],
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: 368,
                    margin: EdgeInsets.only(left: 20, right: 20),

                    decoration: ContainerDecor.WhiteCont,

                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top:10, bottom: 10),
                          child: Icon(Icons.email_outlined,color: Color.fromRGBO(69, 123, 196, 1.0)
                              ,size: 70),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          margin: EdgeInsets.only(left:20, right:20),
                          height: 250,
                          decoration: ContainerDecor.OutlinedCont,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Ссылка с верификацией выслана на",
                                  textAlign: TextAlign.center,
                                style: TextStyles.SansReg.copyWith(color: Color.fromRGBO(69, 123, 196, 1.0))
                              ),
                              Text('$userEmail',
                              textAlign: TextAlign.center,
                                style: TextStyles.SansBold.copyWith(color: Color.fromRGBO(69, 123, 196, 1.0))
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  ElevatedButton(
                      onPressed: (){
                        FirebaseAuth.instance.currentUser!.delete();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationPage(),
                            )
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Неправильная почта', style: TextStyles.SansReg.copyWith(color: Color.fromRGBO(69, 123, 196, 1.0), fontSize: 15),),
                  )
                ],
              ),
            ),
          )
      );
  }