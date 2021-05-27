
class ResCMS {
  ResCMS({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  ResCMSData data;

  factory ResCMS.fromJson(Map<String, dynamic> json) => ResCMS(
    status: json["Status"],
    message: json["Message"],
    data: ResCMSData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "data": data.toJson(),
  };
}

class ResCMSData {
  ResCMSData({
    this.totalRecords,
    this.pageSize,
    this.currentPage,
    this.list,
  });

  int totalRecords;
  int pageSize;
  int currentPage;
  List<ResCMSList> list;

  factory ResCMSData.fromJson(Map<String, dynamic> json) {
    if(json["list"] == null){
      return ResCMSData(
        totalRecords: json["TotalRecords"],
        pageSize: json["PageSize"],
        currentPage: json["CurrentPage"],
      );
    }
    return ResCMSData(
      totalRecords: json["TotalRecords"],
      pageSize: json["PageSize"],
      currentPage: json["CurrentPage"],
      list: List<ResCMSList>.from(json["list"].map((x) => ResCMSList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "TotalRecords": totalRecords,
    "PageSize": pageSize,
    "CurrentPage": currentPage,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ResCMSList {
  ResCMSList({
    this.privacyPolicyid,
    this.htmldata,
    this.flagdeleted,
    this.createddate,
    this.updateddate,
    this.endefdt,
    this.craetedby,
    this.updatedby,
  });

  int privacyPolicyid;
  String htmldata;
  bool flagdeleted;
  DateTime createddate;
  DateTime updateddate;
  DateTime endefdt;
  int craetedby;
  int updatedby;

  factory ResCMSList.fromJson(Map<String, dynamic> json) => ResCMSList(
    privacyPolicyid: json["PrivacyPolicyid"],
    htmldata: json["Htmldata"],
    flagdeleted: json["flagdeleted"],
    createddate: DateTime.parse(json["createddate"]),
    updateddate: DateTime.parse(json["updateddate"]),
    endefdt: DateTime.parse(json["endefdt"]),
    craetedby: json["craetedby"],
    updatedby: json["updatedby"],
  );

  Map<String, dynamic> toJson() => {
    "PrivacyPolicyid": privacyPolicyid,
    "Htmldata": htmldata,
    "flagdeleted": flagdeleted,
    "createddate": createddate.toIso8601String(),
    "updateddate": updateddate.toIso8601String(),
    "endefdt": endefdt.toIso8601String(),
    "craetedby": craetedby,
    "updatedby": updatedby,
  };
}
