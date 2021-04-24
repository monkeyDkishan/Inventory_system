import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:inventory_system/data/models/res/ResGetItemList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartBloc{
  static final countStream = StreamController<int>();

  static Future<CartList> getCartDetails() async{

    var res = await CartService.getCarts();

    countStream.add(res.cart.length);

    return res;
  }

}

class CartService{
  static final cartKey = 'sodapanii';

  CartList cart;

  static Future<bool> addItem(String item) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var obj = prefs.getString(cartKey);
    if(obj == null){
      var cool = """
          {
            "cart":
              [
                  $item
              ]
          }
    """;
      prefs.setString(cartKey, cool);
    }else{
      final res = welcomeFromJson(obj);
      var objStr = "";

      res.cart.forEach((element) {
        objStr += jsonEncode(element) + ",";
      });

      objStr += item;

      var cool = """
          {
            "cart":
              [
                  $objStr
              ]
          }
    """;
      prefs.setString(cartKey, cool);
    }
    return prefs.commit();
  }

  static Future<bool> addItemObj(Cart item) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var obj = prefs.getString(cartKey);
    print('${item.toJson()}');
    if(obj == null){
      var cool = """
          {
            "cart":
              [
                  ${jsonEncode(item)}
              ]
          }
    """;
      print(cool);
      prefs.setString(cartKey, cool);
    }else{
      var res = welcomeFromJson(obj);

      res.cart.add(item);

      final jsonStr = jsonEncode(res);

      prefs.setString(cartKey, jsonStr);
    }
    return prefs.commit();
  }


  static Future<bool> editItem(int index, String item) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var obj = prefs.getString(cartKey);

    if(obj == null){
      return prefs.commit();
    }

    final res = welcomeFromJson(obj);

    res.cart[index] = Cart.fromJson(jsonDecode(item));

    prefs.setString(cartKey, jsonEncode(res.toJson()));

    return prefs.commit();
  }

  static Future<bool> editItemObj(int index, Cart item) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var obj = prefs.getString(cartKey);

    if(obj == null){
      return prefs.commit();
    }

    final res = welcomeFromJson(obj);

    res.cart[index] = item;

    prefs.setString(cartKey, jsonEncode(res.toJson()));

    return prefs.commit();
  }

  static Future<bool> removeItem(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var obj = prefs.getString(cartKey);

    if(obj == null){
      return prefs.commit();
    }

    final res = welcomeFromJson(obj);

    res.cart.removeAt(index);

    print(res.cart.length);

    prefs.setString(cartKey, jsonEncode(res.toJson()));

    return prefs.commit();
  }

  static Future<CartList> getCarts() async {
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      var obj = prefs.getString(cartKey);

      print(obj);
      var res = welcomeFromJson(obj);

      return res;
    }catch(e){
      print(e);
    }

  }

}

CartList welcomeFromJson(String str) => CartList.fromJson(json.decode(str));

String welcomeToJson(CartList data) => json.encode(data.toJson());

class CartList {
  CartList({
    this.cart,
  });

  List<Cart> cart;

  factory CartList.fromJson(Map<String, dynamic> json) => CartList(
    cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
  };
}

class Cart {
  Cart({
    this.productid,
    this.productName,
    this.categoryid,
    this.subcategoryid,
    this.description,
    this.imageUrl,
    this.unitName,
    this.unitId,
    this.unitPrice,
    this.quantity,
    this.note,
    this.unitmaster,
    this.selectedIndex
  });

  int productid;
  String productName;
  int categoryid;
  int subcategoryid;
  String description;
  String imageUrl;
  String unitName;
  int unitId;
  double unitPrice;
  int quantity;
  String note;
  int selectedIndex;
  List<Unitmaster> unitmaster;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    productid: json["productid"],
    productName: json["ProductName"],
    categoryid: json["Categoryid"],
    subcategoryid: json["Subcategoryid"],
    description: json["description"],
    imageUrl: json["ImageURL"],
    unitName: json["unitName"],
    unitId: json["unitId"],
    unitPrice: json["unitPrice"],
    quantity: json["quantity"],
    note: json["note"],
    unitmaster: List<Unitmaster>.from(json["unitmaster"].map((x) => Unitmaster.fromJson(x))),
    selectedIndex: json["selectedIndex"],

  );

  Map<String, dynamic> toJson() => {
    "productid": productid,
    "ProductName": productName,
    "Categoryid": categoryid,
    "Subcategoryid": subcategoryid,
    "description": description,
    "ImageURL": imageUrl,
    "unitName": unitName,
    "unitId": unitId,
    "unitPrice": unitPrice,
    "quantity": quantity,
    "note": note,
    "unitmaster": List<dynamic>.from(unitmaster.map((x) => x.toJson())),
    "selectedIndex": selectedIndex,
  };
}

