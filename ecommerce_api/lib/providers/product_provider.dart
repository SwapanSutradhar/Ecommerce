import 'package:ecommerce_api/custom_http/custom_http.dart';
import 'package:ecommerce_api/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> productList = [];

  getProductData() async {
    productList = await CustomeHttpRequest.getProductApi();
    notifyListeners();
  }
}
