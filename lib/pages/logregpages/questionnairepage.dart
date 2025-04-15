import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

import '../../classes/style.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage ({super.key});

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage>{

  int questionSteps = 1;
  int currentSteps = 0;
  final int totalSteps = 3;
  final List<Widget> questions = [];
  final Map<int, dynamic> answers = {};

  // void prevStep(){
  //   if(currentSteps > 1){
  //     setState(() {
  //       currentSteps--;
  //     });
  //   }
  // }

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
      QuestionTextField(
          question: "Как зовут вашего питомца?",
          onNext: (answer){
            answers[2] = answer;
            nextStep();
          }),
    ]);
  }

  void nextStep(){
    if(currentSteps < totalSteps){
      setState(() {
        currentSteps++;
        questionSteps++;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$questionSteps вопрос из $totalSteps', style: TextStyles.SansReg.copyWith(color: Colors.black)),
        centerTitle: true
      ),
      body: Column(
        children: [
          LinearProgressBar(
            maxSteps: totalSteps,
            progressType: LinearProgressBar.progressTypeLinear,
            currentStep: questionSteps,
            progressColor: Color.fromRGBO(69, 123, 196, 1.0),
            backgroundColor: Color.fromRGBO(69, 123, 196, 0.10588235294117647),
            minHeight: 5,
          ),
          SizedBox(height: 20),
          Text('Отлично! Перед тем как перейти к приложению, давайте ответим на несколько вопросов', style: TextStyles.SansReg, textAlign: TextAlign.center),
          Padding(padding: EdgeInsets.all(20),
          child: questions[currentSteps])
        ],
      )
    );
  }
}



//
//Quiestion classes
//

class QuestionTextField extends StatefulWidget{
  final String question;
  final Function(String) onNext;

  const QuestionTextField({
    super.key,
    required this.question,
    required this.onNext
  });

  @override
  State<QuestionTextField> createState() => _QuestionTextFieldState();
}

class _QuestionTextFieldState extends State<QuestionTextField> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(widget.question, style: TextStyles.SansReg),
        const SizedBox(height: 18),
        TextField(
          controller: textController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(height: 24,),
        Align(
          alignment: Alignment.bottomCenter,
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
              onPressed: (){
                widget.onNext(textController.text);
              },
              child: Text('Далее')
          )
        ),
      ],
    );
  }
}

class QuestionOptions extends StatelessWidget{
  final String question;
  final List<String> options;
  final Function(String) onNext;

  const QuestionOptions({
    super.key,
    required this.question,
    required this.options,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 12),
        ...options.map((opt) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: OutlinedButton(
            onPressed: () {
              onNext(opt);
            },
            child: Text(opt),
          ),
        )),
      ],
    );
  }
}