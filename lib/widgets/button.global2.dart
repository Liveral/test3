import 'package:flutter/material.dart';
import 'package:test3/home.dart';
import 'package:test3/login_page.dart';

class ButtonGlobal2 extends StatelessWidget{

  const ButtonGlobal2 ({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);

      },
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
            color: Color(0xff1B63F2),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ]
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,

          ),
        ),
      ),
    );

  }
}