import 'dart:convert';

class ApiResponse<T> {
  bool status;
  String message;
  T data;

  ApiResponse({required this.status, required this.message, required this.data});

  factory ApiResponse.fromJson(int status, String body) {
    final map = json.decode(body);
    return ApiResponse<T>(
      status: status == 200 || status == 201,
      message: map["message"] ?? "",
      data: map["data"],
    );
  }
}
