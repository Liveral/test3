import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test3/DashBoard.dart';
class MainPage extends StatefulWidget{
@override
_MainPage createState()=> _MainPage();
}

class _MainPage extends State<MainPage>{



@override
Widget build(BuildContext context){

return Scaffold(
  backgroundColor: Color(0xfff7f8f9),
body: Column(

  children: <Widget>[
    SizedBox(height: 60,),

    Padding(padding: EdgeInsets.only(left: 16, right: 16),
      child: Center(
        child:
       SvgPicture.asset("assets/images/shopping_1.svg",width: 150,height: 150,alignment: Alignment.center,),
    )
      ,),
    SizedBox(height: 20,),

    Text("HEALTHY SHOPPING",style: TextStyle(fontFamily: "Bebas",fontSize: 40),),

    SizedBox(height: 40,),


    Container(
      alignment: Alignment.topLeft,
      child: Text("    SERVICES",textAlign: TextAlign.left,style: TextStyle(fontSize: 20,
                  fontFamily: 'Bebas'),),
    ),
    SizedBox(height: 15,),

    DashBoard()
  ],

)


);

}

}

