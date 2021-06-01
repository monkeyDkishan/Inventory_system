import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/data/models/req/ReqAddOrderDetails.dart';
import 'package:inventory_system/data/models/res/ResAddOrderDetails.dart';
import 'package:inventory_system/data/models/res/ResCMS.dart';
import 'package:inventory_system/data/models/res/ResGetDeliveryType.dart';
import 'package:inventory_system/data/models/res/ResGetInvoiceList.dart';
import 'package:inventory_system/data/models/res/ResGetMobileNotification.dart';
import 'package:inventory_system/data/models/res/ResGetTotalOutStanding.dart';
import 'package:inventory_system/services/webService.dart';
import 'package:http/http.dart' as http;

class NotificationRepository{

  WebService _webService = WebService();

  Future<ResGetMobileNotification> getNotifications() async{
    var res = await _webService.getApi(kGetMobileNotification);

    try{
      return ResGetMobileNotification.fromJson(res);
    }catch(e){
      throw "Decoding Error";
    }
  }

}