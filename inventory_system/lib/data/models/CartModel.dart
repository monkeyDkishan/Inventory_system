
import 'package:inventory_system/data/models/res/ResGetDeliveryType.dart';
import 'package:inventory_system/data/repositories/CartRepository.dart';
import 'package:inventory_system/services/webService.dart';

class CartModel {
  static CartRepository _cartRepo = CartRepository();

  static var deliveryTypeRes = ApiResponse<ResGetDeliveryType>();

  static Future getDeliveryType({Function(ApiResponse<ResGetDeliveryType>) completion}) async {
    try {
      deliveryTypeRes.state = Status.LOADING;

      completion(deliveryTypeRes);

      var res = await _cartRepo.getDeliveryType();

      if (res.status == 0) {
        throw res.message;
      }
      // else if(res.status == 2){
      //   //UN AUTHORISEa
      // }

      deliveryTypeRes.data = res;
      deliveryTypeRes.state = Status.COMPLETED;
      completion(deliveryTypeRes);
    } catch (e) {
      print(e);
      deliveryTypeRes.msg = e.toString();
      deliveryTypeRes.state = Status.ERROR;
      completion(deliveryTypeRes);
    }
  }

}
