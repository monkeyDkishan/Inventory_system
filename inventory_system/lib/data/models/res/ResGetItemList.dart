
class ResGetItem {
  ResGetItem({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  ResGetItemData data;

  factory ResGetItem.fromJson(Map<String, dynamic> json) => ResGetItem(
    status: json["Status"],
    message: json["Message"],
    data: ResGetItemData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "data": data.toJson(),
  };
}

class ResGetItemData {
  ResGetItemData({
    this.totalRecords,
    this.pageSize,
    this.currentPage,
    this.list,
  });

  int totalRecords;
  int pageSize;
  int currentPage;
  List<ResGetItemList> list;

  factory ResGetItemData.fromJson(Map<String, dynamic> json) => ResGetItemData(
    totalRecords: json["TotalRecords"],
    pageSize: json["PageSize"],
    currentPage: json["CurrentPage"],
    list: List<ResGetItemList>.from(json["list"].map((x) => ResGetItemList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TotalRecords": totalRecords,
    "PageSize": pageSize,
    "CurrentPage": currentPage,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ResGetItemList {
  ResGetItemList({
    this.productid,
    this.productName,
    this.categoryid,
    this.categoryName,
    this.subCategoryName,
    this.code,
    this.subcategoryid,
    this.description,
    this.unitprice,
    this.standeruom,
    this.flagdeleted,
    this.endeffdt,
    this.minproductstockingodown,
    this.minproductstockinbaseingodown,
    this.minproductstockinshowroom,
    this.minproductstockinbaseinshowroom,
    this.sortorder,
    this.hsncode,
    this.cgstrate,
    this.sgstrate,
    this.igstrate,
    this.imageUrl,
  });

  int productid;
  String productName;
  int categoryid;
  String categoryName;
  String subCategoryName;
  String code;
  int subcategoryid;
  String description;
  int unitprice;
  int standeruom;
  bool flagdeleted;
  DateTime endeffdt;
  int minproductstockingodown;
  int minproductstockinbaseingodown;
  int minproductstockinshowroom;
  int minproductstockinbaseinshowroom;
  int sortorder;
  String hsncode;
  double cgstrate;
  double sgstrate;
  int igstrate;
  dynamic imageUrl;

  factory ResGetItemList.fromJson(Map<String, dynamic> json) => ResGetItemList(
    productid: json["productid"],
    productName: json["ProductName"],
    categoryid: json["Categoryid"],
    categoryName: json["CategoryName"],
    subCategoryName: json["SubCategoryName"],
    code: json["code"],
    subcategoryid: json["Subcategoryid"],
    description: json["description"],
    unitprice: json["unitprice"],
    standeruom: json["standeruom"],
    flagdeleted: json["flagdeleted"],
    endeffdt: DateTime.parse(json["endeffdt"]),
    minproductstockingodown: json["minproductstockingodown"],
    minproductstockinbaseingodown: json["minproductstockinbaseingodown"],
    minproductstockinshowroom: json["minproductstockinshowroom"],
    minproductstockinbaseinshowroom: json["minproductstockinbaseinshowroom"],
    sortorder: json["sortorder"],
    hsncode: json["hsncode"],
    cgstrate: json["cgstrate"],
    sgstrate: json["sgstrate"],
    igstrate: json["igstrate"],
    imageUrl: json["ImageURL"],
  );

  Map<String, dynamic> toJson() => {
    "productid": productid,
    "ProductName": productName,
    "Categoryid": categoryid,
    "CategoryName": categoryName,
    "SubCategoryName": subCategoryName,
    "code": code,
    "Subcategoryid": subcategoryid,
    "description": description,
    "unitprice": unitprice,
    "standeruom": standeruom,
    "flagdeleted": flagdeleted,
    "endeffdt": endeffdt.toIso8601String(),
    "minproductstockingodown": minproductstockingodown,
    "minproductstockinbaseingodown": minproductstockinbaseingodown,
    "minproductstockinshowroom": minproductstockinshowroom,
    "minproductstockinbaseinshowroom": minproductstockinbaseinshowroom,
    "sortorder": sortorder,
    "hsncode": hsncode,
    "cgstrate": cgstrate,
    "sgstrate": sgstrate,
    "igstrate": igstrate,
    "ImageURL": imageUrl,
  };
}
