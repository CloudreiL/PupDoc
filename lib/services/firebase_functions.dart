import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseFunctions{
  //получить имя
  static Future<String?> getUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;

    final DatabaseReference ref = FirebaseDatabase.instance.ref("users/${user?.uid}/info/name");

    try {
      final snapshot = await ref.get();
      if (snapshot.exists) {
        return snapshot.value.toString();
      }
    } catch (e) {
      print('ERR: $e');
    }
    return null;
  }

  //получить никнейм
  static Future<String?> getUserNickname() async{
    User? user = FirebaseAuth.instance.currentUser;
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid == null) return null;

    final DatabaseReference ref = FirebaseDatabase.instance.ref("users/${user!.uid}/info/nickname");

    try{
      final snapshot = await ref.get();
      if(snapshot.exists){
        return snapshot.value.toString();
      }
    }catch (e) {
      print('ERR: $e');
    }
    return null;
  }

  //Запрос роли
  static Future<String?> getUserRole() async{
    User? user = FirebaseAuth.instance.currentUser;
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid == null) return null;

    final DatabaseReference ref = FirebaseDatabase.instance.ref("users/${user!.uid}/info/role");

    try{
      final snapshot = await ref.get();
      if(snapshot.exists){
        return snapshot.value.toString();
      }
    }catch(e){
      print('ERR: $e');
    }
    return null;
  }

  static Future<String?> getUserProfileImage() async{
    User? user = FirebaseAuth.instance.currentUser;
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid == null) return null;

    final DatabaseReference ref = FirebaseDatabase.instance.ref("users/${user?.uid}/info/profileImage");
    try{
      final snapshot = await ref.get();
      if(snapshot.exists){
        return snapshot.value.toString();
      }
    }catch(e){
      print('ERR: $e');
    }
  }

  //Запрос ролей
  static Future<String?> getUsersRoles({
    required String userUID
}) async{
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid == null) return null;

    final DatabaseReference ref = FirebaseDatabase.instance.ref("users/$userUID/info/role");

    try{
      final snapshot = await ref.get();
      if(snapshot.exists){
        return snapshot.value.toString();
      }
    }catch(e){
      print('ERR: $e');
    }
    return null;
  }

  //выход из акка
  static Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }

  //запрос питомцев
  static Future<List<Map<String, dynamic>>> getUserPets() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return [];

    final ref = FirebaseDatabase.instance.ref("users/$uid/info/pets");

    try {
      final snapshot = await ref.get();
      if (snapshot.exists) {
        final List petsList = snapshot.value as List;
        return petsList
            .where((pet) => pet != null)
            .map((pet) => {
          'pet_name': pet['pet_name'] ?? '',
          'pet_type': pet['pet_type'] ?? '',
        })
            .toList();
      }
    } catch (e) {
      print('Ошибка получения списка питомцев: $e');
    }

    return [];
  }

  //создается пост ААААААААААААААААААААААААААА
  static Future<bool> createForumPost({
    required String topic,
    required String description
  })async{
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid == null) return false;

    if(topic.trim().isEmpty || description.trim().isEmpty){
      print('Не все поля заполнены');
    }

    final nicknameBase = await getUserNickname();

    final DatabaseReference ref = FirebaseDatabase.instance.ref('forum/posts').push();
    final String? postID = ref.key;

    if(postID == null){
      print('Ошибка не удалось получить ключ записи');
      return false;
    }

    final post = {
      'topic': topic.trim(),
      'description': description.trim(),
      'author_uid': uid,
      'author_nickname': nicknameBase ?? 'unknown',
      'created_at': DateTime.now().toIso8601String(),
      'comments': []
    };
    try{
      await ref.set(post);
      return true;
    }catch(e){
      print('ERR: $e');
      return false;
    }

  }

  //Отправка комментариев
  static Future<bool> createCommentPost({
    required String? postID,
    required comment_descr,
  }) async{
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid == null) return false;

    if(comment_descr.trim().isEmpty){
      print('Не все поля заполнены');
    };

    final comment_author_nickname = await getUserNickname();
    final comment_author_avatar = await getUserProfileImage();

    final DatabaseReference ref = FirebaseDatabase.instance.ref('forum/posts/$postID/comments').push();
    final String? commentID = ref.key;

    if(commentID == null){
      print('Ошибка не удалось получить ключ комментария');
      return false;
    }

    final comment = {
      'comment_descr': comment_descr.trim(),
      'comment_author_uid': uid,
      'comment_author_nickname': comment_author_nickname ?? 'unknown',
      'comment_author_avatar': comment_author_avatar,
      'created_at': DateTime.now().toIso8601String(),
    };
    try{
      await ref.set(comment);
      return true;
    }catch(e){
      print('ERR: $e');
      return false;
    }
  }
}


