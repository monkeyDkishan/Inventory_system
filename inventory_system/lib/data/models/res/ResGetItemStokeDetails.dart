
class ResGetItemStokeDetails {
  ResGetItemStokeDetails({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory ResGetItemStokeDetails.fromJson(Map<String, dynamic> json) {

    if (json["data"] == null){
      return ResGetItemStokeDetails(
        status: json["Status"],
        message: json["Message"]
      );
    }

    return ResGetItemStokeDetails(
      status: json["Status"],
      message: json["Message"],
      data: Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.availbleStock,
  });

  double availbleStock;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    availbleStock: json["AvailbleStock"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "AvailbleStock": availbleStock,
  };
}
