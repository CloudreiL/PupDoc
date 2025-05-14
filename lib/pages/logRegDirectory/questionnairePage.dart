import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pupdoc/classes/animatedComponents/animatedLinearBar.dart';
import 'package:pupdoc/classes/questionnaireModel.dart';

import '../../classes/bottomBar.dart';
import '../../classes/style.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage ({super.key});

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage>{

  int questionSteps = 1;
  int currentSteps = 0;
  final int totalSteps = 6;
  final List<Widget> questions = [];
  final Map<int, dynamic> answers = {};
  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  User? user = FirebaseAuth.instance.currentUser;
  String? profilePicture;

  @override
  void initState(){
    super.initState();

    questions.addAll([
      QuestionTextField(
          question: "Как вас зовут?",
          onNext: (answer){
              answers[0] = answer.trim();
              print(answers);

              if (answers[0].toString().isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Поле не может быть пустым'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }else{
                nextStep();
              }
          }),
      QuestionOptions(
          question: "Какого вы пола?",
          options: ["Женщина", "Мужчина"],
          onNext: (answer){
            if(answer == "Женщина"){
              answers[5] = "fem";
            }else if(answer == "Мужчина"){
              answers[5] = "male";
            }
            nextStep();
            print(answers);
          }),
      QuestionOptions(
          question: "Вы ветеринар или владелец домашнего животного?",
          options: ["Я ветеринар", "Я владелец"],
          onNext: (answer){
            if(answer == "Я ветеринар"){
              answers[1] = "vet";
            }else if(answer == "Я владелец"){
              answers[1] = "owner";
            }
            nextStep();
            print(answers);
          }),
      QuestionOptions(
          question: "Какой у вас питомец?",
          options: ["Кошка", "Собака", "Другое"],
          onNext: (answer){
            if(answer == "Кошка"){
              answers[2] = "cat";
            }else if(answer == "Собака"){
              answers[2] = "dog";
            }
            else if(answer == "Другое"){
              answers[2] = "other";
            }
            nextStep();
            print(answers);
          }),
      QuestionTextField(
          question: "Как зовут вашего питомца?",
          onNext: (answer){
            answers[3] = answer.trim();
            print(answers);

            if (answers[3].toString().isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Поле не может быть пустым'),
                  duration: Duration(seconds: 2),
                ),
              );
              return;
            }else{
              nextStep();
            }
          }),
      QuestionTextField(
        englishOnly: true,
          question: "Придумайте себе никнейм",
          onNext: (answer){
            answers[4] = answer.trim();
            print(answers);

            if (answers[4].toString().isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Поле не может быть пустым'),
                  duration: Duration(seconds: 2),
                ),
              );
              return;
            }else{
              _saveAnswersToFirebase();
            }
          }),
    ]);
  }

  void nextStep(){
    if(currentSteps < totalSteps - 1){
      setState(() {
        currentSteps++;
        questionSteps++;
      });
    }
  }

  void toApp(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar())
    );
  }

  Future<void> _saveAnswersToFirebase() async {

    if(answers[5] == "fem" && answers[2] == "dog"){
      profilePicture = "dogLoversFemale.png";
      print(profilePicture);
    } else if(answers[5] == "fem" && answers[2] == "cat"){
      profilePicture = "catLoversFemale.png";
      print(profilePicture);
    } else if(answers[5] == "male" && answers[2] == "dog"){
      profilePicture = "dogLoversMale.png";
      print(profilePicture);
    } else if(answers[5] == "male" && answers[2] == "cat"){
      profilePicture = "catLoversMale.png";
      print(profilePicture);
    }

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Пользователь не найден'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      await ref.child("users/${user!.uid}/info").set({
        "nickname": answers[4],// никнейм бро
        "name": answers[0],// имя
        "gender": answers[5],// я боевой вертолет
        "role": answers[1], //  ветеринар/владелец
        "profileImage": profilePicture, // долбанный аватар
        "created_at": DateTime.now().toIso8601String(), //че по времени ало
      });

      await ref.child("users/${user!.uid}/info/pets/0").set({
        "pet_type": answers[2], // тип питомца
        "pet_name": answers[3], // имя питомца
      });
      toApp();
    }catch(e){
      print("ERR: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // void prevStep(){
  //   if(currentSteps > 1){
  //     setState(() {
  //       currentSteps--;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$questionSteps вопрос из $totalSteps', style: TextStyles.SansReg.copyWith(color: Colors.black)),
        centerTitle: true
      ),
      body: Column(
        children: [
          AnimatedProgressBar(currentStep: questionSteps, totalSteps: totalSteps),
          SizedBox(height: 20),
          Text('Отлично! Перед тем как перейти к приложению, давайте ответим на несколько вопросов', style: TextStyles.SansReg, textAlign: TextAlign.center),
          Padding(padding: EdgeInsets.all(20),
          child: questions[currentSteps])
        ],
      )
    );
  }
}
