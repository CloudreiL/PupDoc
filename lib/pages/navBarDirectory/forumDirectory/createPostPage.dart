import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../classes/style.dart';

class CreatePostPage extends StatefulWidget{
  const CreatePostPage({super.key});

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage>{

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
                title: Text('Создать пост', style: TextStyles.SansReg.copyWith(fontSize: 25, color: Colors.white)),
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
                              decoration: TextFields.FieldDec.copyWith(labelText: 'Тема',),
                            maxLength: 300,
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
                                  decoration: TextFields.FieldDec.copyWith(
                                      labelText: "Описание",

                                  ),
                                  maxLength: 1500,
                                  expands: true,
                                  maxLines: null,
                                  textAlignVertical: TextAlignVertical.top,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: (){},
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


