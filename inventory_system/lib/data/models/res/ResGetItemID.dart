// To parse this JSON data, do
//
//     final resGetItemId = resGetItemIdFromJson(jsonString);

import 'dart:convert';

ResGetItemId resGetItemIdFromJson(String str) => ResGetItemId.fromJson(json.decode(str));

String resGetItemIdToJson(ResGetItemId data) => json.encode(data.toJson());

class ResGetItemId {
  ResGetItemId({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory ResGetItemId.fromJson(Map<String, dynamic> json) => ResGetItemId(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalRecords: json["TotalRecords"],
    pageSize: json["PageSize"],
    currentPage: json["CurrentPage"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TotalRecords": totalRecords,
    "PageSize": pageSize,
    "CurrentPage": currentPage,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    this.itemId,
  });

  int itemId;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    itemId: json["ItemID"],
  );

  Map<String, dynamic> toJson() => {
    "ItemID": itemId,
  };
}
