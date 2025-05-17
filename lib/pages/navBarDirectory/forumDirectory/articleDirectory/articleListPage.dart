import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pupdoc/pages/navBarDirectory/forumDirectory/postDirectory/postPage.dart';

import '../../../../classes/style.dart';
import '../../../../services/firebase_functions.dart';
import 'articlePage.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({super.key});

  @override
  _ArticleListPage createState() => _ArticleListPage();
}

class _ArticleListPage extends State<ArticleList> {
  late DatabaseReference _postsRef;

  @override
  void initState() {
    super.initState();
    _postsRef = FirebaseDatabase.instance.ref('forum/article');
  }


  Future<List<Map<String, dynamic>>> _fetchPostsWithUserData() async {
    final postsSnapshot = await _postsRef.get();
    if (!postsSnapshot.exists) return [];

    final Map<dynamic, dynamic> articlesData = postsSnapshot.value as Map<dynamic, dynamic>;

    List<Map<String, dynamic>> articles = [];

    for (var entry in articlesData.entries) {
      final articleId = entry.key;
      final article = Map<String, dynamic>.from(entry.value);

      final authorUid = article['author_uid'] ?? '';
      final topic = article['topic'] ?? '';
      final description = article['description'] ?? '';

      String nickname = 'Неизвестно';
      String profileImage = 'catLoversFemale.png';
      Color? userNicknameColor = Colors.grey;

      try {
        final userSnapshot = await FirebaseDatabase.instance
            .ref('users/$authorUid/info')
            .get();

        if (userSnapshot.exists) {
          final userInfo = Map<String, dynamic>.from(userSnapshot.value as Map);
          nickname = userInfo['nickname'] ?? 'Неизвестно';
          profileImage = userInfo['profileImage'] ?? 'default.png';
        }
      } catch (e) {
        print('Ошибка при получении user info: $e');
      }

      try{
        final userRoleBase = await FirebaseFunctions.getUsersRoles(userUID: authorUid);
        print(userRoleBase);
        if(userRoleBase == 'owner'){
          userNicknameColor = ColorsPalette.DarkCian;
        }else if(userRoleBase == 'vet'){
          userNicknameColor = ColorsPalette.DarkGreen;
        }else{
          userNicknameColor = Colors.red;
        }
      }catch(e){
        print('Ошибка получения роли: $e');
      }


      articles.add({
        'postId': articleId,
        'topic': topic,
        'description': description,
        'nickname': nickname,
        'profileImage': profileImage,
        'userNicknameColor': userNicknameColor,
      });
    }

    return articles;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchPostsWithUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: ColorsPalette.Cian,));
        } else if (snapshot.hasError) {
          print('Ошибка: ${snapshot.error}');
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Нет постов'));
        }

        final articles = snapshot.data!;

        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (index) => ArticlePage(
                        authorImage: article['profileImage'],
                        authorNickname: article['nickname'],
                        postTopic: article['topic'],
                        postDescr: article['description'],
                        userNicknameColor: article['userNicknameColor'],
                      )
                      )
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ава+ник
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              "lib/assets/png/iconsAccount/${article["profileImage"]}",
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article['topic'].toString().length > 20
                                    ? '${article['topic'].substring(0, 20)}...'
                                    : article['topic'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                '@${article['nickname']}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: article['userNicknameColor'],
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Icon(Icons.bookmark_border, color: Colors.grey[400]),
                        ],
                      ),
                      const SizedBox(height: 10),

                      //текст поста
                      Text(
                        article['description'].toString().length > 100
                            ? '${article['description'].substring(0, 100)}...'
                            : article['description'],
                        style: const TextStyle(fontSize: 14),
                      ),

                    ],
                  ),
                ),
              ),
            );
          },
        );

      },
    );
  }
}
