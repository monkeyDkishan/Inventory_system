import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/CategoryScreen.dart';
import 'package:inventory_system/Screens/InvoiceListScreen.dart';
import 'package:inventory_system/Screens/SideMenuDrawer.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/component/CartButton.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //Turn this on to stop the android and ios back gesture
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        // drawer: getDrawer(),
        body: Container(
        ),
      ),
    );
  }
}
