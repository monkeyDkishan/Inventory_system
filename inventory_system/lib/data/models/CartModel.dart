
import 'package:inventory_system/data/models/req/ReqAddOrderDetails.dart';
import 'package:inventory_system/data/models/res/ResAddOrderDetails.dart';
import 'package:inventory_system/data/models/res/ResGetDeliveryType.dart';
import 'package:inventory_system/data/repositories/CartRepository.dart';
import 'package:inventory_system/services/userPreferencesService.dart';
import 'package:inventory_system/services/webService.dart';

class CartModel {
  static CartRepository _cartRepo = CartRepository();

  static var deliveryTypeRes = ApiResponse<ResGetDeliveryType>();

  static var addOrderRes = ApiResponse<ResAddOrderDetails>();


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

  static Future addOrder({double deliveryCharge,double finalTotal,double subTotal,int selectedDeliveryType,List<ReqCartItemAddOrderDetails> cartItems,Function(ApiResponse<ResAddOrderDetails>) completion}) async {
    try {

      addOrderRes.state = Status.LOADING;

      completion(addOrderRes);

      final user = await UserPreferencesService().getUser();

      final req = ReqAddOrderDetails(
          partyid: user.id,
          tcsamount: user.tcsAmount,
          tcsamountpercentage: user.tcsAmountPercentage,
          deliveryCharge: deliveryCharge,
          finalTotal: finalTotal,
          selectedDeliveryType: selectedDeliveryType,
          subTotal: subTotal,
          cartItems: cartItems
      );

      var res = await _cartRepo.addOrder(req: req);

      if (res.status == 0) {
        print('status reached');
        throw res.message ?? "";
      }
      // else if(res.status == 2){
      //   //UN AUTHORISEa
      // }

      addOrderRes.data = res;
      addOrderRes.state = Status.COMPLETED;
      completion(addOrderRes);
    } catch (e) {
      print('EROR:= ');
      print(e);
      addOrderRes.msg = e.toString();
      addOrderRes.state = Status.ERROR;
      completion(addOrderRes);
    }
  }

  Future<bool> isInStock({int productID,int Quntity,int Unitid}) async{
    try{
       final res = await _cartRepo.isInStock(productID, Quntity, Unitid);

       if(res.status == 0){
         return false;
       }

       if(res.data == null){
         return false;
       }else{

         if(res.data.availbleStock == null){
           return false;
         }else{
           // if (Quntity >= res.data.availbleStock){
           //   return false;
           // }
           return true;
         }
       }
    }catch(e){
      return false;
    }

  }

}
