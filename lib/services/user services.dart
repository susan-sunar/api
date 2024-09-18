import 'dart:convert';
import 'package:api/model/people%20model.dart';
import 'package:api/model/user%20model.dart';
import 'package:http/http.dart' as http;

class UserServices {
  String _baseUrl = "https://randomuser.me/api/";

  /// AI made Model Class & used it's fromJson function
  Future<PeopleModel?> fetchPeopleData(int numberOfUser) async {
    try {
      final url = "${_baseUrl}?results=${numberOfUser}";
      final response = await http.get(Uri.parse(url));
      // See in the console and Debug the response
      print("API Response: ${response.body}");
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return PeopleModel.fromJson(data);
      } else {
        print("Failed to load data");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

//   Hand made model without from map function

    Future<List<UserModel>>fetchUserData(int nunberOfUser)async{
    List<UserModel>allUsers =[];
    final  url = "${_baseUrl}?results=${nunberOfUser}";
    final response=  await http.get(Uri.parse(url));
    final allData = jsonDecode(response.body);
    final List data = allData["results"];
    print("All data:${data}");


    for(var i in data){
      UserModel user = UserModel(
          tittle:i["name"]["title"],
          first: i["name"]["first"],
          last: i["name"]["last"],
          gender: i["gender"],
      );
      allUsers.add(user);
    }
    return allUsers;

    }

}
