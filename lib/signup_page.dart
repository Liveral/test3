import 'package:flutter/material.dart';
import 'package:test3/login_page.dart';
import 'package:test3/widgets/button.global.dart';
import 'package:test3/widgets/button.global2.dart';
import 'package:test3/widgets/social.login.dart';
import 'package:test3/widgets/text.form.global.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

class SignUpPage extends StatelessWidget{

  SignUpPage({Key? key}) : super(key: key);
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();

  void SignUp(String email, password) async{
    try{
      Response response =await post(
          Uri.parse("http://52.78.65.92:8000/user"),
          body:{
            'email': email,
            'name' : "Messi",
            'password' : password
          }
      );
      if(response.statusCode==201){

        var data=jsonDecode(response.body.toString());
        print(data['data']['token']);

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
                  const SizedBox(height: 60,),

                  Container(

                    alignment: Alignment.center,
                    child:Text('Healthy Shopping',
                        style: GoogleFonts.bebasNeue(fontSize: 52)),
                  ),

                  const SizedBox(height: 40,),
                  Text('Create your Account',style: TextStyle(color: Colors.black,
                    fontSize: 16,fontWeight: FontWeight.w500,),),
                  const SizedBox(height: 15,),
                  TextFormGlobal(controller: emailController,text: 'Email',obscure: false,
                    textInputType: TextInputType.emailAddress,),
                  const SizedBox(height: 10,),
                  TextFormGlobal(controller: passwordController,text: 'Password',obscure: true,
                    textInputType: TextInputType.text,),
                  const SizedBox(height: 10,),
                  TextFormGlobal(controller: passwordController,text: 'Confirm Password',obscure: true,
                    textInputType: TextInputType.text,),
                  const SizedBox(height: 10,),
                  InkWell(onTap: (){
                    SignUp(emailController.text.toString(), passwordController.text.toString());
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