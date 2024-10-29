import 'package:pocketbase/pocketbase.dart';

class ApiResponse {
  final int code;
  final String message;
  final ApiData? data;
  final bool success;

  ApiResponse({
    required this.code,
    required this.message,
    this.data,
    this.success = false,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    final int code = json['code'];
    return ApiResponse(
      code: code,
      message: json['message'],
      data: json['data'] != null ? ApiData.fromJson(json['data']) : null,
      success: code == 200,
    );
  }

  factory ApiResponse.defaultError() => ApiResponse(
        code: 500,
        message: 'Unknown error occurred. Please try again later.',
      );

  factory ApiResponse.fromError(dynamic error) {
    return ApiResponse(
      code: 500,
      message: error.toString(),
    );
  }

  factory ApiResponse.customMessage(String message) =>
      ApiResponse(code: 200, message: message, success: true);

  factory ApiResponse.fromClientException(ClientException error) {
    final data = ApiData.fromJson(error.response);
    return ApiResponse(
      code: data.code,
      message: data.message,
      data: data,
      success: false,
    );
  }
}

class ApiData {
  final int code;
  final String message;

  ApiData({
    required this.code,
    required this.message,
  });

  factory ApiData.fromJson(Map<String, dynamic> json) {
    return ApiData(
      code: json['code'],
      message: json['message'],
    );
  }
}
