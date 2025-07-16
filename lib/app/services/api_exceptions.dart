import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String url;
  final String message;
  final int? statusCode;
  final Response? response;

  ApiException({
    required this.url,
    required this.message,
    this.response,
    this.statusCode,
  });

  /// IMPORTANT NOTE
  /// here you can take advantage of toString() method to display the error for user
  /// lets make an example
  /// so in onError method when you make api you can just use apiExceptionInstance.toString() to get the error message from api
  @override
  String toString() {
    String result = '';

    final error = response?.data?['error'];
    if (error != null) {
      if (error is String) {
        result += error;
      } else if (error is Map && error.containsKey('message')) {
        result += error['message'].toString();
      } else {
        result += error.toString();
      }
    }

    if (result.isEmpty) {
      result += message; // fallback
    }

    return result;
  }

}