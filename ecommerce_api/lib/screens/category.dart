import 'package:ecommerce_api/constant/model.dart';
import 'package:ecommerce_api/providers/category_provider.dart';
import 'package:ecommerce_api/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<CategoryProvider>(context, listen: false).getCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryList = Provider.of<CategoryProvider>(context).categoryList;
    return Scaffold(
      backgroundColor: bgClrPri,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Category List",
          style: myStyle(26, btnClr, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: categoryList.isEmpty
          ? spinkit
          : Container(
              height: double.infinity,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: categoryList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: btnClr, width: 3),
                          color: bgClrSec),
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(children: [
                              Image.network(
                                "${imageUrl}${categoryList[index].image}",
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: btnClr, width: 3),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${imageUrl}${categoryList[index].icon}"))),
                                ),
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${categoryList[index].name}',
                            style:
                                myStyle(16, Colors.deepPurple, FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.edit),
                                iconSize: 20,
                                color: Colors.green,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete),
                                iconSize: 20,
                                color: Colors.red,
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
    );
  }
}
