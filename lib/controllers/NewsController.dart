import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'CategoryController.dart';
import '../models/news.dart';

class NewsController extends GetxController {
  var news = <News>[].obs;

  fetchNews() async {
    var url = Uri.parse("http://www.sanchardainik.com/api/test/news");

    try {
      final response = await http.get(url);

      final extractData = json.decode(response.body) as List;

      List<News> _news = [];

      for (var element in extractData) {
        _news.insert(
          0,
          News(
            id: element['id'],
            news_heading: element['news_heading'],
            news_content: element['news_content'],
            photopath: element['photopath'],
            news_date: element['uploadtime'],
            category_id: element['category_id'],
            writer: element['writer'],
          ),
        );
      }

      news.value = _news;
    } catch (error) {
      rethrow;
    }
  }

  getCategoryName(int id) {
    final categoryController = Get.put(CategoryController());
    final category = categoryController.category;
    var cname = category.firstWhere((element) => element.id == id);
    return cname.name;
  }

  getCategoryID(String name) {
    final categoryController = Get.put(CategoryController());
    final category = categoryController.category;
    var cid = category.firstWhere((element) => element.name == name);
    return cid.id;
  }

  News findNews(int id) {
    return news.firstWhere((element) => element.id == id);
  }
}
