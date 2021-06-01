import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/data/models/req/ReqGetBillDetails.dart';
import 'package:inventory_system/data/models/res/BaseRes.dart';
import 'package:inventory_system/data/models/res/ResGetBillDetails.dart';
import 'package:inventory_system/data/models/res/ResGetOrderDetails.dart';
import 'package:inventory_system/services/userPreferencesService.dart';
import 'package:inventory_system/services/webService.dart';

class OrderRepository{

  WebService _webService = WebService();

  Future<ResGetBillDetails> getOrders({String fromDate, String toDate}) async{

    final user = await UserPreferencesService().getUser();

    var req  = ReqGetBillDetails(partyID: user.id,fromDate: fromDate,toDate: toDate);

    var res = await _webService.getApi('$kGetBillDetails?PartyID=${req.partyID}&FromDate=${req.fromDate}&ToDate=${req.toDate}');

    try{
      return ResGetBillDetails.fromJson(res);
    }catch(e){
      throw "Decoding Error";
    }
  }

  Future<ResGetBillDetails> getAllOrders() async{

    final user = await UserPreferencesService().getUser();

    var res = await _webService.getApi('GetOrderDetails'+'?PartyID=${user.id}');

    try{
      return ResGetBillDetails.fromJson(res);
    }catch(e){
      throw "Decoding Error";
    }
  }

  Future<BaseRes> deleteOrder({int id}) async{

    var res = await _webService.getApi('DeleteOrderDetails'+'?Orderid=$id');

    return BaseRes.fromJson(res);
  }
}