import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:inttask/app/constants/api_constants.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<dynamic> get(String url) async {
    try {
      final response = await _client
          .get(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          )
          .timeout(ApiConstants.connectionTimeout);

      return _handleResponse(response);
    } on TimeoutException {
      throw const ApiException('Request timed out. Please try again.');
    } on SocketException {
      throw const ApiException(
        'Unable to connect. Please check your internet connection.',
      );
    } on HttpException {
      throw const ApiException('Network error occurred. Please try again.');
    } on FormatException {
      throw const ApiException('Invalid response format from server.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('An unexpected error occurred: $e');
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == ApiConstants.successCode) {
      if (response.body.isEmpty) {
        throw const ApiException('No data received from the server.');
      }
      try {
        return json.decode(response.body);
      } catch (_) {
        throw const ApiException('Failed to parse server response.');
      }
    }

    throw ApiException(
      'Server error (${response.statusCode}). Please try again.',
      statusCode: response.statusCode,
    );
  }

  void dispose() {
    _client.close();
  }
}
