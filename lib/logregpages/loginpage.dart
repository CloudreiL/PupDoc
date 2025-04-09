import 'package:flutter/material.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:pupdoc/classes/style.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  bool isHidden = true;

  @override
  Widget build(BuildContext context){
    return AnimateGradient(
      primaryColors: const [
          Color.fromRGBO(180, 255, 126, 1),
        Color.fromRGBO(86, 138, 77, 1)
      ],
      secondaryColors: [
        Color.fromRGBO(86, 138, 77, 1),
        Color.fromRGBO(180, 255, 126, 1),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            margin: EdgeInsets.only(left:20, right: 20),
            height: 368,
            decoration: ContainerDecor.WhiteCont,
            child: Column(
              children: [
                Padding( padding: EdgeInsets.only(top: 20,bottom: 20),
                  child: Text('Вход', style: TextStyles.SansReg.copyWith(color: Colors.black, fontSize: 25)),
                ),
                Padding(padding: EdgeInsets.all(10),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 1,
                    margin: EdgeInsets.only(left:5, right:5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextField(
                      decoration: TextFields.FieldDec.copyWith(
                        labelText: 'Ваша почта',
                        labelStyle: TextStyle(color: Colors.black)
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 10, left: 10, top: 20),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 1,
                    margin: EdgeInsets.only(left:5, right:5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextField(
                      obscureText: isHidden,
                      decoration: TextFields.FieldDec.copyWith(
                          labelText: 'Пароль',
                          labelStyle: TextStyle(color: Colors.black),
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              isHidden = !isHidden;
                            });
                          }, icon: Icon(
                            isHidden? Icons.remove_red_eye : Icons.remove_red_eye_outlined, color: Colors.black,
                          ))
                      ),
                      ),
                    ),
                  ),
              ],
            ),
          )
        ),
      ),
    );
  }
}