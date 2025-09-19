import 'package:flutter/material.dart';
import 'package:frontend/Repos/app_url.dart';
import 'package:frontend/helper_classes/token_refresh.dart';
import 'package:frontend/utils/text_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
     
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
     
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: TextButton(onPressed: () async {
               final data = await TokenRefresh.checkToken(AppUrl.get_all_categories_url);
               print("All Categories :\n$data");
              }, child: TextView(text: "Category API call")),
            ),
            Center(
              child: TextButton(onPressed: () async {
                final data = await TokenRefresh.checkToken("${AppUrl.get_by_categry_id_url}68c92b17cf8c8608857f0b96");
               print("Product by category :\n$data");
        
              }, child: TextView(text: "Get Product By CategoryId")),
            ),
            Center(
              child: TextButton(onPressed: () async {
               final data =await TokenRefresh.checkToken("${AppUrl.prodcut_by_Id_url}68c9071f283ed5949c12f3a2");
               print("One Product detail :\n$data" );
              }, child: TextView(text: "Get Single Product")),
            ),
            
          ],
        ),
      )
    );
  }
}
