class ReqIsValidOTP {
  final String mobileNo;
  final String otp;

  ReqIsValidOTP({this.mobileNo, this.otp});

  Map<String, String> toJson() => {
    "MobileNo": mobileNo,
    "OTP": otp,
  };
}