import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:inventory_system/AppLocalizations.dart';
import 'package:inventory_system/Screens/Lending.dart';
import 'package:inventory_system/Screens/LoginScreen.dart';
import 'package:inventory_system/Screens/ScreenLists.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_system/services/firebase_config.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';

import 'dart:async';
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseConfig.FCMToken = await messaging.getToken(
    vapidKey: "BC915JYdQGndGWwyZT0_1Lhl8omA9Zz3dr650NPfQ5mK0h4y9VV9mvgaYyAX9nLVt_05YjzxcpsDilZj2QJktFw",
  );

  // FirebaseConfig.FCMToken = "cool";

  print("FCM Token is: " + FirebaseConfig.FCMToken);

  print('User granted permission: ${settings.authorizationStatus}');

  runZonedGuarded(() {
    runApp(MyApp());
  }, FirebaseCrashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: false,
        debugShowMaterialGrid: false,
        title: 'Flutter Demo',
        supportedLocales: [
          Locale('en','US'),
        ],
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          // TODO: uncomment the line below after codegen
          AppLocalizations.delegate,

          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        localeResolutionCallback: (local, supportedLocales){
          for(var SL in supportedLocales){
            if(SL.languageCode == local.languageCode && SL.countryCode == local.countryCode){
              return SL;
            }
          }
          return supportedLocales.first;
        },

        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
          primaryColor: ColorUtil.primoryColor,
          textTheme: TextTheme(bodyText2: TextStyle(
            fontFamily: "Poppins",
          ),),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LendingScreen(),
      ),
    );
  }
}
