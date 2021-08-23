import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/HomeScreen.dart';
import 'package:inventory_system/Screens/LoginScreen.dart';
import 'package:inventory_system/services/firebase_config.dart';
import 'package:inventory_system/services/userPreferencesService.dart';

class LendingScreen extends StatefulWidget {
  @override
  _LendingScreenState createState() => _LendingScreenState();
}

class _LendingScreenState extends State<LendingScreen> {

  bool isUserLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocalUser();

  }

  getLocalUser() async {
    var pref = await UserPreferencesService().getUser();

    setState(() {
      isUserLogin = pref.isUserLogin ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(isUserLogin == null){
      return Container(color: Colors.white);
    }else{
      if(isUserLogin){
        return MessageHandler(child: HomeScreen(),); //HomeScreen();
      }else{
        return LoginScreen();
      }
    }

  }
}
