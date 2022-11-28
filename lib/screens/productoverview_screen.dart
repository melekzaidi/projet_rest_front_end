import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cartscreen.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/productItem.dart';
import 'package:shop_app/screens/productdetailsscreen.dart';

import '../provider/cart.dart';
import '../provider/product.dart';
import '../provider/products.dart';
import '../widgets/drawer.dart';
import '../widgets/productgrid.dart';
enum filteroptions{
Favs,all
}
class Productoverview_screen extends StatefulWidget {
    static const routename="productoverviewscreen";

  @override
  State<Productoverview_screen> createState() => _Productoverview_screenState();
}

class _Productoverview_screenState extends State<Productoverview_screen> {

   bool   _showfavsonly=false;
   var _isint=true;
    late  bool _isloading=false;
Future<void>_refreshProduct(BuildContext context)async {
await Provider.of<Products>(context,listen: false).fetchproducts().then((value) { _isloading=true;});
Navigator.pushReplacementNamed(context, Productoverview_screen.routename);
;}


  void initState() {

//      if (_isint){
//     Provider.of<Products>(context).fetchproducts();
//   }
// _isint=false;
//  if (_isint){

//    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {    Provider.of<Products>(context,listen: false).fetchproducts();
//  });
//   }
// _isint=false;
//     // TODO: implement initState
// Provider.of<Products>(context).fetchproducts().then((_)  {setState(() {
//        _isloading=false
// ;    });});
    super.initState();
  }
@override
  void didChangeDependencies()  {
  
  if (_isint){

    Provider.of<Products>(context).fetchproducts().then((_)  {setState(() {
       _isloading=false
;    });});
if(Provider.of<Products>(context).items.isEmpty){
  _isloading=false;
}
  }
_isint=false;


}
  
  @override
  Widget build(BuildContext context) {
            var cart = Provider.of<Cart>(context,listen: false);

    return Scaffold(
      
      appBar: AppBar(title: Text("Myshop"),actions: <Widget>[PopupMenuButton(
        onSelected: (filteroptions selectedvalue){

if (selectedvalue==filteroptions.Favs){
  setState(() {
    _showfavsonly=true;

  });
}
else{setState(() {
    _showfavsonly=false;

  });

}
        },icon: Icon(Icons.more_vert),itemBuilder: (_)=>[PopupMenuItem(child: Text("Only favorites"),value:filteroptions.Favs,),PopupMenuItem(child: Text("All products"),value:filteroptions.all,),]),
       Consumer<Cart>(builder: (_,cart,ch )=> Badge( child:
  IconButton(icon: Icon(Icons.shopping_cart), onPressed: () { Navigator.pushNamed(context,Cartscreen.routename ); },), value: cart.nbitems.toString(), color: Colors.orange,))]
        ),drawer: Appdrawer(),
     body: _isloading?Center(child: CircularProgressIndicator()): RefreshIndicator (onRefresh: () =>_refreshProduct(context),
     child: Productsgrid(_showfavsonly)),);
  
  }
}
