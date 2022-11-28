import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_app/models/Expcetion_http.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';


class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
      
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageurl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageurl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageurl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageurl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  List<Product> get items {
    return [..._items];
  }

  Product findbyid(String id) {
    return items.firstWhere((element) => element.id == id);
  }
  List<Product> get favitems{
    return _items.where((element) => element.isfavorite ).toList();
  }
/*Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('https://shop-app-b2d8f-default-rtdb.europe-west1.firebasedatabase.app/products.json'));
}*/
Future <void> fetchproducts()async {
  // var url='https://shop-app-b2d8f-default-rtdb.europe-west1.firebasedatabase.app/products.json';
{final// response= await http.get(Uri.parse('https://shop-app-b2d8f-default-rtdb.europe-west1.firebasedatabase.app/products.json')); 
response= await http.get(Uri.parse('http://192.168.25.1:5050/products'));
print("response code : "+(response.statusCode).toString());
print(jsonDecode(response.body));
print('len'+jsonDecode(response.body).length.toString());
/*final extractdata=jsonDecode(response.body) as Map <String , dynamic> ;*/
 List<Product> loadedproduct=[];
 var i=0;
 print(json.decode(response.body)[0]);
 print(jsonDecode(response.body).length.runtimeType);
 for(int i=0;i<(jsonDecode(response.body)).length;i++){

  print("enter") ;
  var x=jsonDecode(response.body)[i];
print(double.parse( x["price"].toString()).runtimeType);
Product e=Product(description: x["description"], id: x["id"].toString(), imageurl: x["imageurl"], price:double.parse (x["price"].toString()), title: x["title"],isfavorite:x["isfavorite"]);
print(e);
loadedproduct.add(e);
print(loadedproduct);
 }/*

extractdata.forEach((prodid, proddata) {
loadedproduct.add(Product(description: proddata['description'], id: prodid, imageurl: proddata
['imageurl'], price: proddata
['price'], title: proddata
['title'],isfavorite: proddata['isfavorite']),);
 });
*/
print("loaded"+loadedproduct.toString());
 
_items=loadedproduct;
 notifyListeners(); 

;
}
print(_items);
notifyListeners(); 
}
 Future <void> additem(Product product) async {
  var encodeFull = Uri.parse("http://192.168.25.1:5050/postproducts");
 try{
 final reponse= await  http.post(encodeFull,headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },body: json.encode({
      'id':DateTime.now().toString(),
'title':product.title,
'description':product.description,
'imageurl':product.imageurl,
'price':product.price,
'isfavorite':product.isfavorite,
 
    }));print("reponse"+reponse.statusCode.toString());
      final newproduct=Product(description: product.description, id: json.decode(reponse.body)['name'], imageurl: product.imageurl, price: product.price, title: product.title);
 print(newproduct.id);
    _items.add(newproduct);
    notifyListeners();}catch (error)  {
      throw error; 
       }
    
    
 
  }
  Future <void> update(String id,Product p)async{
    print(id);
    print(p.id);
    final i=_items
    .lastIndexWhere((element) => element.id==p.id);
if(i>=0){   
  
       var encodeFull = Uri.parse('http://192.168.25.1:5050/updateproduct');
 try{
 final reponse= await  http.put(encodeFull,headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },body: json.encode({
      'id':p.id
      ,'title':p.title,
'description':p.description,
'imageurl':p.imageurl,
'price':p.price,
'isfavorite':p.isfavorite,
 
    }));}catch(e){}}
     _items[i]=p;

    

  notifyListeners();
 }
 Future <void>tooglefav(String id)async{
  print(id.toString());
final index=_items
    .lastIndexWhere((element) => element.id==id);
  var encodeFull = Uri.parse('http://192.168.25.1:5050/updateproduct');

  if(_items[index].isfavorite){
 try{
 final reponse= await  http.put(encodeFull,headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },body: json.encode({
      'id':id
     ,
'isfavorite':false,
 
    }));}catch(e){}}


else{
try{
 final reponse= await  http.put(encodeFull,headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },body: json.encode({
      'id':id
     ,
'isfavorite':true,
 
    }));}catch(e){}}
 }
Future <void> deletep(String id)async {
    var existingprodindex=_items.indexWhere((element) => element.id==id);
  Product? existprod=_items[existingprodindex];
  _items.removeAt(existingprodindex);
  notifyListeners();
 var encodeFull = Uri.parse('http://192.168.25.1:5050/deleteproduct');
 try{
 final reponse= await  http.delete(encodeFull,headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },body: json.encode({
      'id':existprod.id
     
    })); if(reponse.statusCode>=400){
      _items.insert(existingprodindex, existprod);
notifyListeners(); 
      throw Httexception("aa");
    }}catch(e){}
   
    existprod=null;
  
    
  }
   
}

