import 'package:ecommerce_api/constant/model.dart';
import 'package:ecommerce_api/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    Provider.of<OrderProvider>(context, listen: false).getOrderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderList = Provider.of<OrderProvider>(context).orderList;
    return Scaffold(
      backgroundColor: bgClrPri,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Order List",
          style: myStyle(26, btnClr, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: orderList.length,
          itemBuilder: (context, index) {
            var clr = orderList[index].orderStatus!.orderStatusCategory!.id;
            return Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: btnClr, width: 3),
                  color: bgClrSec),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Order Status',
                            style: myStyle(18, btnClr1, FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Icon(
                                clr == 2
                                    ? Icons.check_circle_outlined
                                    : clr == 1
                                        ? Icons.check_box_outline_blank
                                        : Icons.check_box_outlined,
                                size: 20,
                                color: clr == 1
                                    ? Colors.blue
                                    : clr == 2
                                        ? Colors.green
                                        : Colors.deepOrange,
                              ),
                              Text(
                                '${orderList[index].orderStatus!.orderStatusCategory!.name}',
                                style: myStyle(
                                    18,
                                    clr == 1
                                        ? Colors.blue
                                        : clr == 2
                                            ? Colors.green
                                            : Colors.deepOrange,
                                    FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Order ID',
                            style: myStyle(18, btnClr1, FontWeight.bold),
                          ),
                          Text(
                            '${orderList[index].id}',
                            style:
                                myStyle(18, Colors.deepPurple, FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'User Name',
                            style: myStyle(18, btnClr1, FontWeight.bold),
                          ),
                          Text(
                            '${orderList[index].user!.name}',
                            style:
                                myStyle(18, Colors.deepPurple, FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'User ID',
                            style: myStyle(18, btnClr1, FontWeight.bold),
                          ),
                          Text(
                            '${orderList[index].user!.id}',
                            style:
                                myStyle(18, Colors.deepPurple, FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Quantity',
                            style: myStyle(18, btnClr1, FontWeight.bold),
                          ),
                          Text(
                            '${orderList[index].quantity}',
                            style:
                                myStyle(18, Colors.deepPurple, FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Price',
                            style: myStyle(18, btnClr1, FontWeight.bold),
                          ),
                          Text(
                            '৳ ${orderList[index].price}',
                            style:
                                myStyle(20, Colors.deepPurple, FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Order Date',
                    style: myStyle(18, btnClr1, FontWeight.bold),
                  ),
                  Text(
                    "${Jiffy(orderList[index].orderDateAndTime).format("MMM do yy")} , ${Jiffy(orderList[index].orderDateAndTime).format("h:mm a")}",
                    style: myStyle(18, Colors.deepPurple, FontWeight.bold),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
