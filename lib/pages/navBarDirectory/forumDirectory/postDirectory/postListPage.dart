import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pupdoc/pages/navBarDirectory/forumDirectory/postDirectory/postPage.dart';

import '../../../../classes/style.dart';
import '../../../../services/firebase_functions.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  late DatabaseReference _postsRef;

  @override
  void initState() {
    super.initState();
    _postsRef = FirebaseDatabase.instance.ref('forum/posts');
  }


  Future<List<Map<String, dynamic>>> _fetchPostsWithUserData() async {
    final postsSnapshot = await _postsRef.get();
    if (!postsSnapshot.exists) return [];

    final Map<dynamic, dynamic> postsData = postsSnapshot.value as Map<dynamic, dynamic>;

    List<Map<String, dynamic>> posts = [];

    for (var entry in postsData.entries) {
      final postId = entry.key;
      final post = Map<String, dynamic>.from(entry.value);

      final authorUid = post['author_uid'] ?? '';
      final topic = post['topic'] ?? '';
      final description = post['description'] ?? '';

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

      posts.add({
        'postId': postId,
        'topic': topic,
        'description': description,
        'nickname': nickname,
        'profileImage': profileImage,
        'userNicknameColor': userNicknameColor,
      });
    }
    return posts;
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

        final posts = snapshot.data!;

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (index) => PostPage(
                        postID: post['postId'],
                        authorImage: post['profileImage'],
                        authorNickname: post['nickname'],
                        postTopic: post['topic'],
                        postDescr: post['description'],
                        userNicknameColor: post['userNicknameColor'],
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
                              "lib/assets/png/iconsAccount/${post["profileImage"]}",
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
                                post['topic'].toString().length > 20
                                    ? '${post['topic'].substring(0, 20)}...'
                                    : post['topic'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                '@${post['nickname']}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: post['userNicknameColor'],
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
                        post['description'].toString().length > 100
                            ? '${post['description'].substring(0, 100)}...'
                            : post['description'],
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
