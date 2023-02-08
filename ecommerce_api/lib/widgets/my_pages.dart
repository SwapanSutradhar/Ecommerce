import 'package:ecommerce_api/constant/model.dart';
import 'package:ecommerce_api/screens/category.dart';
import 'package:ecommerce_api/screens/order.dart';
import 'package:ecommerce_api/screens/product.dart';
import 'package:ecommerce_api/screens/profile.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _currentIndex = 2;
  final pages = [OrderPage(), CategoryPage(), ProductPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: bgClrPri,
        elevation: 0.0,
        iconSize: 30,
        selectedItemColor: btnClr,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined), label: ""),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
