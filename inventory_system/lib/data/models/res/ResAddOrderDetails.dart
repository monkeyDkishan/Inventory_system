
class ResAddOrderDetails {
  ResAddOrderDetails({
    this.status,
    this.message,
    // this.data,
  });

  int status;
  String message;
  // String data;

  factory ResAddOrderDetails.fromJson(Map<String, dynamic> json) => ResAddOrderDetails(
    status: json["Status"],
    message: json["Message"],
    // data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    // "data": data,
  };
}
