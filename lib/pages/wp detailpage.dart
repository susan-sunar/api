
import 'package:api/pages/wp%20fullscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Wpdetail extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String describtion;
 const Wpdetail (
     {Key? key, required this.imageUrl, required this.name, required this.describtion})
     : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
          onPressed: () => Get.back(), // Navigate back
        ),
        title: Text(
          'Wallpics',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(imageUrl),fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 20,
                    left: 330,
                    child: GestureDetector(
                      onTap: (){
                        Get.to(fullscreen(imgurl:imageUrl,));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        height: 40,
                        width: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.fullscreen,color: Colors.grey,size: 30,)
                          ],
                        ),
                      ),
                    ))


              ],
              ),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  children: [
                    Text(describtion,style: TextStyle(
                        color: Colors.white,fontSize: 20,
                        fontWeight: FontWeight.bold,),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Icon(Icons.person,size: 20,color: Colors.white,),
                        SizedBox(width: 15,),
                        Text('photographer',style: TextStyle(
                            color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                        Spacer(),
                        Container(
                          width: 135,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),color:  Color(0xff343a40),
                          ),
                          child: Center(
                            child: Text(name,style: TextStyle(
                                color: Colors.white,fontSize: 15,
                                fontWeight: FontWeight.bold),),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.camera_alt,size: 20,color: Colors.white,),
                        Text('photo by',style: TextStyle(color: Colors.white,
                            fontSize: 15,fontWeight: FontWeight.bold),),
                        Spacer(),
                        Container(
                          width: 70,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),color: Colors.white),
                          child: Center(
                            child: Text('pixel',style: TextStyle(
                                color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                          ),
                        )
                      ],
                    ),
                    // SizedBox(height: 20,),
                    // MaterialButton(
                    //   color: Colors.white,
                    //   onPressed: (){},
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text("DOWNLOAD",style: TextStyle(color: Colors.black),),
                    //       Icon(Icons.download_for_offline_outlined,color: Colors.black,)
                    //     ],
                    //   ),)
                  ],
                ),
              )
            ],

              ),
      )



    );
  }
}
