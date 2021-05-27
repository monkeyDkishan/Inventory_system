
class ResGetOrderDetails {
  ResGetOrderDetails({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory ResGetOrderDetails.fromJson(Map<String, dynamic> json) => ResGetOrderDetails(
    status: json["Status"],
    message: json["Message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.totalRecords,
    this.pageSize,
    this.currentPage,
    this.list,
  });

  int totalRecords;
  int pageSize;
  int currentPage;
  List<ListElement> list;

  factory Data.fromJson(Map<String, dynamic> json) {

    if(json["list"] == null){
      return Data();
    }

    return Data(
      totalRecords: json["TotalRecords"],
      pageSize: json["PageSize"],
      currentPage: json["CurrentPage"],
      list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "TotalRecords": totalRecords,
    "PageSize": pageSize,
    "CurrentPage": currentPage,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    this.ordermasterid,
    this.orderid,
    this.ordertypeid,
    this.ordertypename,
    this.partyid,
    this.partyname,
    this.phone,
    this.locationname,
    this.duedate,
    this.remark,
    this.totalpayable,
    this.isinventoryfullfill,
    this.isamountpaid,
    this.isorderopen,
    this.flagdeleted,
    this.endeffdt,
    this.agentId,
    this.agentName,
    this.orderdate,
    this.city,
    this.pincode,
    this.street,
    this.discount,
    this.couriercharges,
    this.billreferencenumber,
    this.vattax,
    this.addtax,
    this.createdon,
    this.updatedon,
    this.freightcharges,
    this.loadingpackingcharge,
    this.insurancecharge,
    this.tcsAmount,
    this.tcsAmountPercentage,
    this.deliveryType,
    this.deliveryCharges,
    this.isOrderPlaced,
    this.orderStatus,
    this.orderitems,
  });

  int ordermasterid;
  int orderid;
  int ordertypeid;
  String ordertypename;
  int partyid;
  String partyname;
  String phone;
  String locationname;
  DateTime duedate;
  String remark;
  double totalpayable;
  bool isinventoryfullfill;
  bool isamountpaid;
  bool isorderopen;
  bool flagdeleted;
  DateTime endeffdt;
  int agentId;
  String agentName;
  DateTime orderdate;
  String city;
  String pincode;
  String street;
  double discount;
  double couriercharges;
  String billreferencenumber;
  double vattax;
  double addtax;
  DateTime createdon;
  DateTime updatedon;
  double freightcharges;
  double loadingpackingcharge;
  double insurancecharge;
  double tcsAmount;
  double tcsAmountPercentage;
  String deliveryType;
  double deliveryCharges;
  bool isOrderPlaced;
  String orderStatus;
  List<Orderitem> orderitems;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    ordermasterid: json["ordermasterid"],
    orderid: json["orderid"],
    ordertypeid: json["ordertypeid"],
    ordertypename: json["ordertypename"],
    partyid: json["partyid"],
    partyname: json["partyname"],
    phone: json["phone"],
    locationname: json["locationname"],
    duedate: DateTime.parse(json["duedate"]),
    remark: json["remark"],
    totalpayable: json["totalpayable"],
    isinventoryfullfill: json["isinventoryfullfill"],
    isamountpaid: json["isamountpaid"],
    isorderopen: json["isorderopen"],
    flagdeleted: json["flagdeleted"],
    endeffdt: DateTime.parse(json["endeffdt"]),
    agentId: json["AgentID"],
    agentName: json["AgentName"],
    orderdate: DateTime.parse(json["orderdate"]),
    city: json["city"],
    pincode: json["pincode"],
    street: json["street"],
    discount: json["discount"],
    couriercharges: json["couriercharges"],
    billreferencenumber: json["billreferencenumber"],
    vattax: json["vattax"],
    addtax: json["addtax"],
    createdon: DateTime.parse(json["createdon"]),
    updatedon: DateTime.parse(json["updatedon"]),
    freightcharges: json["freightcharges"],
    loadingpackingcharge: json["loadingpackingcharge"],
    insurancecharge: json["insurancecharge"],
    tcsAmount: json["TCSAmount"],
    tcsAmountPercentage: json["TCSAmountPercentage"],
    deliveryType: json["DeliveryType"],
    deliveryCharges: json["DeliveryCharges"],
    isOrderPlaced: json["isOrderPlaced"],
    orderStatus: json["OrderStatus"],
    orderitems: List<Orderitem>.from(json["orderitems"].map((x) => Orderitem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ordermasterid": ordermasterid,
    "orderid": orderid,
    "ordertypeid": ordertypeid,
    "ordertypename": ordertypename,
    "partyid": partyid,
    "partyname": partyname,
    "phone": phone,
    "locationname": locationname,
    "duedate": duedate.toIso8601String(),
    "remark": remark,
    "totalpayable": totalpayable,
    "isinventoryfullfill": isinventoryfullfill,
    "isamountpaid": isamountpaid,
    "isorderopen": isorderopen,
    "flagdeleted": flagdeleted,
    "endeffdt": endeffdt.toIso8601String(),
    "AgentID": agentId,
    "AgentName": agentName,
    "orderdate": orderdate.toIso8601String(),
    "city": city,
    "pincode": pincode,
    "street": street,
    "discount": discount,
    "couriercharges": couriercharges,
    "billreferencenumber": billreferencenumber,
    "vattax": vattax,
    "addtax": addtax,
    "createdon": createdon.toIso8601String(),
    "updatedon": updatedon.toIso8601String(),
    "freightcharges": freightcharges,
    "loadingpackingcharge": loadingpackingcharge,
    "insurancecharge": insurancecharge,
    "TCSAmount": tcsAmount,
    "TCSAmountPercentage": tcsAmountPercentage,
    "DeliveryType": deliveryType,
    "DeliveryCharges": deliveryCharges,
    "isOrderPlaced": isOrderPlaced,
    "OrderStatus": orderStatus,
    "orderitems": List<dynamic>.from(orderitems.map((x) => x.toJson())),
  };
}

class Orderitem {
  Orderitem({
    this.orderitemid,
    this.ordermasterid,
    this.ordertypeid,
    this.ordertypename,
    this.productid,
    this.productname,
    this.categoryid,
    this.categoryName,
    this.subcategoryid,
    this.subCategoryName,
    this.isstandalone,
    // this.unitmaster,
    this.noofunit,
    this.unitprice,
    this.discount,
    this.itempayable,
    this.noofunitinbase,
    this.flagdeleted,
    this.endeffdt,
    this.locationid,
    this.locationname,
    this.receiveitemid,
    this.seqno,
    this.itemreturndate,
    this.itemreturnremarks,
    this.isaddedinstock,
    this.returnedorderitemid,
    this.cgstamount,
    this.sgstamount,
    this.igstamount,
    this.unitpricewithoutgst,
    this.discountpercentage,
    this.note,
  });

  int orderitemid;
  int ordermasterid;
  int ordertypeid;
  String ordertypename;
  int productid;
  String productname;
  int categoryid;
  String categoryName;
  int subcategoryid;
  String subCategoryName;
  bool isstandalone;
  // List<Unitmaster> unitmaster;
  double noofunit;
  double unitprice;
  double discount;
  double itempayable;
  double noofunitinbase;
  bool flagdeleted;
  DateTime endeffdt;
  int locationid;
  String locationname;
  int receiveitemid;
  int seqno;
  DateTime itemreturndate;
  String itemreturnremarks;
  bool isaddedinstock;
  int returnedorderitemid;
  double cgstamount;
  double sgstamount;
  double igstamount;
  double unitpricewithoutgst;
  double discountpercentage;
  String note;

  factory Orderitem.fromJson(Map<String, dynamic> json) => Orderitem(
    orderitemid: json["orderitemid"],
    ordermasterid: json["ordermasterid"],
    ordertypeid: json["ordertypeid"],
    ordertypename: json["ordertypename"],
    productid: json["productid"],
    productname: json["productname"],
    categoryid: json["Categoryid"],
    categoryName: json["CategoryName"],
    subcategoryid: json["Subcategoryid"],
    subCategoryName: json["SubCategoryName"],
    isstandalone: json["isstandalone"],
    // unitmaster: List<Unitmaster>.from(json["unitmaster"].map((x) => Unitmaster.fromJson(x))),
    noofunit: json["noofunit"],
    unitprice: json["unitprice"],
    discount: json["discount"],
    itempayable: json["itempayable"],
    noofunitinbase: json["noofunitinbase"],
    flagdeleted: json["flagdeleted"],
    endeffdt: DateTime.parse(json["endeffdt"]),
    locationid: json["locationid"],
    locationname: json["locationname"],
    receiveitemid: json["receiveitemid"],
    seqno: json["seqno"],
    itemreturndate: DateTime.parse(json["itemreturndate"]),
    itemreturnremarks: json["itemreturnremarks"],
    isaddedinstock: json["isaddedinstock"],
    returnedorderitemid: json["returnedorderitemid"],
    cgstamount: json["cgstamount"],
    sgstamount: json["sgstamount"],
    igstamount: json["igstamount"],
    unitpricewithoutgst: json["unitpricewithoutgst"],
    discountpercentage: json["discountpercentage"],
    note: json["Note"],
  );

  Map<String, dynamic> toJson() => {
    "orderitemid": orderitemid,
    "ordermasterid": ordermasterid,
    "ordertypeid": ordertypeid,
    "ordertypename": ordertypename,
    "productid": productid,
    "productname": productname,
    "Categoryid": categoryid,
    "CategoryName": categoryName,
    "Subcategoryid": subcategoryid,
    "SubCategoryName": subCategoryName,
    "isstandalone": isstandalone,
    // "unitmaster": List<dynamic>.from(unitmaster.map((x) => x.toJson())),
    "noofunit": noofunit,
    "unitprice": unitprice,
    "discount": discount,
    "itempayable": itempayable,
    "noofunitinbase": noofunitinbase,
    "flagdeleted": flagdeleted,
    "endeffdt": endeffdt.toIso8601String(),
    "locationid": locationid,
    "locationname": locationname,
    "receiveitemid": receiveitemid,
    "seqno": seqno,
    "itemreturndate": itemreturndate.toIso8601String(),
    "itemreturnremarks": itemreturnremarks,
    "isaddedinstock": isaddedinstock,
    "returnedorderitemid": returnedorderitemid,
    "cgstamount": cgstamount,
    "sgstamount": sgstamount,
    "igstamount": igstamount,
    "unitpricewithoutgst": unitpricewithoutgst,
    "discountpercentage": discountpercentage,
    "Note": note,
  };
}

// class Unitmaster {
//   Unitmaster({
//     this.unitmasterid,
//     this.unitname,
//     this.unitPrize,
//   });
//
//   int unitmasterid;
//   String unitname;
//   double unitPrize;
//
//   factory Unitmaster.fromJson(Map<String, dynamic> json) => Unitmaster(
//     unitmasterid: json["unitmasterid"],
//     unitname: json["unitname"],
//     unitPrize: json["UnitPrize"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "unitmasterid": unitmasterid,
//     "unitname": unitname,
//     "UnitPrize": unitPrize,
//   };
// }

