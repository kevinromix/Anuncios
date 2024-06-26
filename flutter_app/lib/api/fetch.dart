import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/models/response_data.dart';
import 'package:http/http.dart' as http;

Future<ResponseData> fetch({
  required String method,
  required String path,
  String page = '1',
  final Map<String, dynamic>? body,
}) async {
  ResponseData responseData = ResponseData();
  String hostIp = "127.0.0.1";
  hostIp =
      "192.168.1.22"; //Use PC IP Network, just in case localhost does not work in mobile test

  final Uri url = Uri(
    scheme: 'http',
    host: hostIp,
    port: 3000,
    path: path,
    queryParameters: {'page': page},
  );

  try {
    http.Response response;
    switch (method) {
      // GET Method
      case "get":
        response = await http.get(url);
        break;

      // POST Method
      case "post":
        response = await http.post(
          url,
          body: json.encode(body),
          encoding: utf8,
          headers: {
            'Content-Type': 'application/json',
          },
        );
        break;

      default:
        response = http.Response("", 500);
        break;
    }
    dynamic jsonResponse = await jsonDecode(response.body);
    switch (response.statusCode) {
      // Code: 200
      case 200:
        responseData.data = jsonResponse;
        responseData.hasError = false;
        break;

      // Code: 500
      case 500:
        responseData.message = jsonResponse['message'];
        break;
    }
  } on SocketException catch (er) {
    responseData.isConnected = false;
    responseData.message = er.toString();
  } catch (e) {
    responseData.message = e.toString();
  }

  return responseData;
}
