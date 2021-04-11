
import 'package:flutter/cupertino.dart';

class ImageUtil{
  static Image app_logo = Image.asset("Assets/Images/app_logo.png");

  static fadeInImage(String url, String assets){

    return FadeInImage(image: NetworkImage(url), placeholder: AssetImage(assets),fit: BoxFit.cover,imageErrorBuilder: (context, error, stackTrace) {
      return Image.asset(assets,fit: BoxFit.cover);
    },);
  }

}