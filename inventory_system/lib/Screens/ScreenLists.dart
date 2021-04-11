import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/HomeScreen.dart';
import 'package:inventory_system/Screens/LoginScreen.dart';
import 'package:inventory_system/Screens/OTPScreen.dart';

class ScreenLists extends StatefulWidget {
  @override
  _ScreenListsState createState() => _ScreenListsState();
}

class _ScreenListsState extends State<ScreenLists> {
  var screenNames = ["LoginScreen","OTPScreen","HomeScreen"];
  var screens = [LoginScreen(),OTPScreen(),HomeScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: screenNames.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => screens[index]),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(screenNames[index]),
                    ),
                  ),
              );
            }
        )
      ),
    );
  }
}
