// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/provider/orders.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/screens/cartscreen.dart';
import 'package:shop_app/screens/editproductscreen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/productdetailsscreen.dart';
import 'package:shop_app/screens/productoverview_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';
import './provider/products.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
  ChangeNotifierProvider(
    create: (ctx) => Products(),),ChangeNotifierProvider(
    create: (ctx) => Cart(),)
    ,ChangeNotifierProvider(
    create: (ctx) => Orders (),)]
   ,
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.purple),
        home: Productoverview_screen(),
        debugShowCheckedModeBanner: false,
       
        routes: {
          productdetailsscreen.routename: (ctx) => productdetailsscreen(),
                    Cartscreen.routename: (ctx) => Cartscreen(),
                    Ordersscreen.routename: (ctx) => Ordersscreen(),
UserProductsScreen.routename:(ctx)=>UserProductsScreen(),
Editproductscreen.routename:(ctx)=>Editproductscreen(),
Productoverview_screen.routename:(ctx)=>Productoverview_screen(),
        })
    );
  }
}

