import 'package:flutter/material.dart';
import 'package:pupdoc/classes/animatedLinearBar.dart';
import 'package:pupdoc/classes/questionnaire.dart';

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
  final int totalSteps = 4;
  final List<Widget> questions = [];
  final Map<int, dynamic> answers = {};

  @override
  void initState(){
    super.initState();

    questions.addAll([
      QuestionTextField(
          question: "Как вас зовут?",
          onNext: (answer){
            answers[0] = answer;
            nextStep();
          }),
      QuestionOptions(
          question: "Вы ветеринар или владелец домашнего животного?",
          options: ["Я ветеринар", "Я владелец"],
          onNext: (answer){
            answers[1] = answer;
            nextStep();
          }),
      QuestionOptions(
          question: "Какой у вас питомец?",
          options: ["Кошка", "Собака", "Другое"],
          onNext: (answer){
            answers[2] = answer;
            nextStep();
          }),
      QuestionTextField(
          question: "Как зовут вашего питомца?",
          onNext: (answer){
            answers[3] = answer;
            toApp();
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
