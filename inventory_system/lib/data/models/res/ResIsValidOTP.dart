import 'dart:convert';

class ResIsValidOTP {
  ResIsValidOTP({
    this.status,
    this.message,
    this.data,
    this.res
  });

  int status;
  String message;
  ResIsValidOTPData data;
  String res;

  factory ResIsValidOTP.fromJson(Map<String, dynamic> json) {

    if (json["data"] != null){
      return ResIsValidOTP(
        status: json["Status"],
        message: json["Message"],
        data: ResIsValidOTPData.fromJson(json["data"]),
      );
    }else{
      return ResIsValidOTP(
        status: json["Status"],
        message: json["Message"],
        res: json["Response"]
      );
    }
  }

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "data": data.toJson(),
  };
}

class ResIsValidOTPData {
  ResIsValidOTPData({
    this.accesstoken,
    this.tokenType,
  });

  String accesstoken;
  String tokenType;

  factory ResIsValidOTPData.fromJson(Map<String, dynamic> json) => ResIsValidOTPData(
    accesstoken: json["Accesstoken"],
    tokenType: json["Token_type"],
  );

  Map<String, dynamic> toJson() => {
    "Accesstoken": accesstoken,
    "Token_type": tokenType,
  };
}
