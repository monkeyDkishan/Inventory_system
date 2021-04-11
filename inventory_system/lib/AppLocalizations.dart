import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations{
  final Locale locale;

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context){
    return Localizations.of<AppLocalizations>(context,AppLocalizations);
  }

  Map<String,String> _localisedString;

  Future load() async{
    String jsonString = await rootBundle.loadString('lang/${locale.languageCode}.json');

    Map<String,dynamic> josnMap = json.decode(jsonString);

    _localisedString = josnMap.map((key,value){
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key){
    return _localisedString[key];
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations>{
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // TODO: implement load
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();

    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;

}