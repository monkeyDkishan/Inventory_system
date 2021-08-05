import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent/android_intent.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'dart:async';
import 'dart:io';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<Map<String, String>> installedApps;
  List<Map<String, String>> iOSApps = [
    {"app_name": "Calendar", "package_name": "calshow://"},
    {"app_name": "Facebook", "package_name": "fb://"},
    {"app_name": "Whatsapp", "package_name": "whatsapp://"}
  ];

  final androidApps = [

    {
      'app_name':'Paytm',
      'package_name':'net.one97.paytm',
      'icon':'https://play-lh.googleusercontent.com/k7yz57K2OxhNrPNKF2U18Zcv9rodOu7CfWh47U15FFUN8-_B0hQfXsM-BaLG0gOtvw=s360'
    },
    {
      'app_name':'PhonePay',
      'package_name':'com.phonepe.app',
      'icon':'https://play-lh.googleusercontent.com/6iyA2zVz5PyyMjK5SIxdUhrb7oh9cYVXJ93q6DZkmx07Er1o90PXYeo6mzL4VC2Gj9s=s360'
    },
    {
      'app_name':'google Pay',
      'package_name':'com.google.android.apps.walletnfcrel',
      'icon':'https://play-lh.googleusercontent.com/HNlca01K9XLSJ8EYzY655EOsV8Nw90vFwmhjQzpLbLacQIRP2kDHfcugxL0a3H58BAX0=s360'
    },
    {
      'app_name':'BHIM',
      'package_name':'in.org.npci.upiapp',
      'icon':'https://play-lh.googleusercontent.com/B5cNBA15IxjCT-8UTXEWgiPcGkJ1C07iHKwm2Hbs8xR3PnJvZ0swTag3abdC_Fj5OfnP=s360'
    },
    {
      'app_name':'IMPS',
      'package_name':'com.transfer.cashout',
      'icon':'https://play-lh.googleusercontent.com/m9pxW1vTk5kz1JXE8OLODmDOtQ9EshehvbT5nuCm11q8bWfNoq-_CYczPG-aaGFvIcs=s360'
    }
  ];

  Future<void> getApps() async {
    List<Map<String, String>> _installedApps;

    try{
      if (Platform.isAndroid) {
        _installedApps = await AppAvailability.getInstalledApps();

        print(_installedApps);

        print(await AppAvailability.checkAvailability("com.android.chrome"));
        // Returns: Map<String, String>{app_name: Chrome, package_name: com.android.chrome, versionCode: null, version_name: 55.0.2883.91}

        print(await AppAvailability.isAppEnabled("com.android.chrome"));
        // Returns: true

      } else if (Platform.isIOS) {
        // iOS doesn't allow to get installed apps.
        _installedApps = iOSApps;

        print(await AppAvailability.checkAvailability("calshow://"));
        // Returns: Map<String, String>{app_name: , package_name: calshow://, versionCode: , version_name: }

      }

      setState(() {
        installedApps = _installedApps;
      });
    }catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getApps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pay'),
        ),
        body: buildListView());
  }

  ListView buildListView() {

    return ListView.builder(
      itemCount: androidApps.length,
      itemBuilder: (context, index) {
      return Container(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: Container(
            height: 44,
            width: 44,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.network(androidApps[index]['icon']),
            ),
          ),
          title: Text(androidApps[index]['app_name']),
          onTap: (){
            AppAvailability.launchApp(
                androidApps[index]['package_name'])
                .then((_) {
              print(
                  "App ${androidApps[index]['app_name']} launched!");
            }).catchError((err) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "App ${androidApps[index]['app_name']} not found!")));
              print(err);
            });
          },
        ),
      );
    },);

  }
}
