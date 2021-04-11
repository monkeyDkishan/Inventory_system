
class CartList{

  static List<Cart> carts;
  
  addCart({Cart cart}){
    carts.add(cart);
  }

  removeAt(int index){
    carts.removeAt(index);
  }

  Cart getCartFor(int index){
    return carts[index];
  }

}

class Cart{
  String img_url;
  String item_name;
  int item_quantity;
  String item_unit;
  String item_note;
}