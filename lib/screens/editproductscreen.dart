import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product.dart';
import 'package:shop_app/screens/productdetailsscreen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

import '../provider/products.dart';
class Editproductscreen extends StatefulWidget {
      static const routename = "editproductscreen";
      // ignore: prefer_typing_uninitialized_variables
      final id;

  const Editproductscreen({Object?  arg  ,this.id});
  

  @override
  State<Editproductscreen> createState() => _EditproductscreenState();
}

class _EditproductscreenState extends State<Editproductscreen> {  
 
  final _priceFocusNode=FocusNode();
    final _descriptionnode=FocusNode();
    final _imageurlfocusnode=FocusNode();

    final _imageurl=TextEditingController();
    final _form=GlobalKey<FormState >();
    var _editingproduct=Product(id: DateTime.now().toString(), title: '', description: '', price: 0.0, imageurl: '');

var _initvalues={'title':'','description':'','price':'','imageUrl':''};
@override  
  void initState() {
    _imageurlfocusnode.addListener(_updateimageurl);

    // TODO: implement initState
    super.initState();
  }
  var _isinit=true;
  var _isloading=false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(_isinit){
      final productid=ModalRoute.of(context)?.settings.arguments as String;
      if (productid!=''){
   _editingproduct=Provider.of<Products>(context,listen: false).findbyid(productid);
_initvalues={'id':_editingproduct.id,'title':_editingproduct.title,'description':_editingproduct.description,'price':_editingproduct.price.toString(),'imageUrl':_editingproduct.imageurl

};
      }
      else{
        
_initvalues={'title':"",'description':"",'price':"",'imageUrl':""};
      }
    
    }
    _isinit=false;  
    super.didChangeDependencies();
  }
  @override
  void dispose(){
    _descriptionnode.dispose()
;
_priceFocusNode.dispose() ; 
_descriptionnode.dispose();
_imageurl.dispose();
super.dispose();}
void _updateimageurl(){ 
  if(!_imageurlfocusnode.hasFocus){
   if(!_imageurl.text.startsWith('http')||!_imageurl.text.startsWith('https')||!_imageurl.text.endsWith('png')||!_imageurl.text.endsWith('jpg')||!_imageurl.text.endsWith('jepg')){
    return;
   }
    setState(() { 
      
    });
  }
}
Future <void> _saveform(String a) async {
  setState(() {
          _isloading=true;

  });
final isvalid=_form.currentState!.validate();
if(!isvalid){
  return;
}
   _form.currentState!.save( 
   );
   if(a!=''){

 final  _product=Provider.of<Products>(context,listen: false);
 _product.update(_editingproduct.id,_editingproduct);
 _product.fetchproducts();
Navigator.pushReplacementNamed(context, UserProductsScreen.routename);
   setState(() {
     _isloading=false;
   });

   }
   else{
     try {Provider.of<Products>(context,listen: false).additem(_editingproduct );}
 catch(eror){
  return showDialog(context: context, builder: (ctx)=>AlertDialog(title: Text('An error occurred!'),content: Text('Something went wrong'),actions: <Widget>[ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: Text('Ok'))],));
 }
 finally {Navigator.pushReplacementNamed(context, UserProductsScreen.routename);


   setState(() {
         _isloading=false;

   });


}
   }
         _isloading=false;
         print(_isloading);

}
@override
// ignore: must_call_super

  Widget build(BuildContext context) {
   final args=ModalRoute.of(context)?.settings.arguments;
  print(_initvalues['id']);

    return Scaffold(
      appBar: AppBar(title:Text("Edit Product"),actions: <Widget>[IconButton(icon: Icon( Icons.save), onPressed: () { _saveform(args.toString());  },)],),
      body:   Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form ,child: ListView(children: <Widget>[
          TextFormField(initialValue: _initvalues['title'],decoration: InputDecoration(labelText: 'Title'),textInputAction: TextInputAction
        .next,onFieldSubmitted: (_){FocusScope.of(context).requestFocus(_priceFocusNode);},onSaved: (value){
          _editingproduct=Product(isfavorite: _editingproduct.isfavorite,id: _editingproduct.id, title: value!, description: _editingproduct.description, price: _editingproduct.price, imageurl: _editingproduct.imageurl);
        },validator: (value){
          if(value!.isEmpty){
            return 'please enter a title';
          }
        },)
        ,TextFormField(initialValue: _initvalues['price'],decoration: InputDecoration(labelText: 'Price'),textInputAction: TextInputAction
        .next,keyboardType: TextInputType.number,focusNode: _priceFocusNode,onFieldSubmitted: (_){FocusScope.of(context).requestFocus(_descriptionnode);},onSaved: (value){
         
          _editingproduct=Product(isfavorite: _editingproduct.isfavorite,id: _editingproduct.id, title: _editingproduct.title, description: _editingproduct.description, price: double.parse(value.toString()) , imageurl: _editingproduct.imageurl);
        },validator: (value){
          if(double.tryParse(value!)==null){
            return 'please enter a valid number';

          }
          final x=double.parse(value.toString()) ;
          if (x<=0){
            return 'please enter a number greater than 0 ';

          }
          return null;
        }),
        TextFormField(initialValue: _initvalues['description'],decoration: InputDecoration(labelText: 'Description'),focusNode:_descriptionnode ,maxLines: 3,keyboardType: TextInputType.multiline,onFieldSubmitted: (_){FocusScope.of(context).requestFocus(_imageurlfocusnode);},
        textInputAction: TextInputAction.done,onSaved: (value){
          _editingproduct=Product(isfavorite: _editingproduct.isfavorite,id: _editingproduct.id, title: _editingproduct.title, description: value!, price: _editingproduct.price, imageurl: _editingproduct.imageurl);
        },validator: (value){
          if(value!.isEmpty){
             return 'please enter a description';

          }
          if(value.length<10 ){
             return 'length of description should be greater than 10 caracters ';
             
          }
          return null;
          
        },)
   ,    Row( 
    crossAxisAlignment: CrossAxisAlignment.end,
           mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(height: 100,width:100,margin: EdgeInsets.only(top:8,right: 10,),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey,width:1 ))
        ,   child: _imageurl.text.isEmpty ? const Text('enter Url'): FittedBox(child: Image.network(_imageurl.text,width: 100,height: 100,),fit: BoxFit.cover,)),        
           
          Expanded(child: TextFormField(initialValue: _initvalues['imageUrl'],      keyboardType: TextInputType.url,
decoration: InputDecoration(labelText: 'ImageUrl'),focusNode:_imageurlfocusnode ,textInputAction: TextInputAction.done,onSaved: (value){
          _editingproduct=Product(isfavorite: _editingproduct.isfavorite,id: _editingproduct.id, title: _editingproduct.title, description: _editingproduct.description, price: _editingproduct.price, imageurl: value!,);
        },onFieldSubmitted: (_){_saveform(args.toString());},validator: (value){
          if(value!.isEmpty){
return 'please enter a image Url';
          }
             if(!(value.startsWith('http'))&&!(value.startsWith('https'))){
return 'please enter a valid Url';
          }
         return null;

        },),)],
        )
        ]
        )
        ),
      ),
    ); 
  }
}