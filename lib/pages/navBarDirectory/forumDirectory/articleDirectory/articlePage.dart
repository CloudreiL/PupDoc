import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../classes/style.dart';

class ArticlePage extends StatefulWidget{

  String? authorImage;
  String? authorNickname;
  String? postTopic;
  String? postDescr;
  Color userNicknameColor;

  ArticlePage({Key? key,
    required this.authorImage,
    required this.authorNickname,
    required this.postDescr,
    required this.postTopic,
    required this.userNicknameColor
  }) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>{

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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                        SizedBox(height: 30,)
                    ]
                  ),
                )
            )
            )
          ],
        ),
      ),
    );
  }
}