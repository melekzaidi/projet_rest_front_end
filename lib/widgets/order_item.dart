import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../provider/orders.dart';
class Orderitem extends StatefulWidget {
final OrderItem order;

  const Orderitem({super.key, required this.order});

  @override
  State<Orderitem> createState() => _OrderitemState();
}

class _OrderitemState extends State<Orderitem> {
  var expanded=false;
  @override
  Widget build(BuildContext context) {
    return Card(margin: EdgeInsets.all(10),child: Column(children: <Widget>[
      ListTile(title: Text('\$${widget.order.amount}'),trailing: IconButton(onPressed: (){setState(() {
        expanded=!expanded;
      });},icon: Icon(expanded? Icons.expand_less:Icons.expand_more)),),
    if(expanded)Container(child: ListView(children:widget.order.products.map((e) => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children:<Widget>[Text(e.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)
    ,),Padding( 
      padding: const EdgeInsets.all(10),
      child: Text('${e.quantity} *${e.price.toStringAsFixed(2)}',style: TextStyle(fontSize: 18,color: Colors.grey),),
    )]),).toList()),height: min(widget.order.products.length*20+100,180),)],),)
;  }
}