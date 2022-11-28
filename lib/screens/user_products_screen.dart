import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/editproductscreen.dart';
import 'package:shop_app/widgets/userproductitem.dart';
import '../provider/products.dart';
import '../widgets/drawer.dart';
class UserProductsScreen extends StatelessWidget {
  final keyrefresh=GlobalKey<RefreshIndicatorState>();
  static const routename = "userproductsscreen";
  
Future<void>_refreshProduct(BuildContext context)async {


await Provider.of<Products>(context,listen: false).fetchproducts();
Navigator.pushReplacementNamed(context, UserProductsScreen.routename);
;}

  @override

  Widget build(BuildContext context) {
   final a=Provider.of<Products>(context,listen: false);
    return Scaffold(drawer: Appdrawer(),
      appBar: AppBar(title: Text("Your Products"),actions: [IconButton(onPressed: (){Navigator.pushNamed(context, Editproductscreen.routename,arguments:'');}, icon: Icon(Icons.add))],),
    body:  RefreshIndicator (key:keyrefresh,onRefresh: () =>_refreshProduct(context),
    child: Padding(padding: EdgeInsets.all(8),child: ListView.builder(itemCount:a.items.length,itemBuilder:(_,i)=>  UserProductItem(Provider.of<Products>(context).items[i].id,Provider.of<Products>(context).items[i].title,Provider.of<Products>(context).items[i].imageurl) , ),)),);
  }
}