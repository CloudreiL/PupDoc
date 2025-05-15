import 'package:flutter/cupertino.dart';

import '../../../../classes/style.dart';

class PostCommentsPage extends StatefulWidget{
  const PostCommentsPage({super.key});

  @override
  _PostCommentsPageState createState() => _PostCommentsPageState();
}

class _PostCommentsPageState extends State<PostCommentsPage>{

  @override
  Widget build(BuildContext context){
    return Center(
        child: Text('Комментариев пока нет',
          style: TextStyles.SansReg.copyWith(fontSize: 20),)
    );
  }
}