abstract class AuthInterfaces {
  Future<dynamic> postResquest(Map<String,dynamic> body,String url);
  Future<dynamic> postRequestForLogin(Map<String,dynamic> body,String url);

}