
import 'package:inventory_system/data/models/res/ResCMS.dart';
import 'package:inventory_system/services/webService.dart';

class ServiceRepository{

  WebService _webService = WebService();

  Future<ResCMS> getCMSPage(String urlPath) async{
    var res = await _webService.getApi(urlPath);

    try{
      return ResCMS.fromJson(res);
    }catch(e){
      throw "Decoding Error";
    }
  }
}