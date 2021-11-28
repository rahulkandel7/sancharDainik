import 'dart:convert';

import 'package:get/get.dart';
import '../models/category.dart';
import 'package:http/http.dart' as http;

class CategoryController extends GetxController {
  var category = <Category>[].obs;

  fetchCategory() async {
    var url = Uri.parse("http://www.sanchardainik.com/api/test/category");

    try {
      final response = await http.get(url);

      final extractData = json.decode(response.body) as List;

      List<Category> _category = [];

      for (var element in extractData) {
        _category.add(
          Category(
            id: element['id'],
            name: element['categoryname'],
          ),
        );
      }
      category.value = _category;
    } catch (error) {
      rethrow;
    }
  }
}
