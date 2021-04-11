import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/data/models/req/ReqIsValidMobile.dart';
import 'package:inventory_system/data/models/req/ReqIsValidOTP.dart';
import 'package:inventory_system/data/models/res/BaseRes.dart';
import 'package:inventory_system/data/models/res/ResIsValidOTP.dart';
import 'package:inventory_system/services/webService.dart';

class AuthRepository{

  WebService _webService = WebService();

  Future<BaseRes> isValidMobileApi(String mobile) async{

    final body = ReqIsValidMobile(mobileNo: mobile);

    var res = await _webService.postApi(kIsValidMobile, body.toJson());

    return BaseRes.fromJson(res);
  }

  Future<ResIsValidOTP> isValidOTPApi(String mobile,String otp) async{

    final body = ReqIsValidOTP(mobileNo: mobile,otp: otp);

    var res = await _webService.postApi("isValidOTP", body.toJson());

    return ResIsValidOTP.fromJson(res);
  }

}