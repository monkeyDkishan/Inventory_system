
class ResGetTotalOutStanding {
  ResGetTotalOutStanding({
    this.status,
    this.message,
    this.totalOutStanding,
    this.data,
  });

  int status;
  String message;
  int totalOutStanding;
  String data;

  factory ResGetTotalOutStanding.fromJson(Map<String, dynamic> json) => ResGetTotalOutStanding(
    status: json["Status"],
    message: json["Message"],
    totalOutStanding: json["TotalOutStanding"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "TotalOutStanding": totalOutStanding,
    "data": data,
  };
}
