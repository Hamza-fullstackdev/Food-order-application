import 'package:frontend/App/Core/Exceptions/exceptions.dart';
import 'package:frontend/App2/Data/Network/Services/get_request_service.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';
import 'package:frontend/App2/Resources/app_url.dart';

class CartRepo {
  final apiRequest = ApiRequestService();

  Future<ApiResponse<String>> addItemToCart(
    Map<String, dynamic> body,
  ) async {
    try {
      final url = AppUrl.post_add_to_cart;
      final response = await apiRequest.postDataService(url, body);

      if (response != null && response['message'] != null) {
        return ApiResponse.success(response['message']);
      }
      return ApiResponse.error(response['message']);
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
