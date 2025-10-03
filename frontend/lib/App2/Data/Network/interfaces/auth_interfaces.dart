abstract class AuthInterfaces {

  Future<Map<String,dynamic>> registerUser(String name,String email,String password,String url);
  Future<Map<String,dynamic>> loginUser(String email,String password,String url);
  
}