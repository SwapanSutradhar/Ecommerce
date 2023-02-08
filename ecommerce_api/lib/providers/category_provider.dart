import 'package:ecommerce_api/custom_http/custom_http.dart';
import 'package:ecommerce_api/models/category_model.dart';
import 'package:flutter/foundation.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> categoryList = [];

  getCategoryData() async {
    categoryList = await CustomeHttpRequest.fetchAllCategory();
    notifyListeners();
  }
}
