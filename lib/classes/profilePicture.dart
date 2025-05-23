import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_database/firebase_database.dart";
import "package:flutter/material.dart";
import "package:pupdoc/services/firebase_functions.dart";

class ProfilePicture extends StatefulWidget{
  final double size;

  const ProfilePicture({super.key, this.size = 100});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  final user = FirebaseAuth.instance.currentUser;
  String? userPicture;

  @override
  void initState() {
    super.initState();
    userPicture;
    _requestProfileImage();
  }

  Future<void> _requestProfileImage() async{
    final userPictureBase = await FirebaseFunctions.getUserProfileImage();
    if(userPictureBase != null){
      setState(() {
        userPicture = userPictureBase;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle
      ),
      child: ClipOval(
        child: userPicture == null
            ? Center(
          child: SizedBox(
            height: widget.size,
            width: widget.size,

            child: CircularProgressIndicator(
              strokeWidth: 15,
              color: Color.fromRGBO(109, 220, 225, 1.0)
            ),
          )
        )
            : Image.asset("lib/assets/png/iconsAccount/$userPicture")
      )
    );
  }
}

