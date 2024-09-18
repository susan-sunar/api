
import 'package:api/model/wpmodel.dart';
import 'package:api/pages/wp%20detailpage.dart';
import 'package:api/services/wpservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class Wphomepage extends StatefulWidget {
  const Wphomepage({super.key});

  @override
  State<Wphomepage> createState() => _WallpaperhomeState();
}

class _WallpaperhomeState extends State<Wphomepage> {
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

  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  bool searchMode = false;


  SearchService _searchService = SearchService();


  void searchImages(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      searchMode = true;
    });
  }


  void resetSearch() {
    setState(() {
      searchMode = false;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: catagories.length,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: searchMode?IconButton(onPressed: resetSearch, icon:Icon(
            Icons.arrow_back_ios,color: Colors.white,),
          ):null,
          backgroundColor: Colors.black,
          title: Text(
            "Wallpics",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          bottom: searchMode
              ? null
              : TabBar(
            tabs: catagories,
            indicator: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(30)),
            unselectedLabelColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 0,
            dividerColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.black,
            physics: BouncingScrollPhysics(),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search wallpapers...",
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  suffixIcon: searchMode
                      ? IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: resetSearch, // Clear search
                  )
                      : null,
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                onSubmitted: (value) {
                  searchImages(value); // Trigger search on input
                },
              ),
            ),
            Expanded(
              child: searchMode
                  ? SearchResults(_searchQuery) // Show search results
                  : TabBarView(
                children: catagories.map((tab) => CustomGridview(tab)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<Wpmodel>> CustomGridview(Tab tab) {
    return FutureBuilder<List<Wpmodel>>(
        future: _searchService.fetchWpDataByQuery(tab.text!.toLowerCase()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data found'));
          } else {
            return MasonryGridView.count(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              itemBuilder: (context, index) {
                final photos = snapshot.data![index];
                return Hero(
                  tag: "${photos.imgurl}",
                  child: InkWell(
                    onTap: () {
                      Get.to(Wpdetail(
                        imageUrl: photos.imgurl,
                        name: photos.name,
                        describtion: photos.describtion,
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: (index % 3 + 2) * 100,
                      decoration: BoxDecoration(
                        color: Color(int.parse(
                            photos.avg_color.replaceAll('#', '0xff'))),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage('${photos.imgurl}'),
                            fit: BoxFit.cover),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${photos.name}',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        });
  }
}


class SearchResults extends StatelessWidget {
  final String query;
  const SearchResults(this.query, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchService _searchService = SearchService();
    return FutureBuilder<List<Wpmodel>>(
        future: _searchService.fetchWpDataByQuery(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data found'));
          } else {
            return MasonryGridView.count(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              itemBuilder: (context, index) {
                final photos = snapshot.data![index];
                return Hero(
                  tag: "${photos.imgurl}",
                  child: InkWell(
                    onTap: () {
                      Get.to(Wpdetail(imageUrl: photos.imgurl,
                        name: photos.name,describtion: photos.describtion,));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: (index % 3 + 2) * 100,
                      decoration: BoxDecoration(
                        color: Color(int.parse(
                            photos.avg_color.replaceAll('#', '0xff'))),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage('${photos.imgurl}'),
                            fit: BoxFit.cover),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${photos.name}',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        });
  }
}