import 'package:flutter/material.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/widgets/productItem.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';

class Productsgrid extends StatelessWidget {
  bool showfavs;

  Productsgrid(this.showfavs);
  @override
  Widget build(BuildContext context) {
    var productsdata = Provider.of<Products>(context);
    
    var products =showfavs? productsdata.favitems:productsdata.items;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
       value: products[i],
          child:  productitem(
                /*  products[i].id, products[i].title, products[i].imageurl*/),
          ),
        
        itemCount: products.length),
    );
    
  }
  
}
