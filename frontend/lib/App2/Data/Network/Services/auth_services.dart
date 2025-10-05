import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:frontend/App2/Data/Network/interfaces/auth_interfaces.dart';
import 'package:frontend/App2/Data/api_exceptions.dart';
import 'package:http/http.dart' as http;

class AuthServices implements AuthInterfaces {
  @override
  Future<Map<String, dynamic>> loginUser(
    String email,
    String password,
    String url,
  ) async {
    try {
      final uri = Uri.parse(url);
      
      final header = {"Content-Type": "application/json"};
      final body = {"email": email, "password": password};

      final response = await http
          .post(uri, headers: header, body: jsonEncode(body))
          .timeout(Duration(seconds: 10));

        final decode = jsonDecode(response.body);
        return decode is Map<String, dynamic>
            ? decode
            : {"statusCode": response.statusCode, "body": decode};

    } on SocketException catch (e) {
      throw InternetException(e.toString());
    } on TimeoutException catch (e) {
      throw RequestTimeOut(e.toString());
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> registerUser(
    String name,
    String email,
    String password,
    String url,
  ) async {
    try {
      print("AuthServices starts now in try block before api call");

      final uri = Uri.parse(url);
      final header = {"Content-Type": "application/json"};
      final body = {"name": name, "email": email, "password": password};
      final response = await http
          .post(uri, headers: header, body: jsonEncode(body))
          .timeout(Duration(seconds: 10));

        final decode = jsonDecode(response.body);
        return decode is Map<String, dynamic>
            ? decode
            : {'statusCode': response.statusCode, 'body': decode};
     
    } on SocketException {
      print("SocketException with exception ");
      throw InternetException();
    } on TimeoutException {
      print("TimeoutException with exception ");

      throw RequestTimeOut();
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }
}
