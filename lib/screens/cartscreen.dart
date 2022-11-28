
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/orders.dart';

import '../provider/cart.dart' show Cart, cartitem;
import '../widgets/cartitem.dart';

class Cartscreen extends StatelessWidget {
    static const routename = "cartscreen";


  @override

  Widget build(BuildContext context) {
                  var cart = Provider.of<Cart>(context);
                 
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),body: Column(children: <Widget>[Card(margin: EdgeInsets.all(15),child: Padding(padding: EdgeInsets.all(8),child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[Text('total ',style: TextStyle(fontSize: 20),),SizedBox(width: 10,),Chip(label: Text(' \$ ${cart.totalamount.toStringAsFixed(2)} '),),
      TextButton(style:ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius
      .circular(18.0),side:BorderSide(color: Colors.red)),),foregroundColor: MaterialStateProperty.all<Color>(Colors.orange)),onPressed: (){
             Provider.of<Orders>(context,listen: false).addOrder(cart.items.values.toList(), cart.totalamount);

        cart.clear();
      }, child: Text('order now',))]),),),Expanded(
        child:ListView.builder(itemBuilder: (ctx,i)=>Cartitem(id:cart.items.values.toList()[i].id,title: cart.items.values.toList()[i].title, quantity:  cart.items.values.toList()[i].quantity, price:  cart.items.values.toList()[i].price),itemCount: cart.nbitems,) ,
      )],)
    );
  }
}