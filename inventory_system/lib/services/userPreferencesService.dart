import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferencesService {
  Future<bool> saveUser(MyUser user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("userId", user.id);
    prefs.setString("token", user.token);
    prefs.setBool("isUserLogin", user.isUserLogin);
    prefs.setDouble("tcsAmountPercentage", user.tcsAmountPercentage);
    prefs.setDouble("tcsLimit", user.tcsLimit);
    prefs.setDouble("tcsAmount", user.tcsAmount);
    prefs.setBool("isTCSApply", user.isTCSApply);

    return prefs.commit();
  }


  Future<MyUser> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int id = prefs.getInt("userId");
    String token = prefs.getString("token");
    bool isUserLogin = prefs.getBool("isUserLogin");
    double tcsAmountPercentage = prefs.getDouble("tcsAmountPercentage");
    double tcsLimit = prefs.getDouble("tcsLimit");
    double tcsAmount = prefs.getDouble("tcsAmount");
    bool isTCSApply = prefs.getBool("isTCSApply");

    return MyUser(id: id,isUserLogin: isUserLogin,token: token,isTCSApply: isTCSApply,tcsAmount: tcsAmount,tcsAmountPercentage: tcsAmountPercentage,tcsLimit: tcsLimit);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("userId");
    prefs.remove("token");
    prefs.remove("isUserLogin");
    prefs.remove("tcsAmountPercentage");
    prefs.remove("tcsLimit");
    prefs.remove("tcsAmount");
    prefs.remove("isTCSApply");
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")  ;
    return token;
  }

  static Future<bool> isUserLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isUserLogin = prefs.getBool("isUserLogin")  ;
    return isUserLogin;
  }
  
}

class MyUser{
  final int id;
  final String token;
  final bool isUserLogin;
  final double tcsAmountPercentage;
  final double tcsLimit;
  final double tcsAmount;
  final bool isTCSApply;

  MyUser({this.tcsAmountPercentage, this.tcsLimit, this.tcsAmount, this.isTCSApply, this.isUserLogin,this.id, this.token});
}