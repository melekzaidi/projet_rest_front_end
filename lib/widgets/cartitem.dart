import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';
class Cartitem extends StatelessWidget {
String id;
double price;
int quantity;
String title;

Cartitem({
  required this.id,required this.price,required this.quantity, required this.title});

  @override
  Widget build(BuildContext context) {
                    
                  
    return  Dismissible(direction: DismissDirection.endToStart,key: UniqueKey(),background: Container(color: Theme.of(context).errorColor,child: const Icon(Icons.delete,color: Colors.white,size: 40,),alignment: Alignment.centerRight,padding: 
    EdgeInsets
    .all(15),margin: EdgeInsets.symmetric(horizontal: 15,vertical: 8),),
    child: Card(margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),child: Padding(padding: EdgeInsets.all(8),child: ListTile(leading: CircleAvatar(child: FittedBox(child: Text('\$${price.toStringAsFixed(2)}')),),title:Text(title),subtitle: Text('Total : \$${(price*quantity)}'),trailing: Text('$quantity x'),),),),confirmDismiss:(direcion){  return showDialog(context: context, builder: (ctx)=> AlertDialog(title: Text('are you sure'),content:Text("Do you want to remove the item from the cart"),actions: <Widget>[TextButton(onPressed:()=> {Navigator.of(context).pop(false)}, child: Text('NO')),TextButton(onPressed:()=> {Navigator.of(context).pop(true)}, child: Text('YES'))],),);},
    

    onDismissed:(direction){Provider.of<Cart>(context,
                      
                    listen: false  ).deleteitem(id);
     });
    
  }
}