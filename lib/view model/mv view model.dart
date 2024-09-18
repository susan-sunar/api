import 'package:api/model/wpmodel.dart';
import 'package:api/services/wpservices.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController{
  bool isLoading = false;
  Map<String,List<Wpmodel>>wallpapers ={};

  mvGetwallpaperData(String category)async{
    isLoading =true;
    update();
    wallpapers[category]= await Wpservices().fetchWpData(category);
    isLoading = false;
    update();
  }
  List<Wpmodel>vmwallpapers(String category){
    return wallpapers[category]?? [];
  }
}