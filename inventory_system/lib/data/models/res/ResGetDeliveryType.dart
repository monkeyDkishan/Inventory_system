
class ResGetDeliveryType {
  ResGetDeliveryType({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  ResGetDeliveryTypeData data;

  factory ResGetDeliveryType.fromJson(Map<String, dynamic> json) {

    if(json["data"] == null || json["Status"] != 1){
      return ResGetDeliveryType(
        status: json["Status"],
        message: json["Message"],
      );
    }
    return ResGetDeliveryType(
      status: json["Status"],
      message: json["Message"],
      data: ResGetDeliveryTypeData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "data": data.toJson(),
  };
}

class ResGetDeliveryTypeData {
  ResGetDeliveryTypeData({
    this.totalRecords,
    this.pageSize,
    this.currentPage,
    this.list,
  });

  int totalRecords;
  int pageSize;
  int currentPage;
  List<ResGetDeliveryTypeListElement> list;

  factory ResGetDeliveryTypeData.fromJson(Map<String, dynamic> json) => ResGetDeliveryTypeData(
    totalRecords: json["TotalRecords"],
    pageSize: json["PageSize"],
    currentPage: json["CurrentPage"],
    list: List<ResGetDeliveryTypeListElement>.from(json["list"].map((x) => ResGetDeliveryTypeListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TotalRecords": totalRecords,
    "PageSize": pageSize,
    "CurrentPage": currentPage,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ResGetDeliveryTypeListElement {
  ResGetDeliveryTypeListElement({
    this.deliveryid,
    this.partyid,
    this.deliveryType,
    this.price,
    this.createddate,
    this.updateddate,
    this.craetedby,
    this.updatedby,
    this.endefdate,
    this.flagdeleted,
  });

  int deliveryid;
  int partyid;
  String deliveryType;
  double price;
  DateTime createddate;
  DateTime updateddate;
  int craetedby;
  int updatedby;
  DateTime endefdate;
  bool flagdeleted;

  factory ResGetDeliveryTypeListElement.fromJson(Map<String, dynamic> json) => ResGetDeliveryTypeListElement(
    deliveryid: json["Deliveryid"],
    partyid: json["partyid"],
    deliveryType: json["DeliveryType"],
    price: json["price"],
    createddate: DateTime.parse(json["createddate"]),
    updateddate: DateTime.parse(json["updateddate"]),
    craetedby: json["craetedby"],
    updatedby: json["updatedby"],
    endefdate: DateTime.parse(json["endefdate"]),
    flagdeleted: json["flagdeleted"],
  );

  Map<String, dynamic> toJson() => {
    "Deliveryid": deliveryid,
    "partyid": partyid,
    "DeliveryType": deliveryType,
    "price": price,
    "createddate": createddate.toIso8601String(),
    "updateddate": updateddate.toIso8601String(),
    "craetedby": craetedby,
    "updatedby": updatedby,
    "endefdate": endefdate.toIso8601String(),
    "flagdeleted": flagdeleted,
  };
}
