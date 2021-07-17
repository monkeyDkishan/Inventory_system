
class ResGetTotalOutStanding {
  ResGetTotalOutStanding({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  ResGetTotalOutStandingData data;

  factory ResGetTotalOutStanding.fromJson(Map<String, dynamic> json) => ResGetTotalOutStanding(
    status: json["Status"],
    message: json["Message"],
    data: ResGetTotalOutStandingData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "data": data.toJson(),
  };
}

class ResGetTotalOutStandingData {
  ResGetTotalOutStandingData({
    this.totalOutStanding,
  });

  double totalOutStanding;

  factory ResGetTotalOutStandingData.fromJson(Map<String, dynamic> json) => ResGetTotalOutStandingData(
    totalOutStanding: json["TotalOutStanding"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "TotalOutStanding": totalOutStanding,
  };
}
