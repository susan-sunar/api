

import 'package:api/pages/splash.dart';
import 'package:api/views/homeview.dart';
import 'package:api/views/mvp%20detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // routes: {
      //   '/Mvpdetail': (context) => Mvpdetail(imageUrl: '', describtion: '', name: '',),
      //   // Add other routes as needed
      // },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:SplashScreen() ,
    );
  }
}

