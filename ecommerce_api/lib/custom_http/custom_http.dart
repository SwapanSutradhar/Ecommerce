import 'dart:convert';
import 'package:ecommerce_api/models/category_model.dart';
import 'package:ecommerce_api/models/order_model.dart';
import 'package:ecommerce_api/models/product_model.dart';
import 'package:ecommerce_api/widgets/common_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CustomeHttpRequest {
  static Future<Map<String, String>> getHeaderWithToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var header = {
      "Accept": "application/json",
      "Authorization": "bearer ${sharedPreferences.getString("token")}"
    };
    print("Saved Token is ${sharedPreferences.getString("token")}");
    return header;
  }

  static Future<List<OrderModel>> fetchAllOrders() async {
    List<OrderModel> orderList = [];
    OrderModel orderModel;
    String uriLink = "${baseUrl}all/orders";
    var response = await http.get(Uri.parse(uriLink),
        headers: await CustomeHttpRequest.getHeaderWithToken());
    print("data areeeeeeeeeeeee${response.body}");
    var data = jsonDecode(response.body);
    for (var i in data) {
      orderModel = OrderModel.fromJson(i);
      orderList.add(orderModel);
    }
    return orderList;
  }

  static Future<List<CategoryModel>> fetchAllCategory() async {
    List<CategoryModel> categoryList = [];
    CategoryModel categoryModel;
    String uriLink = "${baseUrl}category";
    var response = await http.get(Uri.parse(uriLink),
        headers: await CustomeHttpRequest.getHeaderWithToken());
    print("data areeeeeeeeeeeee${response.body}");
    var data = jsonDecode(response.body);
    for (var i in data) {
      categoryModel = CategoryModel.fromJson(i);
      categoryList.add(categoryModel);
    }
    return categoryList;
  }

  static Future<List<ProductModel>> getProductApi() async {
    List<ProductModel> productList = [];
    String link = "${baseUrl}products";
    final response =
        await http.get(Uri.parse(link), headers: await getHeaderWithToken());

    var data = jsonDecode(response.body.toString());

    print("bghfghfghfggggggggg${response.body}");

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        productList.add(ProductModel.fromJson(i));
      }
      return productList;
    } else {
      return productList;
    }
  }
}
