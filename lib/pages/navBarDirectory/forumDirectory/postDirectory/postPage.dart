import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pupdoc/pages/navBarDirectory/forumDirectory/postDirectory/postCommentsList.dart';
import '../../../../classes/style.dart';
import '../../../../services/firebase_functions.dart';

class PostPage extends StatefulWidget{

  String? authorImage;
  String? authorNickname;
  String? postTopic;
  String? postDescr;
  String postID;
  Color userNicknameColor;

  PostPage({Key? key,
    required this.authorImage,
    required this.authorNickname,
    required this.postDescr,
    required this.postTopic,
    required this.postID,
    required this.userNicknameColor
  }) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage>{

  TextEditingController commentController = TextEditingController();

  @override
  Future<void> sendCommentBase() async{
    final commentBase = commentController.text.trim();
    final postBaseID = widget.postID;

    final success = await FirebaseFunctions.createCommentPost(
        comment_descr: commentBase.trim(),
        postID: postBaseID
    );

    if(success){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Комментарий отправлен! :)'),
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
            backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Stack(
          children: [
            Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)
                    )
                ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('lib/assets/png/iconsAccount/${widget.authorImage}',width: 50),
                        SizedBox(width: 5,),
                        Text('@${widget.authorNickname}',
                          style: TextStyles.SansReg.copyWith(color: widget.userNicknameColor, fontSize: 15))
                  ]),
                  SizedBox(height: 10),
                  Text('${widget.postTopic}',
                      style: TextStyles.SansBold.copyWith(fontSize: 25)),
                  SizedBox(height: 10),
                  Text('${widget.postDescr}',
                      style: TextStyles.SansReg.copyWith(fontSize: 15)),
                  SizedBox(height: 30,),
                  Text('Комментарии', style: TextStyles.SansBold),
                  SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 100,
                          child: TextField(
                            controller: commentController,
                            decoration: TextFields.FieldDec.copyWith(
                              labelText: "Отправьте ответ",
                            ),
                            expands: true,
                            maxLength: 700,
                            maxLines: null,
                            textAlignVertical: TextAlignVertical.top,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: sendCommentBase,
                          child: Text('Отправить',style: TextStyles.SansReg.copyWith(color: Colors.white,fontSize: 15)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsPalette.DarkCian
                          )
                      ),
                      SizedBox(height: 20,),
                      PostCommentsPage()
                    ],
                  ),
                ],
              ),
            ),
              )
            )
          ],
        ),
      ),
    );
  }
}