import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pupdoc/classes/style.dart';

class QuestionTextField extends StatefulWidget{
  final String question;
  final Function(String) onNext;
  final bool englishOnly;

  const QuestionTextField({
    super.key,
    required this.question,
    required this.onNext,
    this.englishOnly = false
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
          decoration: TextFields.FieldDec.copyWith(
            hintText: widget.englishOnly ? 'Только английские буквы и цифры' : null,
          ),
          inputFormatters: widget.englishOnly
              ? [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
            // Разрешаем буквы a-z, A-Z, цифры 0-9 и подчеркивание
          ]
              : null,
        ),
        const SizedBox(height: 24),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(question, style: TextStyles.SansReg.copyWith(fontSize: 18), textAlign: TextAlign.center,),
        const SizedBox(height: 12),
        ...options.map((opt) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: OutlinedButton(
            onPressed: () {
              onNext(opt);
            },
            child: Text(opt, style: TextStyles.SansReg.copyWith(fontSize: 16)),
          ),
        )),
      ],
    );
  }
}