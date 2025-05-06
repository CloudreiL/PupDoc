import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pupdoc/classes/profilePicture.dart';
import 'package:pupdoc/pages/navBarDirectory/mainDirectory/accountDirectory/accpage.dart';
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
      print('ERR: $e');
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
                child: ProfilePicture(size: 50)
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
                    Text("Питомцы", style: TextStyles.SansReg.copyWith(fontSize: 25)),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          3, (index) => GestureDetector(
                          onTap: (){print(index);},
                            child: Container(
                              width: 150,
                              height: 150,
                              margin: EdgeInsets.only(top: 10, right: 10),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(69, 123, 196, 0.9),
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                        child: Text("Уведомления", style: TextStyles.SansReg.copyWith(fontSize: 25))
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
