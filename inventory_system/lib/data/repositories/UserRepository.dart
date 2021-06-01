import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/data/models/req/ReqIsValidMobile.dart';
import 'package:inventory_system/data/models/req/ReqIsValidOTP.dart';
import 'package:inventory_system/data/models/req/ReqUpdateFcmToken.dart';
import 'package:inventory_system/data/models/res/BaseRes.dart';
import 'package:inventory_system/data/models/res/ResGetProfileDetails.dart';
import 'package:inventory_system/data/models/res/ResIsValidOTP.dart';
import 'package:inventory_system/services/firebase_config.dart';
import 'package:inventory_system/services/webService.dart';

class UserRepository{

  WebService _webService = WebService();

  Future<ResGetProfileDetails> getProfileDetailsApi() async{
    var res = await _webService.getApi(kGetProfileDetails);

    try{
      return ResGetProfileDetails.fromJson(res);
    }catch(e){
      throw "Decoding Error";
    }
  }

  Future updateFcmToken() async{
    print('FCM TOKEN UPDATING');
    await _webService.postApi(kUpdateFcmToken, ReqUpdateFcmToken(fcmToken: FirebaseConfig.FCMToken).toJson());

  }

}