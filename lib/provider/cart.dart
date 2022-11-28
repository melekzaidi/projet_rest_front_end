import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/cartitem.dart';
class cartitem{
  final String id;
  final String title;
  final int quantity;
  final double price;

cartitem({
  required this.id,
  required this.title,
  required this.quantity,
  required this.price,
});
}
class Cart with ChangeNotifier{
  late Map<String , cartitem> _items={};
Map<String , cartitem> get items{
  return {..._items};
}
void additem(String pid,String ptitle,int pqt,double pprice){
  if(_items.containsKey(pid)){
    _items.update(pid, (exist) => cartitem(id: exist.id, title: exist.title, quantity: exist.quantity+1, price: exist.price));

  }
  else{
    _items.putIfAbsent(pid, () => cartitem(id: DateTime.now().toString(), title: ptitle, price: pprice, quantity: 1));
  }
  notifyListeners();
}
double get totalamount{
  var total=0.0;
  _items.forEach((key, cartitem) {total=total+cartitem.price*cartitem.quantity; });
  return total;
}
int get nbitems{
  return _items==null? 0:_items.length;
}
void deleteitem(producitid){
_items.removeWhere((id, e) => e.id==producitid);
notifyListeners();}
void clear(){
  _items={};
  notifyListeners();


}
void deletempty(String p){
  var i;
  for(i=0;i<_items.length;i++){
    if(_items[i]?.quantity==0){
print("true");
      _items.removeWhere((p, value) => value.id==p);
    }

  }
}
void removesingleitem(String pid){
  final x=_items[pid]?.quantity;
  if(!(_items.containsKey(pid))){
    print("a");
    return ;
  };
  if(x!>1){
    print('b');
    _items.update(pid, (existingcartitem) => 
    cartitem(id: existingcartitem.id, price: existingcartitem.price, quantity: existingcartitem.quantity-1, title: existingcartitem.title));

  }
  else{
    _items.remove(pid);   
  }
 notifyListeners();
}
}
