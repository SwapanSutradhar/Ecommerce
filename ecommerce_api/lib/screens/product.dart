import 'package:ecommerce_api/constant/model.dart';
import 'package:ecommerce_api/providers/product_provider.dart';
import 'package:ecommerce_api/screens/add_product.dart';
import 'package:ecommerce_api/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProductProvider>(context, listen: false).getProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductProvider>(context).productList;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddProduct()))
              .then((value) =>
                  Provider.of<ProductProvider>(context, listen: false)
                      .getProductData());
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: bgClrPri,
        elevation: 0,
        title: Text(
          "Product List",
          style: TextStyle(color: btnClr, fontSize: 26),
        ),
        centerTitle: true,
      ),
      body: productList.isEmpty
          ? spinkit
          : GridView.builder(
              padding:
                  EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
              shrinkWrap: true,
              itemCount: productList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0),
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${imageUrl}${productList[index].image.toString()}"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        productList[index].name.toString(),
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Quantity: " +
                            productList[index]
                                .stockItems![0]
                                .quantity
                                .toString(),
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Price: " +
                            productList[index]
                                .price![0]
                                .originalPrice
                                .toString(),
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Discount Price: " +
                            productList[index]
                                .price![0]
                                .discountedPrice
                                .toString(),
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
