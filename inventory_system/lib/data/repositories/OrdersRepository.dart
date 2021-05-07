import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/data/models/req/ReqGetBillDetails.dart';
import 'package:inventory_system/data/models/res/ResGetBillDetails.dart';
import 'package:inventory_system/services/userPreferencesService.dart';
import 'package:inventory_system/services/webService.dart';

class OrderRepository{

  WebService _webService = WebService();

  Future<ResGetBillDetails> getOrders({String fromDate, String toDate}) async{

    final user = await UserPreferencesService().getUser();

    var req  = ReqGetBillDetails(partyID: user.id,fromDate: fromDate,toDate: toDate);

    var res = await _webService.getApi('$kGetBillDetails?PartyID=${req.partyID}&FromDate=${req.fromDate}&ToDate=${req.toDate}');

    return ResGetBillDetails.fromJson(res);
  }

}