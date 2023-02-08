import 'package:ecommerce_api/custom_http/custom_http.dart';
import 'package:ecommerce_api/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> orderList = [];

  getOrderData() async {
    orderList = await CustomeHttpRequest.fetchAllOrders();
    notifyListeners();
  }
}
