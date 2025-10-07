
abstract class ApiRequestInterface {
  
  Future<dynamic> getDataRequest(String url); 
  Future<dynamic> postDataService(String url, Map<String,dynamic> body); 
  
}