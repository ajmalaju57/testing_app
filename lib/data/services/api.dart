// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_eco/data/services/urls.dart';
import 'package:test_eco/utils/shared/helper_loader.dart';

import 'api_response.dart';

enum Method { get, post, put, delete }

class Api {
  static const _headers = {'Content-Type': 'application/json'};

  static Future<ApiResponse> call(BuildContext context,
      {required String endPoint, required Method method, Object? body}) async {
    try {
      final http.Response response;

      //REST API METHOD
      switch (method) {
        case Method.get:
          String url = baseUrl + endPoint;
          response = await http.get(Uri.parse(url), headers: _headers);
          debugPrint("${baseUrl + endPoint} ($method)\n$body");
          debugPrint(response.body);
          return ApiResponse.fromJson(response.statusCode, response.body);

        case Method.post:
          response = await http.post(Uri.parse(baseUrl + endPoint),
              body: json.encode(body), headers: _headers);
          debugPrint("${baseUrl + endPoint} ($method)\n$body");
          debugPrint(response.body);
          return ApiResponse.fromJson(response.statusCode, response.body);

        case Method.put:
          response = await http.put(Uri.parse(baseUrl + endPoint),
              body: json.encode(body), headers: _headers);
          debugPrint("${baseUrl + endPoint} ($method)\n$body");
          debugPrint(response.body);
          return ApiResponse.fromJson(response.statusCode, response.body);
        case Method.delete:
          response = await http.delete(Uri.parse(baseUrl + endPoint),
              body: json.encode(body), headers: _headers);
          debugPrint("${baseUrl + endPoint} ($method)\n$body");
          debugPrint(response.body);
          return ApiResponse.fromJson(response.statusCode, response.body);

        default:
          return throw "INVALID METHOD";
      }
    } on SocketException {
      debugPrint("${baseUrl + endPoint} ($method)\n$body");
      hideLoader(context);
      // snackBar(context, message: "Network seems to be offline");
      return ApiResponse.fromJson(
          500, "{message:'Network seems to be offline'}");
    } catch (e) {
      debugPrint(
          "${baseUrl + endPoint} ($method) ${body != null ? '\n$body' : ''}");
      hideLoader(context);
      // snackBar(context, message: e.toString());
      debugPrint("$e");
      return ApiResponse.fromJson(500, "{message:'$e'}");
    }
  }
}
