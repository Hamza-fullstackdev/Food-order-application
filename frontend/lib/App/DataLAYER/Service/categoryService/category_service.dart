import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:frontend/App/Core/Exceptions/exceptions.dart';
import 'package:frontend/App/DataLAYER/repository/authRepo/authRepo.dart';
import 'package:frontend/App2/Resources/app_url.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  CategoryService._private();
  static CategoryService instance = CategoryService._private();
  factory CategoryService() {
    return instance;
  }
  final _authRepo = AuthRepoo();

  Future getAllCategories(String url) async {
    try {
      // final tokenRes = await _authRepo.getValidAccessToken();
      // if (tokenRes.status != Status.SUCCESS || tokenRes.data == null) {
      //   throw Exception("Token not available: ${tokenRes.message}");
      // }

      // final token =     tokenRes.data;

      final token = AppStrings.token;
      // final token =
      //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGQyOTFhYjYwNjExNjMzNzg2NzlhOTYiLCJpYXQiOjE3NTkzODYxNjIsImV4cCI6MTc1OTM4NzA2Mn0.MA_b6JD6E-h77k2gqGqpYYuqUVxVmf-lJ_amoH6LybI';

      final responce = await http
          .get(
            Uri.parse(url),

            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
          )
          .timeout(const Duration(seconds: 10));

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        return jsonDecode(responce.body);
      } else if (responce.statusCode == 401) {
        throw ServerException("Unauthorized! Token expired or invalid");
      } else {
        throw ServerException("Status: ${responce.statusCode}");
      }
    } on SocketException {
      throw InternetException('');
    } on TimeoutException {
      throw RequestTimeOut('');
    } on FormatException {
      throw FetchDataException("Invalid JSON format received");
    } catch (e) {
      throw FetchDataException("Unexpected error: $e");
    }
  }
}
