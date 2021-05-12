import 'package:inventory_system/data/models/res/BaseRes.dart';
import 'package:inventory_system/data/models/res/ResGetProfileDetails.dart';
import 'package:inventory_system/data/models/res/ResIsValidOTP.dart';
import 'package:inventory_system/data/repositories/AuthRepository.dart';
import 'package:inventory_system/data/repositories/UserRepository.dart';
import 'package:inventory_system/services/userPreferencesService.dart';
import 'package:inventory_system/services/webService.dart';

class UserModel {
  static UserRepository _userRepo = UserRepository();

  static var apiRes = ApiResponse<ResGetProfileDetails>();

  static ResGetProfileDetailsList get userRes {
    try {
      return apiRes.data.data.list.first;
    } catch (e) {
      return null;
    }
  }

  static updateFCM() async{
    await _userRepo.updateFcmToken();
  }

  static Future getProfileDetails({Function(ApiResponse<ResGetProfileDetails>) completion}) async {

    try {
      apiRes.state = Status.LOADING;

      completion(apiRes);

      ResGetProfileDetails res = await _userRepo.getProfileDetailsApi();

      if (res.status == 0) {
        throw res.message;
      }
      // else if(res.status == 2){
      //   //UN AUTHORISEa
      // }

      apiRes.data = res;
      apiRes.state = Status.COMPLETED;

      final data = res.data.list.first;

      final prefs = UserPreferencesService();

      final user = await prefs.getUser();

      print("Tcs Data");

      print(data.partyid);
      print(data.tcsLimit);
      print(data.tcsAmountPercentage);

      await prefs.saveUser(MyUser(token: user.token ?? '',isUserLogin: user.isUserLogin,id: data.partyid ?? 0,tcsLimit: data.tcsLimit,tcsAmountPercentage: data.tcsAmountPercentage,tcsAmount: data.tcsAmount,isTCSApply: data.isTcsApply));

      completion(apiRes);
    } catch (e) {
      print("ERROR:-");
      print(e);
      apiRes.msg = e.toString();
      apiRes.state = Status.ERROR;
      completion(apiRes);
    }
  }
}
