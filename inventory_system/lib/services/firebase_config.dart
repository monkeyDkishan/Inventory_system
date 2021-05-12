
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:inventory_system/Screens/NotificationsList.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'package:overlay_support/overlay_support.dart';

class FirebaseConfig{
  static String FCMToken = "";

  static bool isFromNotification = false;

  static Map<String,dynamic> data;
}

class MessageHandler extends StatefulWidget {
  final Widget child;
  MessageHandler({this.child});
  @override
  State createState() => MessageHandlerState();
}

class MessageHandlerState extends State<MessageHandler> {
  Widget child;
  @override
  void initState() {
    super.initState();
    child = widget.child;

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      handleNotification(message.data, context);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if(Platform.isAndroid){
        if (message.notification != null) {
          showOverlayNotification((context) {
            return SafeArea(
              child: TextButton(
                onPressed: (){
                  handleNotification(message.data, context);
                  OverlaySupportEntry.of(context).dismiss();
                },
                child: Card(
                  color: ColorUtil.primoryColor,
                  margin: const EdgeInsets.only(left: 10,right: 10,top: 5),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(message.notification.title,style: TextStyle(color: Colors.white, fontSize: 20),textAlign: TextAlign.start,maxLines: 1),
                              Text(message.notification.body,style: TextStyle(color: Colors.white,fontSize: 16),textAlign: TextAlign.start,maxLines: 2)
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: (){
                              OverlaySupportEntry.of(context).dismiss();
                            }, icon: Icon(Icons.close,color: Colors.white,size: 20,)),
                            Text('Open',style: TextStyle(color: Colors.white, fontSize: 14),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }, duration: Duration(milliseconds: 4000));
        }
      }
    });

    handleOutsideNotification();

  }

  Future handleOutsideNotification() async{
    RemoteMessage initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if(initialMessage != null && initialMessage.data != null){
      print('Message data: ${initialMessage.data}');
      handleNotification(initialMessage.data, context);
    }
  }

  static handleNotification(Map<String,dynamic> data, BuildContext context) async {

    print(data);

    try{
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationList(),));

      FirebaseMessaging.instance.setAutoInitEnabled(false);

    }catch(e){
      print("Error: $e");
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationList(),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
