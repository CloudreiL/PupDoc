import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pupdoc/classes/style.dart';
import 'package:pupdoc/pages/logregpages/registerpage.dart';
import '../../classes/animatedbackground.dart';
import '../../classes/bottombar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isHidden = true;
  late TapGestureRecognizer _tapRecognizer = TapGestureRecognizer();

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RegistrationPage())
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
      body: AnimatedBackground(
        child:
          Stack(
            children: [
              Center(
                //Welcome Column
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Text('Добро пожаловать в PupDoc!', style: TextStyles.SansBold.copyWith(color: Colors.white, fontSize: 25)),
                    Image.asset("lib/assets/png/pupdoclogologin.png", height: 256, width: 256,),
                    Text('Рады видеть вас снова!', style: TextStyles.SansBold.copyWith(color: Colors.white, fontSize: 24)),
                  ],
                ),
              ),
          Align(
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
                        'Вход',
                        style: TextStyles.SansReg.copyWith(color: Colors.black, fontSize: 30),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        decoration: TextFields.FieldDec.copyWith(labelText: 'Ваш E-mail',)
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        obscureText: true,
                        decoration: TextFields.FieldDec.copyWith(
                          labelText: 'Пароль',
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              isHidden = !isHidden;
                            });
                          }, icon: Icon(
                            isHidden? Icons.remove_red_eye : Icons.remove_red_eye_outlined, color: Colors.black,
                          )),
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
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => BottomNavBar())
                            );
                          },
                          child: Text('Войти'),
                        ),
                      ),
                       SizedBox(height: 24),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Нет аккаунта? ',
                            style: TextStyles.SansReg.copyWith(color: Colors.black, fontSize: 15),
                            children: [
                              TextSpan(
                                  text: 'Зарегистрируйте!',
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
          ],
          ),
      ),
    );
  }
}
