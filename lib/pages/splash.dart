
import 'dart:async';
import 'package:api/pages/wphomepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    Timer(Duration(seconds: 5),
        ()=>Get.offAll(()=>Wphomepage()),
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Splash screen background color
      body: Center(
        child: SizedBox(
          width:double.infinity,
            height: double.infinity,
            child: Image.asset('assets/images/nature.jpg',fit: BoxFit.cover,)), // Splash screen image
      ),
    );
  }
}

