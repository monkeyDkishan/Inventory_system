class ReqUpdateFcmToken {
  final String fcmToken;

  ReqUpdateFcmToken({this.fcmToken});

  Map<String, String> toJson() => {
    "FcmToken": fcmToken
  };
}