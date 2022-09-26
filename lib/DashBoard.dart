import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashBoard extends StatelessWidget{
  Items item1=new Items(
    title : 'SEARCH',
    img:"assets/images/search_icon.svg",
  );
  Items item2=new Items(
    title : 'CALENDAR',
    img:"assets/images/calendar_icon.svg",
  );
  Items item3=new Items(
    title : 'INFORMATION',
    img:"assets/images/book_icon.svg",
  );

  @override
  Widget build(BuildContext context){
    List<Items> myList=[item1,item2,item3];
    return Flexible(child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16,right: 16),
        crossAxisSpacing: 18,
        crossAxisCount: 2,
        mainAxisSpacing: 18,
      children: myList.map((data){
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(40))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(data.img,width: 42,),
              SizedBox(height: 14,),
              Text(data.title,style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w600),),

            ],
          ),
        );
      }).toList(),
    ),
    );
  }
}

class Items{
  String title;
  String img;
  Items ({required this.title, required this.img});
}