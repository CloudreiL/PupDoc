
import 'package:flutter/material.dart';
import 'package:pupdoc/pages/navBarDirectory/forumDirectory/articleDirectory/articleListPage.dart';
import 'package:pupdoc/pages/navBarDirectory/forumDirectory/postDirectory/postListPage.dart';

import '../../../classes/style.dart';
import '../../../services/firebase_functions.dart';
import 'postDirectory/createPostPage.dart';


class ForumPage extends StatefulWidget{
  const ForumPage({super.key});

  @override
  _ForumPageState createState() => _ForumPageState();

}

class _ForumPageState extends State<ForumPage>{

  bool isPressedPosts = true;
  bool isPressedVet = false;

  Color _colorBackgroundPosts = ColorsPalette.LightCian;
  Color _colorTextPosts = ColorsPalette.DarkCian;

  Color _colorBackgroundVet = ColorsPalette.LightGreen;
  Color _colorTextVet = ColorsPalette.DarkGreen;

  String? userRole;

  @override
  void initState(){
    super.initState();
    _getUserRole();
    changeColor();
  }

  Future<void> _getUserRole() async{
    final userRoleBase = await FirebaseFunctions.getUserRole();
    print(userRoleBase);
    if(userRoleBase != null){
      setState(() {
        userRole = userRoleBase;
      });
    }
  }

  void changeColor(){
    Color defColorBackgroundButton = Color.fromRGBO(240, 240, 240, 1);
    Color defColorTextButton = Colors.black26;
    String? userRole;

    if(isPressedPosts == true){
      _colorBackgroundPosts = ColorsPalette.LightCian;
      _colorTextPosts = ColorsPalette.DarkCian;
    }else{
      _colorBackgroundPosts = defColorBackgroundButton;
      _colorTextPosts = defColorTextButton;
    }
    if(isPressedVet == true){
      _colorBackgroundVet = ColorsPalette.LightGreen;
      _colorTextVet = ColorsPalette.DarkGreen;
    }else if(isPressedVet == false){
      _colorBackgroundVet = defColorBackgroundButton;
      _colorTextVet = defColorTextButton;
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
              title: Text('Форум', style: TextStyles.SansReg.copyWith(fontSize: 25, color: Colors.white)),
              backgroundColor: Colors.transparent
          ),
          body: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.7,
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
                      Row(
                        children: [
                          //Кнопка посты
                          GestureDetector(
                            onTap: (){
                              if(isPressedPosts == false){
                                setState(() {
                                  isPressedPosts = !isPressedPosts;
                                  isPressedVet = !isPressedVet;
                                  print("Posts: $isPressedPosts, vet: $isPressedVet");
                                });
                                changeColor();
                              }
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: 85,
                              height: 30,
                              decoration: BoxDecoration(
                                color: _colorBackgroundPosts,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                              ),
                              alignment: Alignment.center,
                              child: Text("Посты", style: TextStyles.SansReg.copyWith(fontSize: 16, color: _colorTextPosts)),
                            ),
                          ),
                          SizedBox(width: 10),
                          //Кнопка статей
                          GestureDetector(
                            onTap: (){
                              if(isPressedVet == false){
                                setState(() {
                                  isPressedVet = !isPressedVet;
                                  isPressedPosts = !isPressedPosts;
                                  print("Vet: $isPressedVet, posts: $isPressedPosts");
                                });
                                changeColor();
                              }
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: 190,
                              height: 30,
                              decoration: BoxDecoration(
                                color: _colorBackgroundVet,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text("Статьи ветеренаров", style: TextStyles.SansReg.copyWith(fontSize: 16, color: _colorTextVet)),
                            ),
                          ),
                          SizedBox(width: 25),
                          //Кнопка создания постов/статей
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder:  (context) => CreatePostPage())
                              );
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:  ColorsPalette.DarkCian
                              ),
                              child: Icon(Icons.add_rounded, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 600),
                            switchInCurve: Curves.easeOutQuart,
                            switchOutCurve: Curves.easeInQuart,
                            transitionBuilder: (Widget child, Animation<double> animation){
                                final isPosts = child.key == const ValueKey('posts');

                                final offsetAnimation = Tween<Offset>(
                                  begin: Offset(isPosts ? -1.0 : 1.0, 0),
                                  end: Offset.zero,
                                ).animate(animation);

                                return SlideTransition(position: offsetAnimation, child: child,);
                            },
                            child: isPressedPosts
                              ? const PostList(key: ValueKey('posts'))
                                : const ArticleList(key: ValueKey('articles'))
                          )
                      )
                    ],
                  )
                ),
              ),
            ],
          )
      )
    );
  }
}