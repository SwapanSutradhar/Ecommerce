import 'package:ecommerce_api/constant/model.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.Controller,
    this.keyBoardType,
    this.labelText,
    this.icon,
    this.prefixIcon,
    this.hintText,
  }) : super(key: key);

  final TextEditingController Controller;

  final TextInputType? keyBoardType;
  final String? labelText;
  final IconData? icon;
  final IconData? prefixIcon;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: Controller,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: btnClr),
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: hintText,
        hintStyle: myStyle(20, bgClrPri.withOpacity(0.5), FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: btnClr),
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: labelText,
        labelStyle: myStyle(20, bgClrPri, FontWeight.bold),
        prefixIcon: Icon(
          icon,
          color: bgClrPri.withOpacity(0.5),
        ),
        prefix: Icon(
          prefixIcon,
          color: Color(0xff7B81EC),
        ),
      ),
    );
  }
}
