import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test3/home.dart';
import 'package:test3/login_page.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashPage extends StatelessWidget{
  const SplashPage({Key? key}): super(key: key);
  static final storage = new FlutterSecureStorage();
  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    String? userInfo = await storage.read(key: "jwt");
    print(userInfo);
    if (userInfo != null) {
      Get.to(Home());

    }
    else{
      Get.to(LoginPage());
    }
  }
  @override
  Widget build(BuildContext context){
    Timer(const Duration(seconds: 2),() {
      //storage.delete(key: "jwt");
      _asyncMethod();

    }
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body:Center(
        child: SvgPicture.asset(
          'assets/images/shopping_1.svg',
          width: 100,
          height: 100,
        ),
      )

    );
  }
  Widget logo() {
    return Image.asset('assets/images/shopping_1.svg');
  }
}




