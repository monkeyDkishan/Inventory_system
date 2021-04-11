import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferencesService {
  Future<bool> saveUser(MyUser user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("userId", user.id);
    prefs.setString("token", user.token  );
    prefs.setBool("isUserLogin", user.isUserLogin  );

    return prefs.commit();
  }


  Future<MyUser> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int id = prefs.getInt("userId");
    String token = prefs.getString("token") ;
    bool isUserLogin = prefs.getBool("isUserLogin") ;

    return MyUser(id: id,isUserLogin: isUserLogin,token: token);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("userId");
    prefs.remove("token");
    prefs.remove("isUserLogin");

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

  MyUser({this.isUserLogin,this.id, this.token});
}