import 'package:flutter/material.dart';
import 'package:provider/provider.dart.';
import 'package:shop_app/widgets/order_item.dart';
import '../provider/orders.dart';
import '../widgets/drawer.dart';
class Ordersscreen extends StatelessWidget {
  const Ordersscreen({Key? key}) : super(key: key);
  static const routename = "orderitem";

  @override
  Widget build(BuildContext context) {
    Provider.of<Orders>(context).fetchords();
    final ordersd= Provider.of<Orders>(context);
    print(ordersd);

    return Scaffold(
appBar: AppBar(title: Text('Your Orders')),
drawer: Appdrawer(),body:  ListView.builder(itemCount: ordersd.orders.length ,itemBuilder:(ctx,i)=> Orderitem(order: ordersd.orders[i])),

    );
  }
}