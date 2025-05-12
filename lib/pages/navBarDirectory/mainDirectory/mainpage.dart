import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pupdoc/classes/profilePicture.dart';
import 'package:pupdoc/pages/navBarDirectory/mainDirectory/accountDirectory/accpage.dart';
import 'package:pupdoc/pages/navBarDirectory/mainDirectory/petDirectory/petsPage.dart';
import 'package:pupdoc/services/firebase_functions.dart';
import '../../../classes/style.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {
  User? user = FirebaseAuth.instance.currentUser;
  String? userName;
  String _backgroundTimeImage = "lib/assets/png/background/stateBackground/morningBackground.png";
  String _welcomeTimeText = "Доброе утро";
  Color _colorTimeText = Colors.black;

  List<Map<String, dynamic>> _pets = [];
  bool _isLoadingPets = true;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _setBackgroundImage();
    _loadPets();
  }

  void _setBackgroundImage(){
    final hour = DateTime.now().hour;
    print(hour);

    if(hour >= 5 && hour < 12){
      _backgroundTimeImage = "lib/assets/png/background/stateBackground/morningBackground.png";
      _welcomeTimeText = "Доброе утро";
      Color _colorTimeText = Colors.black;
    }else if(hour >= 12 && hour < 18){
      _backgroundTimeImage = "lib/assets/png/background/stateBackground/dayBackground.jpg";
      _welcomeTimeText = "Добрый день";
      Color _colorTimeText = Colors.black;
    }else{
      _backgroundTimeImage = "lib/assets/png/background/stateBackground/nightBackground.jpg";
      _welcomeTimeText = "Доброй ночи";
      Color _colorTimeText = Colors.white;
    }
  }

  Future<void> _loadUserName() async{
    final nameBase = await FirebaseFunctions.getUserName();
    if(nameBase!= null){
      setState(() {
        userName = nameBase;
      });
    }
  }
  Future<void> _loadPets() async{
    final pets = await FirebaseFunctions.getUserPets();
    setState(() {
      _pets = pets;
      _isLoadingPets = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_backgroundTimeImage),
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
                "$_welcomeTimeText, $userName",
                style: TextStyles.SansBold.copyWith(color: _colorTimeText),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AccPage(userName: userName)),
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
                child:
                _isLoadingPets == true
                    ? Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                        strokeWidth: 10,
                        color: Color.fromRGBO(109, 220, 225, 1.0)
                    ),
                  ),
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => PetsPage()),
                        );
                      },
                        child: Text("Питомцы", style: TextStyles.SansReg.copyWith(fontSize: 25))
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                        _pets.length, (index){
                          final pet = _pets[index];
                          final petType = pet['pet_type'];
                          
                          final imagePath = petType == 'dog'
                              ? 'lib/assets/png/iconsPet/dog.png'
                              : 'lib/assets/png/iconsPet/cat.png';
                          
                          return GestureDetector(
                            onTap: (){
                              print('${pet['pet_name']} tapped');
                            },
                            child: Container(
                              width: 150,
                              height: 150,
                              margin: const EdgeInsets.only(top: 10, right: 10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin:Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors:[Color.fromRGBO(69, 123, 196, 0.9), Color.fromRGBO(109, 220, 225, 1.0)]),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(pet['pet_name'], style: TextStyles.SansBold.copyWith(color: Colors.white),),
                                  Image.asset(imagePath, width: 80, height: 80)
                                ],
                              ),
                            ),
                          );
                            }
                        )
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
