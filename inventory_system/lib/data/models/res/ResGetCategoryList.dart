
class ResGetCategory {
  ResGetCategory({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  ResGetCategoryData data;

  factory ResGetCategory.fromJson(Map<String, dynamic> json) => ResGetCategory(
    status: json["Status"],
    message: json["Message"],
    data: ResGetCategoryData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "data": data.toJson(),
  };
}

class ResGetCategoryData {
  ResGetCategoryData({
    this.totalRecords,
    this.pageSize,
    this.currentPage,
    this.list,
  });

  int totalRecords;
  int pageSize;
  int currentPage;
  List<ResGetCategoryList> list;

  factory ResGetCategoryData.fromJson(Map<String, dynamic> json) => ResGetCategoryData(
    totalRecords: json["TotalRecords"],
    pageSize: json["PageSize"],
    currentPage: json["CurrentPage"],
    list: List<ResGetCategoryList>.from(json["list"].map((x) => ResGetCategoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TotalRecords": totalRecords,
    "PageSize": pageSize,
    "CurrentPage": currentPage,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ResGetCategoryList {
  ResGetCategoryList({
    this.categoryid,
    this.subcategoryid,
    this.name,
    this.flagdeleted,
    this.endeffdt,
    this.categorylevel,
    this.sortorder,
    this.productid,
    this.imageUrl,
    this.categoryName,
    this.subCategoryName,
  });

  int categoryid;
  int subcategoryid;
  String name;
  bool flagdeleted;
  DateTime endeffdt;
  int categorylevel;
  int sortorder;
  int productid;
  dynamic imageUrl;
  String categoryName;
  String subCategoryName;

  factory ResGetCategoryList.fromJson(Map<String, dynamic> json) => ResGetCategoryList(
    categoryid: json["Categoryid"],
    subcategoryid: json["subcategoryid"],
    name: json["name"],
    flagdeleted: json["flagdeleted"],
    endeffdt: DateTime.parse(json["endeffdt"]),
    categorylevel: json["categorylevel"],
    sortorder: json["sortorder"],
    productid: json["productid"],
    imageUrl: json["ImageURL"],
    categoryName: json["CategoryName"],
    subCategoryName: json["SubCategoryName"],
  );

  Map<String, dynamic> toJson() => {
    "Categoryid": categoryid,
    "subcategoryid": subcategoryid,
    "name": name,
    "flagdeleted": flagdeleted,
    "endeffdt": endeffdt.toIso8601String(),
    "categorylevel": categorylevel,
    "sortorder": sortorder,
    "productid": productid,
    "ImageURL": imageUrl,
    "CategoryName": categoryName,
    "SubCategoryName": subCategoryName,
  };
}
