import 'package:ecommerce_api/constant/model.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        'Profile',
        style: myStyle(30, Colors.deepPurple),
      ),
    ));
  }
}
