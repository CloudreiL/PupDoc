import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pupdoc/classes/animatedComponents/animatedBackground.dart';
import 'package:pupdoc/classes/style.dart';

//TODO: ВАЛДИАЦИЮ ПОЧТЫ ПРОВЕРЬ ДУРА
import '../../services/firebase_stream.dart';
import 'loginpage.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool isHidden0 = true;
  bool isHidden1 = true;

  late TapGestureRecognizer _tapRecognizer = TapGestureRecognizer();

  TextEditingController emailController = TextEditingController();
  TextEditingController fPassController = TextEditingController();
  TextEditingController sPassController = TextEditingController();

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
    emailController.dispose();
    fPassController.dispose();
    sPassController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    if (emailController.text.trim().isEmpty ||
        fPassController.text.trim().isEmpty ||
        sPassController.text.trim().isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Вы заполнили не все поля'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (!EmailValidator.validate(emailController.text.trim())) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Введите корректную почту'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (fPassController.text != sPassController.text) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Пароли не совпадают'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: fPassController.text.trim());

      User? user = userCredential.user;

      if (user != null) {
        DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/${user.uid}");
        await ref.set({
          "email": user.email,
          "uid": user.uid,
        });
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Почта уже используется'),
            duration: Duration(seconds: 2),
          ),
        );
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Пароль должен быть минимум 6 символов'),
            duration: Duration(seconds: 2),
          ),
        );
      }else{
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка $e'),
            duration: Duration(seconds: 2),
          ),
        );
        print("ERR: $e");
      }
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const FirebaseStream()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
          backgroundColor: Colors.transparent,
        body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 65),
                Text('Добро пожаловать в PupDoc!', style: TextStyles.SansBold.copyWith(color: Colors.white, fontSize: 25)),
                Image.asset("lib/assets/png/pupdoclogoregister.png", height: 256, width: 256,),
                Text('Будем заботиться вместе!', style: TextStyles.SansBold.copyWith(color: Colors.white, fontSize: 24)),
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
                        'Регистрация',
                         style: TextStyles.SansReg.copyWith(color: Colors.black, fontSize: 30),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                          decoration: TextFields.FieldDec.copyWith(labelText: 'Ваш E-mail',)
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: fPassController,
                        obscureText: isHidden0,
                        decoration: TextFields.FieldDec.copyWith(
                          labelText: 'Пароль',
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              isHidden0 = !isHidden0;
                            });
                          }, icon: Icon(
                            isHidden0? Icons.remove_red_eye : Icons.remove_red_eye_outlined, color: Colors.black,
                          )),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: sPassController,
                        obscureText: isHidden1,
                        decoration: TextFields.FieldDec.copyWith(
                          labelText: 'Повторите пароль',
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              isHidden1 = !isHidden1;
                            });
                          }, icon: Icon(
                            isHidden1? Icons.remove_red_eye : Icons.remove_red_eye_outlined, color: Colors.black,
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
                          onPressed: signUp,
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
          ],
      )
      ),
    );
  }
}
