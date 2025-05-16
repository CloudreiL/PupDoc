import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pupdoc/classes/style.dart';

class PostCommentsPage extends StatefulWidget {
  final String postId;
  final Color userNicknameColor;

  const PostCommentsPage({super.key, required this.postId, required this.userNicknameColor});

  @override
  _PostCommentsPageState createState() => _PostCommentsPageState();
}

class _PostCommentsPageState extends State<PostCommentsPage> {
  late DatabaseReference _commentsRef;

  @override
  void initState() {
    super.initState();
    _commentsRef = FirebaseDatabase.instance.ref('forum/posts/${widget.postId}/comments');
  }

  Future<List<Map<String, dynamic>>> fetchCommentsForPost(String postId) async {
    final commentsSnapshot = await FirebaseDatabase.instance
        .ref('forum/posts/$postId/comments')
        .get();

    if (!commentsSnapshot.exists || commentsSnapshot.value == null) {
      return [];
    }

    final commentsRaw = commentsSnapshot.value as Map<dynamic, dynamic>;

    List<Map<String, dynamic>> comments = [];

    commentsRaw.forEach((key, value) {
      final comment = Map<String, dynamic>.from(value);
      comments.add({
        'nickname_color': widget.userNicknameColor,
        'description': comment['comment_descr'] ?? '',
        'comment_author_uid': comment['comment_author_uid'] ?? '',
        'comment_author_nickname': comment['comment_author_nickname'] ?? '',
        'comment_author_avatar': comment['comment_author_avatar'] ?? 'default.png',
        'created_at': comment['created_at'] ?? '',
      });
    });

    return comments;
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchCommentsForPost(widget.postId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: ColorsPalette.Cian));
        } else if (snapshot.hasError) {
          print('ERR:${snapshot.error}');
          return Center(child: Text('Ошибка загрузки'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Комментариев нет'));
        }

        final comments = snapshot.data!;

        return Expanded(
          child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final comment = comments[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(14.0),
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
                      /// Аватар + ник + дата
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              "lib/assets/png/iconsAccount/${comment["comment_author_avatar"]}",
                              width: 36,
                              height: 36,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '@${comment['comment_author_nickname']}',
                                style: TextStyles.SansBold.copyWith(color: comment['nickname_color'], fontSize: 14)
                              ),
                              Text(
                                comment['created_at'].toString().split('T').first,
                                style: TextStyles.SansReg.copyWith(fontSize: 12)
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
          
                      // Описание комментария
                      Text(
                        comment['description'],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
