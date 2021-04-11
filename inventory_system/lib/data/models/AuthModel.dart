import 'dart:async';

import 'package:inventory_system/data/models/res/BaseRes.dart';
import 'package:inventory_system/data/models/res/ResIsValidOTP.dart';
import 'package:inventory_system/data/repositories/AuthRepository.dart';
import 'package:inventory_system/services/userPreferencesService.dart';
import 'package:inventory_system/services/webService.dart';

class AuthModel{

  static AuthRepository _authRepo = AuthRepository();

  static String mobile = "7383864276";

  static Future validateMobile({String mobile,Function(ApiResponse) completion}) async {

    print(mobile);
    var apiRes = ApiResponse<BaseRes>();
    try{
      if(mobile.isEmpty){
        throw 'Please Enter Mobile Number';
      }

      if(mobile.length != 10){
        throw 'Please Enter Valid Mobile Number';
      }

      apiRes.state = Status.LOADING;

      completion(apiRes);

      BaseRes res = await _authRepo.isValidMobileApi(mobile);

      if(res.status == 0){
        throw res.message;
      }
      // else if(res.status == 2){
      //   //UN AUTHORISE
      // }

      AuthModel.mobile = mobile;

      apiRes.data = res;
      apiRes.state = Status.COMPLETED;
      completion(apiRes);
    }catch(e){
      print(e);
      apiRes.msg = e;
      apiRes.state = Status.ERROR;
      completion(apiRes);
    }
  }

  static Future validateOtp({String otp,Function(ApiResponse) completion}) async {

    print(mobile);
    var apiRes = ApiResponse<ResIsValidOTP>();
    try{

      apiRes.state = Status.LOADING;

      completion(apiRes);

      ResIsValidOTP res = await _authRepo.isValidOTPApi(AuthModel.mobile, otp);

      if(res.status == 0){
        throw res.message;
      }
      // else if(res.status == 2){
      //   //UN AUTHORISE
      // }

      final prefs = UserPreferencesService();
      
      prefs.saveUser(MyUser(token: '${res.data.tokenType} ${res.data.accesstoken}',isUserLogin: true,id: 0));
      
      apiRes.data = res;
      apiRes.state = Status.COMPLETED;
      completion(apiRes);
    }catch(e){
      print(e);
      apiRes.msg = e;
      apiRes.state = Status.ERROR;
      completion(apiRes);
    }
  }

}