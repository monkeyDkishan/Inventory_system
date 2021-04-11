
import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/data/models/res/BaseRes.dart';
import 'package:inventory_system/data/models/res/ResCMS.dart';
import 'package:inventory_system/data/models/res/ResGetProfileDetails.dart';
import 'package:inventory_system/data/models/res/ResIsValidOTP.dart';
import 'package:inventory_system/data/repositories/AuthRepository.dart';
import 'package:inventory_system/data/repositories/ServiceRepository.dart';
import 'package:inventory_system/data/repositories/UserRepository.dart';
import 'package:inventory_system/services/userPreferencesService.dart';
import 'package:inventory_system/services/webService.dart';

class ServiceModel {
  static ServiceRepository _userRepo = ServiceRepository();

  static var cmsRes = ApiResponse<ResCMS>();
  
  static Future getProfileDetails({CMSType type, Function(ApiResponse<ResCMS>) completion}) async {

    try {
      cmsRes.state = Status.LOADING;

      completion(cmsRes);

      ResCMS res = await _userRepo.getCMSPage(type.getUrlPath);

      if (res.status == 0) {
        throw res.message;
      }
      // else if(res.status == 2){
      //   //UN AUTHORISEa
      // }

      cmsRes.data = res;
      cmsRes.state = Status.COMPLETED;
      completion(cmsRes);
    } catch (e) {
      print(e);
      cmsRes.msg = e;
      cmsRes.state = Status.ERROR;
      completion(cmsRes);
    }
  }
}

enum CMSType{
  Privacy,
  Terms,
  AboutUs
}

extension CMSPageType on CMSType{

  String get getUrlPath{
    switch(this){
      case CMSType.Privacy:
        return kGetPrivacyPolicy;
        break;
      case CMSType.Terms:
        return kGetTermsConditions;
        break;
      case CMSType.AboutUs:
        return kGetAboutUs;
        break;
    }
  }
}