import 'dart:io';
import 'package:ecommerce_api/constant/model.dart';
import 'package:ecommerce_api/custom_http/custom_http.dart';
import 'package:ecommerce_api/models/category_model.dart';
import 'package:ecommerce_api/providers/category_provider.dart';
import 'package:ecommerce_api/widgets/common_widget.dart';
import 'package:ecommerce_api/widgets/custom_texfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? categoryType;
  TextEditingController nameController = TextEditingController();
  TextEditingController orginalPriceController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();
  TextEditingController discountTypeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).getCategoryData();
    super.initState();
  }

  bool isLoading = true;
  uploadProduct() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
      String uriLink = "${baseUrl}product/store";
      var request = http.MultipartRequest("POST", Uri.parse(uriLink));
      request.headers.addAll(await CustomeHttpRequest.getHeaderWithToken());
      request.fields["name"] = nameController.text.toString();
      request.fields["category_id"] = categoryType.toString();
      request.fields["quantity"] = quantityController.text.toString();
      request.fields["original_price"] = orginalPriceController.text.toString();
      request.fields["discounted_price"] =
          discountPriceController.text.toString();
      request.fields["discount_type"] = "fixed";
      var photo = await http.MultipartFile.fromPath("image", image!.path);
      request.files.add(photo);
      var responce = await request.send();
      var responceData = await responce.stream.toBytes();
      var responceString = String.fromCharCodes(responceData);
      print("responce bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy ${responceString}");
      print(
          "Status code issss${responce.statusCode} ${request.fields} ${request.files.toString()}");
      if (responce.statusCode == 201) {
        // showInToast("Product Uploaded Succesfully");
        Fluttertoast.showToast(msg: "Product Uploaded Succesfully");

        Navigator.of(context).pop();
      } else {
        //showInToast("Something wrong, try again plz...");
        Fluttertoast.showToast(msg: "Something wrong, try again plz...");
      }
    }
  }

  List<CategoryModel> categoryList = [];
  @override
  Widget build(BuildContext context) {
    categoryList = Provider.of<CategoryProvider>(context).categoryList;
    final height = MediaQuery.of(context).size.height;
    final weidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgClr1,
      appBar: AppBar(
        backgroundColor: bgClrPri,
        elevation: 0,
        title: Text(
          "Add New Product",
          style: TextStyle(color: btnClr, fontSize: 26),
        ),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: btnClr, width: 3),
                      borderRadius: BorderRadius.circular(20.0)),
                  height: 60,
                  child: Center(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      dropdownColor: btnClr,
                      borderRadius: BorderRadius.circular(20),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                        color: bgClrPri,
                      ),
                      decoration: InputDecoration.collapsed(hintText: ''),
                      value: categoryType,
                      hint: Text(
                        'Select Category',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: bgClrPri,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          categoryType = newValue;
                          print("my Category is $categoryType");

                          // print();
                        });
                      },
                      validator: (value) =>
                          value == null ? 'field required' : null,
                      items: categoryList.map((item) {
                        return DropdownMenuItem(
                          child: Text(
                            "${item.name}",
                            style: TextStyle(
                                fontSize: 20,
                                color: bgClrPri,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          value: item.id.toString(),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Text(
                  "Choose Image",
                  style: myStyle(20, bgClrPri, FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Stack(
                  children: [
                    Container(
                      height: 150,
                      width: 200,
                      decoration: BoxDecoration(
                          color: contClr1,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: btnClr, width: 3)),
                      child: image == null
                          ? InkWell(
                              onTap: () {
                                getImageformGallery();
                              },
                              child: Center(
                                child: Icon(
                                  Icons.camera,
                                  color: btnClr,
                                  size: 40,
                                ),
                              ),
                            )
                          : Container(
                              height: 150,
                              width: 200,
                              child: Image.file(image!),
                            ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Visibility(
                        visible: isImageVisiable,
                        child: TextButton(
                          onPressed: () {
                            getImageformGallery();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.amber,
                                border: Border.all(
                                    color: Colors.black, width: 1.5)),
                            child: Center(
                              child: Container(
                                height: 20,
                                width: 20,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  Controller: nameController,
                  labelText: "Name",
                  hintText: "Enter Product Name",
                  icon: Icons.category,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  Controller: orginalPriceController,
                  hintText: "Enter product Price",
                  labelText: "Price",
                  icon: Icons.price_check_outlined,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  Controller: discountPriceController,
                  hintText: "Enter Discount Price",
                  labelText: "Discount",
                  icon: Icons.discount_outlined,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  Controller: quantityController,
                  hintText: "Enter Quantity",
                  labelText: "Quantity",
                  icon: Icons.production_quantity_limits_outlined,
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    uploadProduct();
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: btnClr,
                        border: Border.all(color: bgClrPri, width: 3)),
                    child: Center(
                      child: Text(
                        'Add Product',
                        style: TextStyle(
                            fontSize: 20,
                            color: bgClrPri,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                /*customButton("Add Product", () {
                  uploadProduct();
                })*/
              ],
            ),
          )),
    );
  }

  File? image;
  final picker = ImagePicker();
  bool isImageVisiable = false;

  Future getImageformGallery() async {
    print('on the way of gallery');
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
        print('image found');
        print('${image!.path}');
      } else {
        print('no image found');
      }
    });
  }
}
