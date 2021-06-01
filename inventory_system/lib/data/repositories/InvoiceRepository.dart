import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/data/models/res/ResCMS.dart';
import 'package:inventory_system/data/models/res/ResGetInvoiceList.dart';
import 'package:inventory_system/data/models/res/ResGetTotalOutStanding.dart';
import 'package:inventory_system/services/webService.dart';

class InvoiceRepository{

  WebService _webService = WebService();

  Future<ResGetTotalOutStanding> getTotalOutStanding() async{
    var res = await _webService.getApi(kGetTotalOutStanding);

    try{
      return ResGetTotalOutStanding.fromJson(res);
    }catch(e){
      throw "Decoding Error";
    }
  }

  Future<ResGetInvoice> getInvoiceList() async{
    var res = await _webService.getApi(kGetInvoiceList);

    try{
      return ResGetInvoice.fromJson(res);
    }catch(e){
      throw "Decoding Error";
    }
  }

  Future<ResGetInvoice> getInvoiceDetail(int orderId) async{
    var res = await _webService.getApiWithQuery(kGetInvoiceList, {
      "Orderid" : orderId.toString()
    });

    try{
      return ResGetInvoice.fromJson(res);
    }catch(e){
      throw "Decoding Error";
    }
  }

}