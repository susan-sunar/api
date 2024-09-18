import 'dart:convert';

import 'package:api/model/wpmodel.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';



class Wpservices {
  final _baseUrl = "https://api.pexels.com/v1/";
  final _key = "YKoexhUHSo2cPDmLjjakMtbdJwnugJOtaN76tj0LMXAsEDkh6BYxfyem";


  Future<List<Wpmodel>> fetchWpData(String category) async {
    try {
      final url = "${_baseUrl}search?query=${category}&per_page=33";
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": _key,
      }
      );
      final allData = jsonDecode(response.body);
      final List data = allData["photos"];
      return data.map((photo) => Wpmodel.fromMap(photo)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> openUrl(String imgurl) async {
    final Uri _url = Uri.parse(imgurl);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
  class SearchService {
    Future<List<Wpmodel>> fetchWpDataByQuery(String query) async {
      return await Wpservices().fetchWpData(query);
  }
}