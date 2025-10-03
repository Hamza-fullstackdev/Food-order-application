// import 'dart:convert';

// import 'package:frontend/App/Core/Exceptions/exceptions.dart';
// import 'package:frontend/App2/Resources/app_url.dart';
// import 'package:http/http.dart' as http;
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'dart:io';

// import 'package:shared_preferences/shared_preferences.dart';

// class ApiClient {
//   ApiClient._private();
//   static  final ApiClient _instance = ApiClient._private();
//   factory ApiClient() {
//     return _instance;
//   }
//   final http.Client _client = http.Client();
//   Future<String?> _refreshAccessToken(String refreshToken) async {
//     try {
//       final response = await _client.post(
//         Uri.parse(AppUrl.refresh_url),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"refreshToken": refreshToken}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final newAccessToken = data["user"]["accessToken"];

//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString("accessToken", newAccessToken);

//         return newAccessToken;
//       } else {
//         throw ServerException("Refresh failed: ${response.statusCode}");
//       }
//     } catch (e) {
//       throw FetchDataException("Error refreshing token: $e");
//     }
//   }
//   Future<String?> getValidAccessToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? accessToken = prefs.getString("accessToken");
//     String? refreshToken = prefs.getString("refreshToken");

//     if (accessToken == null || refreshToken == null) {
//       throw FetchDataException("No tokens found, please login again.");
//     }

//     bool isExpired = JwtDecoder.isExpired(accessToken);

//     if (!isExpired) {
//       return accessToken;
//     } else {
//       return await _refreshAccessToken(refreshToken);
//     }
//   }

//    Future<http.Response> post(String url, {Map<String, dynamic>? body}) async {
    
//       final response = await _client.post(
//         Uri.parse(url),
//         headers: {
//           "Content-Type": "application/json",
        
//         },
//         body: body != null ? jsonEncode(body) : null,
//       ).timeout(const Duration(seconds: 10));

//       return response;
    
//   }


  
// }

 /* 
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/App/Core/Exceptions/exceptions.dart';

// Centralized API Client with Connection Pooling
class ApiClient {
  ApiClient._private();
  static final ApiClient _instance = ApiClient._private();
  factory ApiClient() => _instance;

  // Single HTTP client for connection reuse (pooling)
  final http.Client _client = http.Client();
  // final String baseUrl = "http://192.168.1.110:5000/api/v1";
  
  // Get valid access token (with auto refresh)
  Future<String?> _getValidToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString("accessToken");
      String? refreshToken = prefs.getString("refreshToken");

      if (accessToken == null || refreshToken == null) {
        return null;
      }

      // Check if token is expired
      if (!JwtDecoder.isExpired(accessToken)) {
        return accessToken;
      }

      // Refresh token if expired
      final response = await _client.post(
        Uri.parse("$baseUrl/auth/refresh-token"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"refreshToken": refreshToken}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newAccessToken = data["user"]["accessToken"];
        await prefs.setString("accessToken", newAccessToken);
        return newAccessToken;
      }
      
      return null;
    } catch (e) {
      print("Token refresh error: $e");
      return null;
    }
  }

  // GET Request
  Future<http.Response> get(String endpoint) async {
    try {
      final token = await _getValidToken();
      
      final response = await _client.get(
        Uri.parse("$baseUrl/$endpoint"),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
      ).timeout(const Duration(seconds: 10));

      return response;
    } on SocketException {
      throw InternetException("");
    } on TimeoutException {
      throw RequestTimeOut("");
    } catch (e) {
      throw FetchDataException("GET request failed: $e");
    }
  }

  // POST Request (JSON)
  Future<http.Response> post(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final token = await _getValidToken();
      
      final response = await _client.post(
        Uri.parse("$baseUrl/$endpoint"),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: body != null ? jsonEncode(body) : null,
      ).timeout(const Duration(seconds: 10));

      return response;
    } on SocketException {
      throw InternetException("");
    } on TimeoutException {
      throw RequestTimeOut("");
    } catch (e) {
      throw FetchDataException("POST request failed: $e");
    }
  }

  // MULTIPART POST (for file uploads and form data)
  Future<http.Response> multipartPost(
    String endpoint, {
    Map<String, String>? fields,
    Map<String, File>? files,
  }) async {
    try {
      final token = await _getValidToken();
      
      final uri = Uri.parse("$baseUrl/$endpoint");
      final request = http.MultipartRequest("POST", uri);
      
      // Add authorization header
      if (token != null) {
        request.headers["Authorization"] = "Bearer $token";
      }
      
      // Add fields
      if (fields != null) {
        request.fields.addAll(fields);
      }
      
      // Add files
      if (files != null) {
        for (var entry in files.entries) {
          request.files.add(
            await http.MultipartFile.fromPath(entry.key, entry.value.path),
          );
        }
      }
      
      final streamResponse = await request.send().timeout(const Duration(seconds: 30));
      return await http.Response.fromStream(streamResponse);
      
    } on SocketException {
      throw InternetException("");
    } on TimeoutException {
      throw RequestTimeOut("");
    } catch (e) {
      throw FetchDataException("Multipart POST failed: $e");
    }
  }

  // PUT Request
  Future<http.Response> put(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final token = await _getValidToken();
      
      final response = await _client.put(
        Uri.parse("$baseUrl/$endpoint"),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: body != null ? jsonEncode(body) : null,
      ).timeout(const Duration(seconds: 10));

      return response;
    } on SocketException {
      throw InternetException("");
    } on TimeoutException {
      throw RequestTimeOut("");
    } catch (e) {
      throw FetchDataException("PUT request failed: $e");
    }
  }

  // PATCH Request
  Future<http.Response> patch(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final token = await _getValidToken();
      
      final response = await _client.patch(
        Uri.parse("$baseUrl/$endpoint"),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: body != null ? jsonEncode(body) : null,
      ).timeout(const Duration(seconds: 10));

      return response;
    } on SocketException {
      throw InternetException("");
    } on TimeoutException {
      throw RequestTimeOut("");
    } catch (e) {
      throw FetchDataException("PATCH request failed: $e");
    }
  }

  // DELETE Request
  Future<http.Response> delete(String endpoint) async {
    try {
      final token = await _getValidToken();
      
      final response = await _client.delete(
        Uri.parse("$baseUrl/$endpoint"),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
      ).timeout(const Duration(seconds: 10));

      return response;
    } on SocketException {
      throw InternetException("");
    } on TimeoutException {
      throw RequestTimeOut("");
    } catch (e) {
      throw FetchDataException("DELETE request failed: $e");
    }
  }

  // Clear tokens (for logout)
  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("accessToken");
    await prefs.remove("refreshToken");
  }

  // Close the HTTP client
  void close() {
    _client.close();
  }
}  */




  