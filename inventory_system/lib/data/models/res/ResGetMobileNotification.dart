
class ResGetMobileNotification {
  ResGetMobileNotification({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  ResGetMobileNotificationData data;

  factory ResGetMobileNotification.fromJson(Map<String, dynamic> json) => ResGetMobileNotification(
    status: json["Status"],
    message: json["Message"],
    data: ResGetMobileNotificationData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "data": data.toJson(),
  };
}

class ResGetMobileNotificationData {
  ResGetMobileNotificationData({
    this.totalRecords,
    this.pageSize,
    this.currentPage,
    this.list,
  });

  int totalRecords;
  int pageSize;
  int currentPage;
  List<ResGetMobileNotificationList> list;

  factory ResGetMobileNotificationData.fromJson(Map<String, dynamic> json) => ResGetMobileNotificationData(
    totalRecords: json["TotalRecords"],
    pageSize: json["PageSize"],
    currentPage: json["CurrentPage"],
    list: List<ResGetMobileNotificationList>.from(json["list"].map((x) => ResGetMobileNotificationList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TotalRecords": totalRecords,
    "PageSize": pageSize,
    "CurrentPage": currentPage,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ResGetMobileNotificationList {
  ResGetMobileNotificationList({
    this.notificationid,
    this.notificationTitle,
    this.notificationDesc,
    this.notificationScreenId,
    this.partyId,
    this.flagdeleted,
    this.createddate,
    this.craetedby,
    this.updateddate,
    this.updatedby,
  });

  int notificationid;
  String notificationTitle;
  String notificationDesc;
  int notificationScreenId;
  int partyId;
  bool flagdeleted;
  DateTime createddate;
  int craetedby;
  DateTime updateddate;
  int updatedby;

  factory ResGetMobileNotificationList.fromJson(Map<String, dynamic> json) => ResGetMobileNotificationList(
    notificationid: json["Notificationid"],
    notificationTitle: json["notification_title"],
    notificationDesc: json["notification_desc"],
    notificationScreenId: json["notification_screen_id"],
    partyId: json["PartyID"],
    flagdeleted: json["flagdeleted"],
    createddate: DateTime.parse(json["createddate"]),
    craetedby: json["craetedby"],
    updateddate: DateTime.parse(json["updateddate"]),
    updatedby: json["updatedby"],
  );

  Map<String, dynamic> toJson() => {
    "Notificationid": notificationid,
    "notification_title": notificationTitle,
    "notification_desc": notificationDesc,
    "notification_screen_id": notificationScreenId,
    "PartyID": partyId,
    "flagdeleted": flagdeleted,
    "createddate": createddate.toIso8601String(),
    "craetedby": craetedby,
    "updateddate": updateddate.toIso8601String(),
    "updatedby": updatedby,
  };
}
