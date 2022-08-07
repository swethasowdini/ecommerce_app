import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:groceries_app/data/model/food.dart';
import 'package:http/http.dart' as http;

abstract class FoodRepository {
  Future<List<Datum>> getFoods(int page);
}

class FoodRepositoryImpl extends FoodRepository {
  List countdata = [];
  static const FETCH_LIMIT = 15;
  @override
  Future<List<Datum>> getFoods(int page) async {
    var response = await http.get(Uri.parse(
        'http://205.134.254.135/~mobile/MtProject/public/api/product_list.php' +
            "?_limit=$FETCH_LIMIT&_page=$page"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List<Datum> shopitems = Food.fromJson(data).data;
      return shopitems;
    } else {
      throw Exception('Failed');
    }
  }
}
