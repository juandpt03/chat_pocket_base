import 'package:pocketbase/pocketbase.dart';

class ApiResponse {
  final int code;
  final String message;
  final ApiData? data;

  ApiResponse({
    required this.code,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'],
      message: json['message'],
      data: json['data'] != null ? ApiData.fromJson(json['data']) : null,
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

  factory ApiResponse.fromClientException(ClientException error) {
    final data = ApiData.fromJson(error.response);

    return ApiResponse(code: data.code, message: data.message, data: data);
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
