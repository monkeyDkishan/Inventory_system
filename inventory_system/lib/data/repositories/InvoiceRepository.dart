import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/data/models/res/ResCMS.dart';
import 'package:inventory_system/data/models/res/ResGetInvoiceList.dart';
import 'package:inventory_system/data/models/res/ResGetTotalOutStanding.dart';
import 'package:inventory_system/services/webService.dart';

class InvoiceRepository{

  WebService _webService = WebService();

  Future<ResGetTotalOutStanding> getTotalOutStanding() async{
    var res = await _webService.getApi(kGetTotalOutStanding);

    return ResGetTotalOutStanding.fromJson(res);
  }

  Future<ResGetInvoice> getInvoiceList() async{
    var res = await _webService.getApi(kGetInvoiceList);

    return ResGetInvoice.fromJson(res);
  }

  Future<ResGetInvoice> getInvoiceDetail(int orderId) async{
    var res = await _webService.getApiWithQuery(kGetInvoiceList, {
      "Orderid" : orderId.toString()
    });

    return ResGetInvoice.fromJson(res);
  }

}