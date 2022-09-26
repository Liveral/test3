import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test3/signup_page.dart';
import 'package:test3/widgets/button.global.dart';
import 'package:test3/widgets/social.login.dart';
import 'package:test3/widgets/text.form.global.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';


import 'home.dart';

class LoginPage extends StatefulWidget{

  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
 String? userInfo = "";

 static final storage = new FlutterSecureStorage();

 @override
 void initState() {
   super.initState();

   //비동기로 flutter secure storage 정보를 불러오는 작업.
   WidgetsBinding.instance.addPostFrameCallback((_) {
     //_asyncMethod();
   });
 }
 _asyncMethod() async {
   //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
   //(데이터가 없을때는 null을 반환을 합니다.)
   userInfo = await storage.read(key: "jwt");
   print(userInfo);
   if (userInfo != null) {
     Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);

   }
 }


   //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.




 void login(String email, password) async{
    try{
      Response response =await post(
        Uri.parse("http://13.125.217.174:8000/user/login"),
        body:{
          'email': email,
          'password' : password
        }
      );
      if(response.statusCode==201){

        var data=jsonDecode(response.body.toString());
        await storage.write(key: 'jwt', value: 'token');
        print(data['data']['token']);
        print(userInfo);

      }
      else{
        print('failed');
      }

    }catch(e){

      print(e.toString());
    }
  }

  @override

  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child:Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100,),

                Container(

                  alignment: Alignment.center,
                    child:Text('Healthy Shopping',
                      style: GoogleFonts.bebasNeue(fontSize: 52)),
                ),

                    const SizedBox(height: 40,),
                    Text('Login to your account',style: TextStyle(color: Colors.black,
                      fontSize: 16,fontWeight: FontWeight.w500,),),
                    const SizedBox(height: 15,),
                TextFormGlobal(controller: emailController,text: 'Email',obscure: false,
                                textInputType: TextInputType.emailAddress,),
                const SizedBox(height: 10,),
                TextFormGlobal(controller: passwordController,text: 'Password',obscure: true,
                  textInputType: TextInputType.text,),
                const SizedBox(height: 10,),
                InkWell(onTap: (){
                  login(emailController.text.toString(), passwordController.text.toString());
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);
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
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,

                      ),
                    ),
                  ),),
                const SizedBox(height: 25,),
                SocialLogin(),
              ],
            ),
          )

        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Don\'t have an account?',style: TextStyle(color: Colors.black45), ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()),);

              },
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20,),
          ],

        ),

      ),

    );
}
}
