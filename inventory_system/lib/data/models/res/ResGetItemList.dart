
class ResGetItem {
  ResGetItem({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  ResGetItemData data;

  factory ResGetItem.fromJson(Map<String, dynamic> json) {

    if (json["data"] == null){
      return ResGetItem(
        status: json["Status"],
        message: json["Message"],
      );
    }
    return ResGetItem(
      status: json["Status"],
      message: json["Message"],
      data: ResGetItemData.fromJson(json["data"]),
    );
    }

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
    this.standeruom,
    this.unitname,
    this.unitmaster,
    // this.flagdeleted,
    // this.endeffdt,
    // this.minproductstockingodown,
    // this.minproductstockinbaseingodown,
    // this.minproductstockinshowroom,
    // this.minproductstockinbaseinshowroom,
    // this.sortorder,
    // this.hsncode,
    // this.cgstrate,
    // this.sgstrate,
    // this.igstrate,
    this.imageList,
    this.selectedUnitIndex,
    this.quantity,
    this.notes,
    this.selectedUnitMaster,
    this.isProductAvailbleinStock
  });

  int productid;
  String productName;
  int categoryid;
  String categoryName;
  String subCategoryName;
  String code;
  int subcategoryid;
  String description;
  int standeruom;
  String unitname;
  List<Unitmaster> unitmaster;
  // bool flagdeleted;
  // DateTime endeffdt;
  // double minproductstockingodown;
  // double minproductstockinbaseingodown;
  // double minproductstockinshowroom;
  // double minproductstockinbaseinshowroom;
  // int sortorder;
  // String hsncode;
  // double cgstrate;
  // double sgstrate;
  // int igstrate;
  List<ImageList> imageList;
  int selectedUnitIndex;
  int quantity;
  String notes;
  Unitmaster selectedUnitMaster;
  bool isProductAvailbleinStock;

  factory ResGetItemList.fromJson(Map<String, dynamic> json) => ResGetItemList(
    productid: json["productid"],
    productName: json["ProductName"],
    categoryid: json["Categoryid"],
    categoryName: json["CategoryName"],
    subCategoryName: json["SubCategoryName"],
    code: json["code"],
    subcategoryid: json["Subcategoryid"],
    description: json["description"],
    standeruom: json["standeruom"],
    unitname: json["unitname"],
    unitmaster: List<Unitmaster>.from(json["unitmaster"].map((x) => Unitmaster.fromJson(x))),
    // flagdeleted: json["flagdeleted"],
    // endeffdt: DateTime.parse(json["endeffdt"]),
    // minproductstockingodown: json["minproductstockingodown"],
    // minproductstockinbaseingodown: json["minproductstockinbaseingodown"].toDouble(),
    // minproductstockinshowroom: json["minproductstockinshowroom"],
    // minproductstockinbaseinshowroom: json["minproductstockinbaseinshowroom"].toDouble(),
    // sortorder: json["sortorder"],
    // hsncode: json["hsncode"],
    // cgstrate: json["cgstrate"].toDouble(),
    // sgstrate: json["sgstrate"].toDouble(),
    // igstrate: json["igstrate"],
    imageList: List<ImageList>.from(json["image_list"].map((x) => ImageList.fromJson(x))),
    selectedUnitIndex: json["selectedUnitIndex"],
    quantity: json["quantity"],
    notes: json["notes"],
    selectedUnitMaster: json["selectedUnitMaster"],
    isProductAvailbleinStock: json["isProductAvailbleinStock"],
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
    "standeruom": standeruom,
    "unitname": unitname,
    "unitmaster": List<dynamic>.from(unitmaster.map((x) => x.toJson())),
    // "flagdeleted": flagdeleted,
    // "endeffdt": endeffdt.toIso8601String(),
    // "minproductstockingodown": minproductstockingodown,
    // "minproductstockinbaseingodown": minproductstockinbaseingodown,
    // "minproductstockinshowroom": minproductstockinshowroom,
    // "minproductstockinbaseinshowroom": minproductstockinbaseinshowroom,
    // "sortorder": sortorder,
    // "hsncode": hsncode,
    // "cgstrate": cgstrate,
    // "sgstrate": sgstrate,
    // "igstrate": igstrate,
    "image_list": List<dynamic>.from(imageList.map((x) => x.toJson())),
    "selectedUnitIndex": selectedUnitIndex,
    "quantity": quantity,
    "notes": notes,
    "selectedUnitMaster": selectedUnitMaster,
    "isProductAvailbleinStock":isProductAvailbleinStock,
  };
}

class ImageList {
  ImageList({
    this.imageUrl,
  });

  String imageUrl;

  factory ImageList.fromJson(Map<String, dynamic> json) => ImageList(
    imageUrl: json["ImageURL"],
  );

  Map<String, dynamic> toJson() => {
    "ImageURL": imageUrl,
  };
}

class Unitmaster {
  Unitmaster({
    this.unitmasterid,
    this.unitname,
    this.unitPrize,
  });

  int unitmasterid;
  String unitname;
  double unitPrize;

  factory Unitmaster.fromJson(Map<String, dynamic> json) => Unitmaster(
    unitmasterid: json["unitmasterid"],
    unitname: json["unitname"],
    unitPrize: json["UnitPrize"]
  );

  Map<String, dynamic> toJson() => {
    "unitmasterid": unitmasterid,
    "unitname": unitname,
    "UnitPrize": unitPrize,
  };
}