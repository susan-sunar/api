
import 'package:api/view%20model/mv%20view%20model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
class HomeView extends StatelessWidget {
  HomeView({super.key});
  List<Tab> catagories = [
    Tab(
      text: 'NATURE',
    ),
    Tab(
      text: 'CITY',
    ),
    Tab(
      text: 'CARS',
    ),
    Tab(
      text: 'AESTHETIC',
    ),
    Tab(
      text: 'ANIMAL',
    ),
    Tab(
      text: 'FLOWER',
    ),
  ];


  HomeViewModel ms = Get.put(HomeViewModel());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: catagories.length,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "Wallpics",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          bottom: TabBar(
            tabs: catagories,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.yellow
            ),
            unselectedLabelColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 0,
            dividerColor: Colors.white,
            physics: BouncingScrollPhysics(),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.black,
          ),
        ),
        body: TabBarView(
          children: catagories.map((tab) => customGridView(tab.text!.toLowerCase())).toList(),
        ),
      ),
    );
  }
  Widget customGridView(String category) {
    ms.mvGetwallpaperData(category);
    return GetBuilder<HomeViewModel>(
      builder: (_) {
        if(ms.isLoading) {
          return Center(child: CircularProgressIndicator(),);
        } else if(ms.wallpapers[category] == null) {
          return Center(child: Text("No data found"),);
        } else {
          return MasonryGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            itemCount: ms.vmwallpapers(category).length,
            itemBuilder: (context, index) {
              final photo = ms.vmwallpapers(category)[index];
              return GestureDetector(
                onTap: (){
                  Get.toNamed('/Mvpdetail', arguments: photo);
                },
                child: Hero(
                  tag: '${photo.imgurl}',
                  child: Container(
                    height: (index % 3 + 2) * 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(
                        int.parse(photo.avg_color.replaceAll("#", "0xff")),
                      ),
                      image: DecorationImage(
                          image: NetworkImage("${photo.imgurl}"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}