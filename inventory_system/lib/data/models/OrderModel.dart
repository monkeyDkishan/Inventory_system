// getOrders
import 'package:inventory_system/data/models/res/ResGetBillDetails.dart';
import 'package:inventory_system/data/repositories/OrdersRepository.dart';
import 'package:inventory_system/services/webService.dart';

class OrderModel {

  static OrderRepository _userRepo = OrderRepository();

  static var apiRes = ApiResponse<ResGetBillDetails>();


  static Future getOrder({Function(ApiResponse<ResGetBillDetails>) completion}) async {

    try {
      apiRes.state = Status.LOADING;

      completion(apiRes);

      ResGetBillDetails res = await _userRepo.getOrders(toDate: "10/22/2021",fromDate: "2/12/2019");

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