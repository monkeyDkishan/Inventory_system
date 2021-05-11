import 'package:flutter/material.dart';
import 'package:inventory_system/AppLocalizations.dart';
import 'package:inventory_system/Screens/Lending.dart';
import 'package:inventory_system/Screens/LoginScreen.dart';
import 'package:inventory_system/Screens/ScreenLists.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inventory_system/Utilities/ColorUtil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
