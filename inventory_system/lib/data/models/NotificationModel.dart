

import 'package:inventory_system/data/models/res/ResGetMobileNotification.dart';
import 'package:inventory_system/data/repositories/NotificationRepository.dart';
import 'package:inventory_system/services/webService.dart';

class NotificationModel {

  static NotificationRepository _userRepo = NotificationRepository();

  static var apiRes = ApiResponse<ResGetMobileNotification>();


  static Future getNotification({Function(ApiResponse<ResGetMobileNotification>) completion}) async {

    try {
      apiRes.state = Status.LOADING;

      completion(apiRes);

      ResGetMobileNotification res = await _userRepo.getNotifications();

      if (res.status == 0) {
        throw res.message;
      }
      // else if(res.status == 2){
      //   //UN AUTHORISEa
      // }

      apiRes.data = res;
      apiRes.state = Status.COMPLETED;
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