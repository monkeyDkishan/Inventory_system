import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/data/models/req/ReqAddOrderDetails.dart';
import 'package:inventory_system/data/models/res/ResAddOrderDetails.dart';
import 'package:inventory_system/data/models/res/ResCMS.dart';
import 'package:inventory_system/data/models/res/ResGetDeliveryType.dart';
import 'package:inventory_system/data/models/res/ResGetInvoiceList.dart';
import 'package:inventory_system/data/models/res/ResGetItemStokeDetails.dart';
import 'package:inventory_system/data/models/res/ResGetTotalOutStanding.dart';
import 'package:inventory_system/services/webService.dart';
import 'package:http/http.dart' as http;

class CartRepository{

  WebService _webService = WebService();

  Future<ResGetDeliveryType> getDeliveryType() async{
    var res = await _webService.getApi(kGetDeliveryType);

    return ResGetDeliveryType.fromJson(res);
  }

  Future<ResAddOrderDetails> addOrder({ReqAddOrderDetails req}) async{

    var res = await _webService.postApi(kAddOrderDetails, req.toJson());

    return ResAddOrderDetails.fromJson(res);
  }

  Future<ResGetItemStokeDetails> isInStock(int productID, int Quntity, int Unitid) async{

    var res = await _webService.getApiWithQuery(kGetItemStokeDetails, {
      "ProductID":"$productID",
      "Quntity":"$Quntity",
      "Unitid":"$Unitid"
    });

    return ResGetItemStokeDetails.fromJson(res);
  }
  
}