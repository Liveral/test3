import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test3/login_page.dart';
class InfoPage extends StatefulWidget{
  @override

  _InfoPage createState()=> _InfoPage();
}

final storage = new FlutterSecureStorage();
class _InfoPage extends State<InfoPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('내 정보',style: TextStyle(fontSize: 50),),

      ),

      body: Center(

        child: Column(
          children:[
          ElevatedButton(
            onPressed: () {
      print('LogOut Button');
      storage.delete(key: "jwt");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (BuildContext context) =>
              LoginPage()), (route) => false);
            },
        child: Text("로그아웃"),
      ),
      ],
    ),
    ),
    );
  }
}