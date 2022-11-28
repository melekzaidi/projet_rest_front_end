import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';
class Appdrawer extends StatelessWidget {
  const Appdrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(child: Column(children: <Widget>[
      AppBar(title: Text('Hello Friend'),
      automaticallyImplyLeading: false,)

      ,Divider()
      ,ListTile(leading:Icon(Icons.shop),title:Text('shop'),onTap: (){Navigator.pushReplacementNamed(context, '/');
       
      },),
     Divider() ,ListTile(leading:Icon(Icons.payment),title:Text('orders'),onTap: (){Navigator.pushReplacementNamed(context, Ordersscreen.routename);
       
      },),Divider() ,ListTile(leading:Icon(Icons.edit),title:Text('Manage Products'),onTap: (){Navigator.pushReplacementNamed(context, UserProductsScreen.routename);
       
      },)]),);
  }
}