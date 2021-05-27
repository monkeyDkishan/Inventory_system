class ResGetInvoice {
  ResGetInvoice({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  ResGetInvoiceData data;

  factory ResGetInvoice.fromJson(Map<String, dynamic> json) {
    if(json["data"] == null){
      return ResGetInvoice(
        status: json["Status"],
        message: json["Message"]
      );
    }
    return ResGetInvoice(
      status: json["Status"],
      message: json["Message"],
      data: ResGetInvoiceData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "data": data.toJson(),
      };
}

class ResGetInvoiceData {
  ResGetInvoiceData({
    this.totalRecords,
    this.pageSize,
    this.currentPage,
    this.list,
  });

  int totalRecords;
  int pageSize;
  int currentPage;
  List<ResGetInvoiceList> list;

  factory ResGetInvoiceData.fromJson(Map<String, dynamic> json) =>
      ResGetInvoiceData(
        totalRecords: json["TotalRecords"],
        pageSize: json["PageSize"],
        currentPage: json["CurrentPage"],
        list: List<ResGetInvoiceList>.from(
            json["list"].map((x) => ResGetInvoiceList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TotalRecords": totalRecords,
        "PageSize": pageSize,
        "CurrentPage": currentPage,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ResGetInvoiceList {
  ResGetInvoiceList({
    this.ordermasterid,
    this.partyid,
    this.billnumber,
    this.orderid,
    this.billrefrencenumber,
    this.partyname,
    this.phone,
    this.locationname,
    this.orderdate,
    this.orderdateforsort,
    this.totaldays,
    this.duedate,
    this.duedateforsort,
    this.totalpayableinstr,
    this.totalpayableindecimal,
    this.isamountpaid,
    this.paidamountinstr,
    this.unpaidamountinstr,
    this.unpaidamountindecimal,
    this.paidamountindecimal,
  });

  int ordermasterid;
  int partyid;
  int billnumber;
  int orderid;
  dynamic billrefrencenumber;
  String partyname;
  String phone;
  String locationname;
  String orderdate;
  DateTime orderdateforsort;
  int totaldays;
  String duedate;
  DateTime duedateforsort;
  String totalpayableinstr;
  double totalpayableindecimal;
  bool isamountpaid;
  String paidamountinstr;
  String unpaidamountinstr;
  double unpaidamountindecimal;
  double paidamountindecimal;

  factory ResGetInvoiceList.fromJson(Map<String, dynamic> json) =>
      ResGetInvoiceList(
        ordermasterid: json["ordermasterid"],
        partyid: json["partyid"],
        billnumber: json["billnumber"],
        orderid: json["orderid"],
        billrefrencenumber: json["billrefrencenumber"],
        partyname: json["partyname"],
        phone: json["phone"],
        locationname: json["locationname"],
        orderdate: json["orderdate"],
        orderdateforsort: DateTime.parse(json["orderdateforsort"]),
        totaldays: json["totaldays"],
        duedate: json["duedate"],
        duedateforsort: DateTime.parse(json["duedateforsort"]),
        totalpayableinstr: json["totalpayableinstr"],
        totalpayableindecimal: json["totalpayableindecimal"],
        isamountpaid: json["isamountpaid"],
        paidamountinstr: json["paidamountinstr"],
        unpaidamountinstr: json["unpaidamountinstr"],
        unpaidamountindecimal: json["unpaidamountindecimal"],
        paidamountindecimal: json["paidamountindecimal"],
      );

  Map<String, dynamic> toJson() => {
        "ordermasterid": ordermasterid,
        "partyid": partyid,
        "billnumber": billnumber,
        "orderid": orderid,
        "billrefrencenumber": billrefrencenumber,
        "partyname": partyname,
        "phone": phone,
        "locationname": locationname,
        "orderdate": orderdate,
        "orderdateforsort": orderdateforsort.toIso8601String(),
        "totaldays": totaldays,
        "duedate": duedate,
        "duedateforsort": duedateforsort.toIso8601String(),
        "totalpayableinstr": totalpayableinstr,
        "totalpayableindecimal": totalpayableindecimal,
        "isamountpaid": isamountpaid,
        "paidamountinstr": paidamountinstr,
        "unpaidamountinstr": unpaidamountinstr,
        "unpaidamountindecimal": unpaidamountindecimal,
        "paidamountindecimal": paidamountindecimal,
      };
}

