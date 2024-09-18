
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class  fullscreen extends StatelessWidget {
  final String imgurl;
  const fullscreen({super.key,required this.imgurl});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: Text("Full Screen",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(child: Image.network(imgurl,
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        fit: BoxFit.cover,
      ),),
    );
  }
}
