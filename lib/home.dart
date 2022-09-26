import 'package:flutter/material.dart';
import 'package:test3/info_page.dart';
import 'package:image_picker/image_picker.dart';
import 'camera_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'info_page.dart';
import 'dart:io';
import 'main_page.dart';

class Home extends StatefulWidget{
  @override
  _Home createState()=> _Home();
}


class _Home extends State<Home>{
  int currentTab=0;
  final GlobalKey<ScaffoldState> _globalKey=GlobalKey();
  DateTime? currentBackPressTime;


  final List<Widget> screens=[
    MainPage(),
    InfoPage()
  ];

  final PageStorageBucket bucket=PageStorageBucket();
  Widget currentScreen=MainPage();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _globalKey,
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: Container(
        height: 80,
        width: 80,
        child: FittedBox(
            child:FloatingActionButton(
              backgroundColor:Colors.white,
              child: Icon(Icons.camera_alt_outlined,color: Color(0xff1B63F2),),

              onPressed: () async{
                Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage()),);

              },)
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 40,),
                  MaterialButton(
                      minWidth: 40,
                      onPressed: (){
                        setState(() {
                          currentScreen=MainPage();
                          currentTab=0;
                        });
                      },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home_rounded,
                        size: 30,
                        color: currentTab==0?Color(0xff1B63F2):Colors.grey,
                      ),

                    ],
                  ),
                  ),
                  SizedBox(width: 180,),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen=InfoPage();
                        currentTab=1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outline_rounded,
                          size: 30,
                          color: currentTab==1?Color(0xff1B63F2):Colors.grey,
                        ),

                      ],
                    ),
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}