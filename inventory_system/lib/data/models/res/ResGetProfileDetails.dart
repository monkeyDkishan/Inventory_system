import 'dart:convert';


class ResGetProfileDetails {
  ResGetProfileDetails({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  ResGetProfileDetailsData data;

  factory ResGetProfileDetails.fromJson(Map<String, dynamic> json) => ResGetProfileDetails(
    status: json["Status"],
    message: json["Message"],
    data: ResGetProfileDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "data": data.toJson(),
  };
}

class ResGetProfileDetailsData {
  ResGetProfileDetailsData({
    this.totalRecords,
    this.pageSize,
    this.currentPage,
    this.list,
  });

  int totalRecords;
  int pageSize;
  int currentPage;
  List<ResGetProfileDetailsList> list;

  factory ResGetProfileDetailsData.fromJson(Map<String, dynamic> json) {

    if (json["list"] == null){
      return ResGetProfileDetailsData(
        totalRecords: json["TotalRecords"],
        pageSize: json["PageSize"],
        currentPage: json["CurrentPage"],
      );
    }

    return ResGetProfileDetailsData(
      totalRecords: json["TotalRecords"],
      pageSize: json["PageSize"],
      currentPage: json["CurrentPage"],
      list: List<ResGetProfileDetailsList>.from(json["list"].map((x) => ResGetProfileDetailsList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "TotalRecords": totalRecords,
    "PageSize": pageSize,
    "CurrentPage": currentPage,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ResGetProfileDetailsList {
  ResGetProfileDetailsList({
    // this.partytypename,
    this.partyid,
    // this.partytypeid,
    this.partyname,
    // this.street,
    // this.city,
    // this.zipcode,
    this.phone,
    // this.fax,
    // this.email,
    // this.remark,
    // this.flagdeleted,
    // this.endeffdt,
    // this.agentid,
    // this.partynumber,
    // this.gstno,
    // this.stateid,
    // this.duedays,
    // this.statename,
    this.tcsAmountPercentage,
    this.tcsLimit,
    this.tcsAmount,
    this.isTcsApply,
  });

  int partyid;
  String partyname;
  // int partytypeid;
  // String partytypename;
  // String street;
  // String city;
  // int zipcode;
  String phone;
  // String fax;
  // String email;
  // String remark;
  // bool flagdeleted;
  // DateTime endeffdt;
  // int agentid;
  // dynamic agentname;
  // int partynumber;
  // String gstno;
  // int stateid;
  // int duedays;
  // String statename;
  double tcsAmountPercentage;
  double tcsLimit;
  double tcsAmount;
  bool isTcsApply;

  factory ResGetProfileDetailsList.fromJson(Map<String, dynamic> json) => ResGetProfileDetailsList(
    // partytypename: json["partytypename"],
    partyid: json["partyid"],
    // partytypeid: json["partytypeid"],
    partyname: json["partyname"],
    // street: json["street"],
    // city: json["city"],
    // zipcode: json["zipcode"],
    phone: json["phone"],
    // fax: json["fax"],
    // email: json["email"],
    // remark: json["remark"],
    // flagdeleted: json["flagdeleted"],
    // endeffdt: DateTime.parse(json["endeffdt"]),
    // agentid: json["agentid"],
    // partynumber: json["partynumber"],
    // gstno: json["gstno"],
    // stateid: json["stateid"],
    // duedays: json["duedays"],
    // statename: json["Statename"],
    tcsAmountPercentage: json["TcsAmountPercentage"].toDouble(),
    tcsLimit: json["TcsLimit"],
    tcsAmount: json["TcsAmount"].toDouble(),
    isTcsApply: json["isTCSApply"],
  );

  Map<String, dynamic> toJson() => {
    // "partytypename": partytypename,
    // "partyid": partyid,
    // "partytypeid": partytypeid,
    "partyname": partyname,
    // "street": street,
    // "city": city,
    // "zipcode": zipcode,
    "phone": phone,
    // "fax": fax,
    // "email": email,
    // "remark": remark,
    // "flagdeleted": flagdeleted,
    // "endeffdt": endeffdt.toIso8601String(),
    // "agentid": agentid,
    // "partynumber": partynumber,
    // "gstno": gstno,
    // "stateid": stateid,
    // "duedays": duedays,
    // "Statename": statename,
    "TcsAmountPercentage": tcsAmountPercentage,
    "TcsLimit": tcsLimit,
    "TcsAmount": tcsAmount,
    "isTCSApply": isTcsApply,

  };
}

