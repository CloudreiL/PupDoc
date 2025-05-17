import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pupdoc/services/firebase_functions.dart';

import '../../../../classes/style.dart';

class CreateArticlePage extends StatefulWidget{
  const CreateArticlePage({super.key});

  @override
  _CreateArticlePageState createState() => _CreateArticlePageState();
}

class _CreateArticlePageState extends State<CreateArticlePage>{
  TextEditingController topicController = TextEditingController();
  TextEditingController descrController = TextEditingController();

  @override
  void dispose(){
    topicController.dispose();
    descrController.dispose();
    super.dispose();
  }

  Future<void> _createArticle() async{
    final topic = topicController.text.trim();
    final descr = descrController.text.trim();

    final success = await FirebaseFunctions.createForumArticle(
        topic: topic,
        description: descr);

    if(success){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Статья создана! :)'),
          duration: Duration(seconds: 2),
        ),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Что-то пошло не так.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/assets/png/background/forumBackground/forumCianBackground.png"),
              fit: BoxFit.cover
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('Создать статью', style: TextStyles.SansReg.copyWith(fontSize: 25, color: Colors.white)),
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.75,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)
                        )
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextField(
                            controller: topicController,
                            decoration: TextFields.FieldDec.copyWith(labelText: 'Тема',),
                            maxLength: 100,
                          ),
                        ),
                        SizedBox(height: 30),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 60),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.91,
                              child: Scrollbar(
                                thumbVisibility: true,
                                thickness: 7,
                                radius: Radius.circular(100),
                                scrollbarOrientation: ScrollbarOrientation.right,

                                child: TextField(
                                  controller: descrController,
                                  decoration: TextFields.FieldDec.copyWith(
                                    labelText: "Описание",
                                  ),
                                  maxLength: 3000,
                                  expands: true,
                                  maxLines: null,
                                  textAlignVertical: TextAlignVertical.top,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: _createArticle,
                            child: Text('Запостить',style: TextStyles.SansReg.copyWith(color: Colors.white,fontSize: 15)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsPalette.DarkCian
                            )
                        )
                      ],
                    ),

                  ),
                ),
              ],
            )
        )
    );
  }
}


