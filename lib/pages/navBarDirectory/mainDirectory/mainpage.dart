import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pupdoc/pages/navBarDirectory/mainDirectory/accpage.dart';
import '../../../classes/style.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {
  User? user = FirebaseAuth.instance.currentUser;
  String? userName;

  @override
  void initState() {
    super.initState();
    _requestName();
  }

  Future<void> _requestName() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final DatabaseReference ref = FirebaseDatabase.instance.ref("users/${user?.uid}/info/name");

    try {
      final snapshot = await ref.get();
      if (snapshot.exists) {
        setState(() {
          userName = snapshot.value.toString();
        });
      }
    } catch (e) {
      print('Ошибка при получении имени: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/png/background/stateBackground/morningBackground.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Доброе утро, $userName",
                style: TextStyles.SansBold,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AccPage()),
                  );
                },
                child: Image.asset(
                  "lib/assets/png/icons/dogLoversFemale.png",
                  height: 50,
                ),
              ),
            ],
          ),
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
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Питомцы", style: TextStyles.SansReg),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          width: 150,
                          height: 150,
                          margin: EdgeInsets.only(top: 10),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
