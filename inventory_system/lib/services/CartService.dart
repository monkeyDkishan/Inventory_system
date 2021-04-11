import 'dart:async';

import 'package:flutter/cupertino.dart';
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
  static final cartKey = 'afsa';

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var obj = prefs.getString(cartKey);

    print(obj);
    var res = welcomeFromJson(obj);

    return res;
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
  });

  int productid;
  String productName;
  int categoryid;
  int subcategoryid;
  String description;
  String imageUrl;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    productid: json["productid"],
    productName: json["ProductName"],
    categoryid: json["Categoryid"],
    subcategoryid: json["Subcategoryid"],
    description: json["description"],
    imageUrl: json["ImageURL"],
  );

  Map<String, dynamic> toJson() => {
    "productid": productid,
    "ProductName": productName,
    "Categoryid": categoryid,
    "Subcategoryid": subcategoryid,
    "description": description,
    "ImageURL": imageUrl,
  };
}

