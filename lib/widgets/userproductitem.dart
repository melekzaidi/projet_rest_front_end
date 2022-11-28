// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';
import '../screens/editproductscreen.dart';
class UserProductItem extends StatelessWidget {
final String id;

final String title;
final String imageurl;

  const UserProductItem(  this.id, this.title, 
   this.imageurl);
  @override

  Widget build(BuildContext context) {
   final snackbar=SnackBar(duration: Duration(seconds: 2 ),content:Text('item not removed',style: TextStyle(fontSize: 15),));
   return ListTile(title: Text(title),leading: CircleAvatar(backgroundImage: NetworkImage(imageurl)),trailing: Container(width: 100,child: Row(children: <Widget>[IconButton(icon: const Icon(Icons.edit,color: Colors.purple,), onPressed: () { Navigator.pushNamed(context, Editproductscreen.routename,arguments: id); },),IconButton(icon: const Icon(Icons.delete,color:Colors.red), onPressed: ()  async{ try{await Provider.of<Products>(context,listen: false).deletep(id); }catch(eror){
   ScaffoldMessenger.of(context).showSnackBar(snackbar);
  print('failed');

   }},)],)),);
  } 
}