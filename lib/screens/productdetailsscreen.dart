import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product.dart';

import '../provider/products.dart';

class productdetailsscreen extends StatelessWidget {
  // final String title;
  static const routename = "productdetails";

  // const productdetailsscreen(this.title);
  @override
  Widget build(BuildContext context) {
    final productsdata = Provider.of<Products>(context, listen: false);
    final prodcutid = ModalRoute.of(context)!.settings.arguments as String;
    final Product element = productsdata.findbyid(prodcutid);

    final String title = element.title.toString();
    return Scaffold(appBar: AppBar(title: Text((element.title))),body: SingleChildScrollView(child: Column(children: <Widget>[
      Container(width:double.infinity,height: 300,child: Image.network(element.imageurl,fit: BoxFit.cover,) ,),SizedBox(height: 10,),Text('\$ ${element.price}',style: TextStyle(color: Colors.grey,fontSize: 20),),SizedBox(height: 10,)
    ,  Container(padding: EdgeInsets
    .symmetric(horizontal: 10),
      child: Text(element
        .description,textAlign: 
        TextAlign.center,softWrap: true),
    )
    ],)),);
  }
}
