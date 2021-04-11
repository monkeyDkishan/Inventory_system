class ReqIsValidMobile {
  final String mobileNo;

  ReqIsValidMobile({this.mobileNo});

  Map<String, String> toJson() => {
    "MobileNo": mobileNo,
  };

}