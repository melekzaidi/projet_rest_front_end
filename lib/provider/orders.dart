import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/widgets/cartitem.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cart.dart';
class OrderItem{
  final String id;
    final double amount;
  final List<cartitem> products;

  OrderItem({ required this.id, required this.amount,required this.products});

}
class Orders with ChangeNotifier{
late   List <OrderItem> _orders=[];
List <OrderItem> get orders{
  return [..._orders];
}
Future <void> fetchords() async{
  
  try{var response= await http.get(Uri.parse('http://192.168.25.1:5050/orders'));
print("response code : "+(response.statusCode).toString());
print((jsonDecode(response.body).length).runtimeType);
for(int i=0;i<jsonDecode(response.body).length;i++){
    print(i);

  List <cartitem> prods=[];
for(int j=0;j<(jsonDecode(response.body)[i]['prods']).length;j++){
print(jsonDecode(response.body)[0]['prods'][j]['id'].runtimeType);
print(((jsonDecode(response.body)[0]['prods'][j]['price']).toDouble() ).runtimeType);
prods.add(cartitem( id: (jsonDecode(response.body)[i]['prods'][j]['id']), price:(jsonDecode(response.body)[i]['prods'][j]['price'].toDouble()), quantity: (( jsonDecode(response.body))[i]['prods'][j]['qt']), title: (jsonDecode(response.body))[i]['prods'][j]['nom'].toString(),));
}
_orders.add(OrderItem(id: jsonDecode(response.body)[i]['id'], amount: jsonDecode(response.body)[i]['total'].toDouble(), products:prods));
}
 /*extractdata
.forEach((ordid, ord) { 
print(ordid);
List <cartitem> prods=[];

for (int i=0;i<ord['prods'].length;i++){
prods.add(cartitem(id:ordid+'${i}' , title: ord['prods'][i]['nom'], quantity: ord['prods'][i]['qt'], price:( ord['prods'][i]['price'])));
}

ords.add(OrderItem(id: ordid,amount: ord['total'], dateTime:DateTime.parse(ord['id'])  , products:prods,));
});*/

}catch(eror){
  print("ee");  

throw eror;
}}
Future<void> addOrder(List<cartitem> cartproducts,double total) async {
  /*_orders.insert(0, OrderItem(id: DateTime.now()
  .toString(), amount: total, products: cartproducts, dateTime: DateTime.now()
  ));*/
  var encodeFull = Uri.parse('http://192.168.25.1:5050/postorders');
var cartitems=[];
cartproducts.forEach((element) { cartitems.add([element.id,element.price,element.quantity,element.title]);});
print(cartitems);
  try{final reponse= await  http.post(encodeFull,headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },body: json.encode({
    'id':DateTime.now().toString()
,'amount':total,
'products':cartitems, 
'total':total
  }));  notifyListeners() ;
}catch(eror){print("eror");}
}
}
