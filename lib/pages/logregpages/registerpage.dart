import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pupdoc/classes/animatedbackground.dart';
import 'package:pupdoc/classes/style.dart';

import 'loginpage.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool isHidden = true;
  late TapGestureRecognizer _tapRecognizer = TapGestureRecognizer();

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage())
        );
      };
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        AnimatedBackground(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      'Регистрация',
                       style: TextStyles.SansReg.copyWith(color: Colors.black, fontSize: 30),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Ваш E-mail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Пароль',
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            isHidden = !isHidden;
                          });
                        }, icon: Icon(
                          isHidden? Icons.remove_red_eye : Icons.remove_red_eye_outlined, color: Colors.black,
                        )),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Повторите пароль',
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            isHidden = !isHidden;
                          });
                        }, icon: Icon(
                          isHidden? Icons.remove_red_eye : Icons.remove_red_eye_outlined, color: Colors.black,
                        )),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyles.SansReg.copyWith(fontSize: 15),
                          backgroundColor: Color.fromRGBO(69, 123, 196, 1.0),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Зарегистрироваться',),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Уже есть аккаунт? ',
                          style: TextStyles.SansReg.copyWith(color: Colors.black, fontSize: 15),
                          children: [
                            TextSpan(
                              text: 'Войдите!',
                              style: const TextStyle(color: Color.fromRGBO(69, 123, 196, 1.0)),
                              recognizer: _tapRecognizer
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      )
        ],
      ),
    );
  }
}
