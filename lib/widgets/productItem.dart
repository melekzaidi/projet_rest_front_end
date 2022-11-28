import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/provider/product.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/screens/productdetailsscreen.dart';

import '../provider/cart.dart';

class productitem extends StatelessWidget {
/*  final String id;
  final String title;
  final String imageUrl;

  productitem(
    this.id,
    this.title,
    this.imageUrl,
  );*/
  @override
  Widget build(BuildContext context) {
    var product = Provider.of<Product>(context,listen: false);
        var cart = Provider.of<Cart>(context,listen: false);
var p=Provider.of<Products>(context,listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(productdetailsscreen.routename, arguments: product.id);
      },
      child: GridTile(
        child: Image.network(product.imageurl, fit: BoxFit.cover),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: ( context, product,  child) =>IconButton(
              icon: Icon(
            product.isfavorite?    Icons.favorite:Icons.favorite_border,
                color: Colors.deepOrange,
              ),
              onPressed: () {   p.tooglefav(product.id);product.tooglefav();},
            

            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.deepOrange,
            ),
            onPressed: () {
              cart.additem(product.id, product.title, 1, product.price);
              final snackbar=SnackBar(duration: Duration(seconds: 2 ),content:Text('item added to cart',style: TextStyle(fontSize: 15),),action: SnackBarAction(label: 
            "undo", onPressed: () {cart.removesingleitem(product.id); },),) ;
           ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger 
            .of(context).showSnackBar(snackbar);
            
            },
          ),
        ),
      ),
    );
  }
}
