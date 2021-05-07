import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_system/Utilities/constants.dart';
import 'package:inventory_system/services/userPreferencesService.dart';


class WebService {

  Future<dynamic> getApiWithQuery(String path, Map<String, String> body) async {
    var responseJson;
    try {
      var user = await UserPreferencesService().getUser();

      var uri =
      Uri.http(kBaseDomain, '$kBasePath$path/', body);

      print('URL: $uri');
      print('Header: ${user.token}');

      final response = await http.get(
        uri,
        headers: {
          "Authorization": '${user.token}'
        },
      );

      responseJson = _returnResponse(response);
    } on SocketException {
      print("error 0 is: ");
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> getApi(String path) async {
    var responseJson;
    try {
      var user = await UserPreferencesService().getUser();

      var uri = Uri.parse(kBaseUrl + path);

      print('URL: $uri');
      print('Header: ${user.token}');

      final response = await http.get(
        uri,
        headers: {
          "Authorization": '${user.token}'
        },
      );

      responseJson = _returnResponse(response);
    } on SocketException {
      print("error 0 is: ");
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> postApi(String path, Map<String, dynamic> body) async {
    var responseJson;
    try {
      var user = await UserPreferencesService().getUser();

      var uri = Uri.parse(kBaseUrl + path);

      print('URL: $uri, Req: $body');
      print('Header: ${user.token}');

      print(jsonEncode(body));

      final response = await http.post(
          uri,
          body: jsonEncode(body),
          headers: {
            "Authorization": '${user.token}',
            "Content-Type":"application/json"
          }
      );

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> uploadImage(
      {filepath, path, Map<String, String> body,String imgName}) async {
    print(path);

    var responseJson;

    try {
      var user = await UserPreferencesService().getUser();

      var request = http.MultipartRequest('POST', Uri.parse(kBaseUrl + path));

      if (filepath != null) {
        request.files.add(http.MultipartFile.fromBytes(
          imgName,
          File(filepath).readAsBytesSync(),
          filename: filepath.split("/").last,
        ));
      }

      request.headers.addAll({
        "Authorization": '${user.token}'
      });

      request.fields.addAll(body);

      print('body: $body');

      print(request);

      http.Response response =
      await http.Response.fromStream(await request.send());

      responseJson = _returnResponse(response);
    } on SocketException {
      print("error 0 is: ");
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    print('Response: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      var responseJson = jsonDecode(response.body);
      return responseJson;
    }

    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw 'Error occured while Communication with Server with StatusCode : ${response.statusCode}';
    }
  }
}

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}

class ApiResponse<T> {
   Status state;
   T data;
   String msg;

  ApiResponse();

  ApiResponse.loading(this.msg) : state = Status.LOADING;

  ApiResponse.completed(this.data) : state = Status.COMPLETED;

  ApiResponse.error(this.msg) : state = Status.ERROR;

  @override
  String toString() {
    return "Status : $state \n Message : $msg \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
