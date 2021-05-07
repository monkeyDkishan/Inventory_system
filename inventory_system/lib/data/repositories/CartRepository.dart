import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/data/models/req/ReqAddOrderDetails.dart';
import 'package:inventory_system/data/models/res/ResAddOrderDetails.dart';
import 'package:inventory_system/data/models/res/ResCMS.dart';
import 'package:inventory_system/data/models/res/ResGetDeliveryType.dart';
import 'package:inventory_system/data/models/res/ResGetInvoiceList.dart';
import 'package:inventory_system/data/models/res/ResGetTotalOutStanding.dart';
import 'package:inventory_system/services/webService.dart';

class CartRepository{

  WebService _webService = WebService();

  Future<ResGetDeliveryType> getDeliveryType() async{
    var res = await _webService.getApi(kGetDeliveryType);

    return ResGetDeliveryType.fromJson(res);
  }

  Future<ResAddOrderDetails> addOrder({ReqAddOrderDetails req}) async{

    print(req.toJson());

    var res = await _webService.postApi(kAddOrderDetails, req.toJson());

    return ResAddOrderDetails.fromJson(res);
  }


}