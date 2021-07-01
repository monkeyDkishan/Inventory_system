import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/CMSPagesScreen.dart';
import 'package:inventory_system/Screens/HomeScreen.dart';
import 'package:inventory_system/Screens/LoginScreen.dart';
import 'package:inventory_system/Screens/NotificationsList.dart';
import 'package:inventory_system/Screens/ProfileScreen.dart';
import 'package:inventory_system/Screens/StatementListScreen.dart';
import 'package:inventory_system/Screens/dateScreen.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:inventory_system/Utilities/ImageUtil.dart';
import 'package:inventory_system/data/models/ServiceModel.dart';
import 'package:inventory_system/data/models/UserModel.dart';
import 'package:inventory_system/services/userPreferencesService.dart';

var screens = [
  "Statement",
  "Notification",
  "Privacy Policy",
  "Terms & Condition",
  "About Us",
  "Logout"
];

var screens_clasees = [
  DateScreen(),
  // StatementListScreen(),
  NotificationList(),
  CMSPagesScreen(CMSType.Privacy),
  CMSPagesScreen(CMSType.Terms),
  CMSPagesScreen(CMSType.AboutUs)
];

getDrawer(context) {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text('Are You sure'),
                content: SingleChildScrollView(
                  child: Text('You want to logout?'),
                ),
                actions: [
                  TextButton(
                    child: Text('YES'),
                    onPressed: () {
                      UserPreferencesService().removeUser();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                              (route) => false);
                    },
                  ),
                  TextButton(
                    child: Text('NO'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            : AlertDialog(
                title: Text('Are You sure'),
                content: SingleChildScrollView(
                  child: Text('You want to logout?'),
                ),
                actions: [
                  TextButton(
                    child: Text('NO'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('YES'),
                    onPressed: () {
                      // Navigator.of(context).pop();
                      // Navigator.of(context).pop();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    },
                  ),
                ],
              );
      },
    );
  }

  return Drawer(
    child: sideMenu(_showMyDialog),
  );
}

Widget sideMenu(Future<void> _showMyDialog()) {

  if(UserModel == null){
    return Container();
  }

  if(UserModel.userRes == null){
    return Container();
  }

  return Column(
    children: [
      Expanded(
        child: Container(
          color: ColorUtil.primoryColor,
          child: ListView.builder(
              itemCount: screens.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return ListTile(
                    title: Container(
                      child: Column(
                        children: [

                          SizedBox(height: 20),
                          Text(
                            UserModel.userRes.partyname ?? "",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            UserModel.userRes.phone ?? "",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfileScreen()));
                    },
                  );
                }

                return Container(
                  // color: Colors.black,
                  child: Container(
                    // color: Colors.white,
                    // margin: EdgeInsets.only(top: 1,bottom: screens.length == index ? 1 : 0),
                    // decoration: BoxDecoration(
                    //     border: Border(
                    //       top: BorderSide(width: 0.5,color: Colors.white),
                    //       bottom: BorderSide(width: 0.5,color: index == screens.length ? Colors.white : Colors.transparent),
                    //     )
                    // ),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            screens[index - 1],
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Icon(Icons.arrow_forward_ios,size: 15,color: Colors.white,)
                        ],
                      ),
                      onTap: () {
                        if ((index - 1) == screens_clasees.length) {
                          Navigator.pop(context);
                          _showMyDialog();
                          return;
                        }

                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    screens_clasees[index - 1]));
                      },
                    ),
                  ),
                );
              }),
        ),
      ),
    ],
  );
}
