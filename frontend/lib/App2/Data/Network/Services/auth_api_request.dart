import 'dart:convert';
import 'dart:io';

import 'package:frontend/App/Core/Exceptions/exceptions.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';
import 'package:http/http.dart' as http;

class AuthApiRequest {
  Future<Map<String,dynamic>> getApiServices(
    String url,
    Map<String, dynamic> body,
  ) async {
    print("Reached at Auth api resquest");

      final header = {"Content-Type": "application/json"};

    try {
    final response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      
    print("Reached at Auth api resquest success");
      final data = jsonDecode(response.body);
      return data is Map<String,dynamic> ? data : {'statusCode': response.statusCode , 'body': data} ;
    }else {
      throw ServerException('Status Code:${response.statusCode}');
    }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } catch (e) {
      throw FetchDataException("Unexpected error: $e");
    }
  }

  Future<ApiResponse> postApiServices(String url,Map<String,dynamic> body) async {
    try {
      
      final header = {"Content-Type": "application/json"};
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: body
      ).timeout(Duration(seconds: 10));

      return ApiResponse.success(response);
    }  on InternetException catch (e) {
      return ApiResponse.error(e.toString());
    } on RequestTimeOut catch (e) {
      return ApiResponse.error(e.toString());
    } on ServerException catch (e) {
      return ApiResponse.error(e.toString());
    } on FetchDataException catch (e) {
      return ApiResponse.error(e.toString());
    } catch (e) {
      return ApiResponse.error("Something went wrong: $e");
    }
  }
}
