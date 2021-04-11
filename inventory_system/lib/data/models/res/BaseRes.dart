class BaseRes{
  BaseRes({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  dynamic data;

  factory BaseRes.fromJson(Map<String, dynamic> json) => BaseRes(
    status: json["Status"],
    message: json["Message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "data": data,
  };
}
