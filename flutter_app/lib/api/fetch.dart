import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/models/response_data.dart';
import 'package:http/http.dart' as http;

Future<ResponseData> fetch({
  required String method,
  required String path,
  final Map<String, dynamic>? body,
}) async {
  ResponseData responseData = ResponseData();

  final Uri url = Uri(
    scheme: 'http',
    host: "127.0.0.1",
    port: 3000,
    path: path,
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
        );
        break;

      default:
        response = http.Response("", 500);
        break;
    }
    dynamic jsonResponse = jsonDecode(response.body);
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
