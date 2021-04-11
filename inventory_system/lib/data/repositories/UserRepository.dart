import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/data/models/req/ReqIsValidMobile.dart';
import 'package:inventory_system/data/models/req/ReqIsValidOTP.dart';
import 'package:inventory_system/data/models/res/BaseRes.dart';
import 'package:inventory_system/data/models/res/ResGetProfileDetails.dart';
import 'package:inventory_system/data/models/res/ResIsValidOTP.dart';
import 'package:inventory_system/services/webService.dart';

class UserRepository{

  WebService _webService = WebService();

  Future<ResGetProfileDetails> getProfileDetailsApi() async{
    var res = await _webService.getApi(kGetProfileDetails);

    return ResGetProfileDetails.fromJson(res);
  }
}