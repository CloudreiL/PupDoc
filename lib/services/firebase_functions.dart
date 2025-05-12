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

}
