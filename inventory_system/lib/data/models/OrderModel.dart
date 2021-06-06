// getOrders
import 'package:inventory_system/data/models/req/ReqUpdateOrderDetails.dart';
import 'package:inventory_system/data/models/res/BaseRes.dart';
import 'package:inventory_system/data/models/res/ResGetBillDetails.dart';
import 'package:inventory_system/data/models/res/ResGetOrderDetails.dart';
import 'package:inventory_system/data/repositories/OrdersRepository.dart';
import 'package:inventory_system/services/webService.dart';

class OrderModel {

  static OrderRepository _userRepo = OrderRepository();

  static var apiRes = ApiResponse<ResGetBillDetails>();

  static var orders = ApiResponse<ResGetBillDetails>();

  static var selectedOrder = ResGetOrderDetails();

  static Future updateOrderDetails({ReqUpdateOrderDetails req, Function(ApiResponse<BaseRes>) completion}) async {
    var myRes = ApiResponse<BaseRes>();
    try {
      myRes.state = Status.LOADING;

      completion(myRes);

      final res = await _userRepo.updateOrderDetails(req: req);

      if (res.status == 0) {
        throw res.message ?? "";
      }

      myRes.data = res;
      myRes.state = Status.COMPLETED;
      completion(myRes);
    } catch (e) {
      print("ERROR:-");
      print(e);
      myRes.msg = e.toString();
      myRes.state = Status.ERROR;
      completion(myRes);
    }
  }

  static Future deleteOrder({int id, Function(ApiResponse<BaseRes>) completion}) async {
    var myRes = ApiResponse<BaseRes>();
    try {
      myRes.state = Status.LOADING;

      completion(myRes);

      final res = await _userRepo.deleteOrder(id: id);

      if (res.status == 0) {
        throw res.message;
      }
      // else if(res.status == 2){
      //   //UN AUTHORISEa
      // }

      myRes.data = res;
      myRes.state = Status.COMPLETED;
      completion(myRes);
    } catch (e) {
      print("ERROR:-");
      print(e);
      myRes.msg = e.toString();
      myRes.state = Status.ERROR;
      completion(myRes);
    }
  }

  static Future getAllOrder({Function(ApiResponse<ResGetBillDetails>) completion}) async {

    try {
      orders.state = Status.LOADING;

      completion(orders);

      final res = await _userRepo.getAllOrders();

      if (res.status == 0) {
        throw res.message;
      }
      // else if(res.status == 2){
      //   //UN AUTHORISEa
      // }

      orders.data = res;
      orders.state = Status.COMPLETED;
      completion(orders);
    } catch (e) {
      print("ERROR:-");
      print(e);
      orders.msg = e.toString();
      orders.state = Status.ERROR;
      completion(orders);
    }
  }

  static Future getOrder({String toDate,String fromDate,Function(ApiResponse<ResGetBillDetails>) completion}) async {

    try {
      apiRes.state = Status.LOADING;

      completion(apiRes);

      ResGetBillDetails res = await _userRepo.getOrders(toDate: toDate,fromDate: fromDate);

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