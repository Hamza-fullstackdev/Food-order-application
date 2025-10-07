import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:frontend/App2/Data/Network/Services/token_refresh.dart';
import 'package:frontend/App2/Data/Network/interfaces/get_request_interface.dart';
import 'package:frontend/App2/Data/api_exceptions.dart';
import 'package:http/http.dart' as http;

class ApiRequestService implements ApiRequestInterface {
  @override
  Future<dynamic> getDataRequest(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final accessToken = await TokenRefresh.tokenValidation();
      final myHeader = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      };
      final response = await http
          .get(Uri.parse(url), headers: myHeader)
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 400) {
        final decoded = jsonDecode(response.body);
        return decoded;
      } else if (response.statusCode == 401) {
        throw ServerException("Unauthorized! Token expired or invalid");
      } else {
        throw ServerException("Status: ${response.statusCode}");
      }
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }

  @override
  Future<dynamic> postDataService(String url, Map<String, dynamic> body) async {
    try {
      final accessToken = await TokenRefresh.tokenValidation();
      final myHeader = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      };

      final response = await http
          .post(Uri.parse(url), headers: myHeader, body: jsonEncode(body))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 400) {
        final decoded = jsonDecode(response.body);

        return decoded;
      } else if (response.statusCode == 401) {
        throw ServerException("Unauthorized! Token expired or invalid");
      } else {
        throw ServerException("Status: ${response.statusCode}");
      }
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }
}
