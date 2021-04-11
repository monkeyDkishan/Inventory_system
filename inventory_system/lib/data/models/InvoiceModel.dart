import 'package:inventory_system/data/models/res/BaseRes.dart';
import 'package:inventory_system/data/models/res/ResGetInvoiceList.dart';
import 'package:inventory_system/data/models/res/ResGetProfileDetails.dart';
import 'package:inventory_system/data/models/res/ResGetTotalOutStanding.dart';
import 'package:inventory_system/data/models/res/ResIsValidOTP.dart';
import 'package:inventory_system/data/repositories/AuthRepository.dart';
import 'package:inventory_system/data/repositories/InvoiceRepository.dart';
import 'package:inventory_system/data/repositories/UserRepository.dart';
import 'package:inventory_system/services/userPreferencesService.dart';
import 'package:inventory_system/services/webService.dart';

class InvoiceModel {
  static InvoiceRepository _invoiceRepo = InvoiceRepository();

  static var totalOutStandingRes = ApiResponse<ResGetTotalOutStanding>();

  static var resGetInvoice = ApiResponse<ResGetInvoice>();

  static var resGetInvoiceDetail = ApiResponse<ResGetInvoice>();


  static Future getInvoiceDetail({int orderId,Function(ApiResponse<ResGetInvoice>) completion}) async {
    try {
      resGetInvoiceDetail.state = Status.LOADING;

      completion(resGetInvoiceDetail);

      ResGetInvoice res = await _invoiceRepo.getInvoiceDetail(orderId);

      if (res.status == 0) {
        throw res.message;
      }
      // else if(res.status == 2){
      //   //UN AUTHORISEa
      // }

      resGetInvoiceDetail.data = res;
      resGetInvoiceDetail.state = Status.COMPLETED;
      completion(resGetInvoiceDetail);
    } catch (e) {
      print(e);
      resGetInvoiceDetail.msg = e;
      resGetInvoiceDetail.state = Status.ERROR;
      completion(resGetInvoiceDetail);
    }
  }


  static Future getInvoice({Function(ApiResponse<ResGetInvoice>) completion}) async {

    try {
      resGetInvoice.state = Status.LOADING;

      completion(resGetInvoice);

      ResGetInvoice res = await _invoiceRepo.getInvoiceList();

      if (res.status == 0) {
        throw res.message;
      }
      // else if(res.status == 2){
      //   //UN AUTHORISEa
      // }

      resGetInvoice.data = res;
      resGetInvoice.state = Status.COMPLETED;
      completion(resGetInvoice);
    } catch (e) {
      print(e);
      resGetInvoice.msg = e;
      resGetInvoice.state = Status.ERROR;
      completion(resGetInvoice);
    }
  }

  static Future getTotalOutStandings({Function(ApiResponse<ResGetTotalOutStanding>) completion}) async {

    try {
      totalOutStandingRes.state = Status.LOADING;

      completion(totalOutStandingRes);

      ResGetTotalOutStanding res = await _invoiceRepo.getTotalOutStanding();

      if (res.status == 0) {
        throw res.message;
      }
      // else if(res.status == 2){
      //   //UN AUTHORISEa
      // }

      totalOutStandingRes.data = res;
      totalOutStandingRes.state = Status.COMPLETED;
      completion(totalOutStandingRes);
    } catch (e) {
      print(e);
      totalOutStandingRes.msg = e;
      totalOutStandingRes.state = Status.ERROR;
      completion(totalOutStandingRes);
    }
  }
}
