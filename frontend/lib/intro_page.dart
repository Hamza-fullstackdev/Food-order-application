// import 'package:flutter/material.dart';
// import 'package:frontend/Repos/auth_provider.dart';
// import 'package:frontend/homeScreen.dart';
// import 'package:frontend/utils/app_contants.dart';
// import 'package:frontend/utils/common_button.dart';
// import 'package:frontend/utils/text_view.dart';
// import 'package:provider/provider.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class IntroPage extends StatefulWidget {
//   const IntroPage({super.key});

//   @override
//   State<IntroPage> createState() => _IntroPageState();
// }

// class _IntroPageState extends State<IntroPage> {
//   late PageController _controller;
//   late final TextEditingController _nameController;
//   late final TextEditingController _signupEmailController;
//   late final TextEditingController _signupPassController;

//   late final TextEditingController _loginEmailController;
//   late final TextEditingController _loginPassController;
//   late int _itemCount;

//   @override
//   void initState() {
//     _controller = PageController();
//     _nameController = TextEditingController();
//     _signupEmailController = TextEditingController();
//     _signupPassController = TextEditingController();
//     _loginEmailController = TextEditingController();
//     _loginPassController = TextEditingController();
//     _itemCount = 3;
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _nameController.dispose();
//     _signupEmailController.dispose();
//     _signupPassController.dispose();
//     _loginEmailController.dispose();
//     _loginPassController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: AppContants.blackColor,
//                   image: DecorationImage(
//                     image: AssetImage("assets/images/on_board_bg.png"),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Builder(

//                   builder: (context) {
//                     return PageView(
//                       controller: _controller,
//                       children: [
//                         pageItem(
//                           "assets/images/intro_img1.png",
//                           "Select the\nFavorities Menu",
//                           "Now eat well, don't leave the house,You can\n"
//                               "choose your favorite food only with\n",
//                           () => _controller.nextPage(
//                             duration: Duration(microseconds: 500),
//                             curve: Curves.linearToEaseOut,
//                           ),
//                         ),

//                         pageItem(
//                           "assets/images/intro_img2.png",
//                           "Good food at a\ncheap price",
//                           "You can eat at expensive\nrestaurants with\n"
//                               "affordable price",
//                           () => _controller.nextPage(
//                             duration: Duration(microseconds: 500),
//                             curve: Curves.linearToEaseOut,
//                           ),
//                         ),

//                         pageItem(
//                           "assets/images/intro_img1.png",
//                           "Select the\nFavorities Menu",
//                           "Now eat well, don't leave the house,You can\n"
//                               "choose your favorite food only with\n",
//                           () => presistanceBottomSheet(context),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             alignment: AlignmentGeometry.xy(0, 0.95),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     _controller.jumpToPage(_itemCount - 1);
//                   },
//                   child: TextView(text: "skip", color: AppContants.blackColor),
//                 ),
//                 SmoothPageIndicator(
//                   controller: _controller,
//                   count: _itemCount,
//                   effect: SwapEffect(
//                     activeDotColor: AppContants.redColor,
//                     dotHeight: 10,
//                     dotWidth: 10,
//                     dotColor: AppContants.lightGrey,
//                   ),
//                 ),

//                 Builder(
//                   builder: (context) {
//                     return IconButton(
//                       onPressed: () {
//                         if (_controller.page!.round() < _itemCount - 1) {
//                           _controller.nextPage(
//                             duration: Duration(milliseconds: 500),
//                             curve: Curves.linearToEaseOut,
//                           );
//                         } else {
//                           presistanceBottomSheet(context);
//                         }
//                       },
//                       icon: Icon(
//                         Icons.arrow_forward,
//                         color: AppContants.redColor,
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }


//   PersistentBottomSheetController presistanceBottomSheet(BuildContext context) {
//     return showBottomSheet(
//       showDragHandle: true,
//       enableDrag: true,
//       backgroundColor: AppContants.whiteColor,
//       elevation: 5,
//       context: context,
//       builder: (context) => SizedBox(
//         // height: 550,
//         child: DefaultTabController(
//           length: 2,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TabBar(
//                 labelColor: AppContants.redColor,
//                 labelStyle: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 16,
//                 ),
//                 unselectedLabelStyle: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   color: AppContants.blackColor,
//                   fontSize: 16,
//                 ),
//                 indicatorColor: AppContants.redColor,
//                 indicatorWeight: 1.0,
//                 tabs: [
//                   Tab(text: "Create Account"),
//                   Tab(text: "Login"),
//                 ],
//               ),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 16.0),
//                       child: TabView(
//                         islogin: false,
//                         nameController: _nameController,
//                         emailController: _signupEmailController,
//                         passController: _signupPassController,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 16.0),
//                       child: TabView(
//                         islogin: true,
//                         emailController: _loginEmailController,
//                         passController: _loginPassController,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Column pageItem(
//     imgResource,
//     pageHeading,
//     pageDescription,
//     VoidCallback onPressed,
//   ) {
//     return Column(
//       children: [
//         Image.asset(imgResource, height: 334, width: 308),
//         TextView(text: pageHeading, textAlignment: true, size: 22, weight: 700),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           child: TextView(
//             text: pageDescription,
//             textAlignment: true,
//             size: 12,
//             weight: 400,
//           ),
//         ),
//         CommonButton(
//           onPressed: onPressed,
//           isGradient: true,
//           child: TextView(
//             text: "Next",
//             size: 16,
//             weight: 900,
//             color: AppContants.whiteColor,
//             textAlignment: true,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ignore: must_be_immutable
// class TabView extends StatelessWidget {
//   TabView({
//     super.key,
//     required bool islogin,
//     TextEditingController? nameController,
//     required TextEditingController emailController,
//     required TextEditingController passController,
//   }) : _nameController = nameController,
//        _emailController = emailController,
//        _passController = passController,
//        _login = islogin;

//   final TextEditingController? _nameController;
//   final TextEditingController _emailController;
//   final TextEditingController _passController;
//   final bool _login;
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (!_login)
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 4.0,
//                   horizontal: 14,
//                 ),
//                 child: TextView(text: "First Name", size: 14, weight: 500),
//               ),
//             if (!_login)
//               TextFormField(
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "User name required.";
//                   }
//                   return null;
//                 },
//                 controller: _nameController,
//                 obscureText: false,
//                 decoration: InputDecoration(
//                   hint: TextView(text: "Enter you name", size: 14, weight: 500),

//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(7),
//                     borderSide: BorderSide(color: AppContants.offWhiteColor),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(7),
//                     borderSide: BorderSide(color: AppContants.offWhiteColor),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(7),
//                     borderSide: BorderSide(color: AppContants.redColor),
//                   ),
//                 ),
//               ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 4.0,
//                 horizontal: 14,
//               ),
//               child: TextView(text: "Email address", size: 14, weight: 500),
//             ),
//             TextFormField(
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "User name required.";
//                 }
//                 return null;
//               },
//               controller: _emailController,
//               obscureText: false,
//               decoration: InputDecoration(
//                 hint: TextView(text: "Enter your email", size: 14, weight: 500),

//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(7),
//                   borderSide: BorderSide(color: AppContants.offWhiteColor),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(7),
//                   borderSide: BorderSide(color: AppContants.offWhiteColor),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(7),
//                   borderSide: BorderSide(color: AppContants.redColor),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 4.0,
//                 horizontal: 14,
//               ),
//               child: TextView(text: "Password", size: 14, weight: 500),
//             ),
//             TextFormField(
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "User password required.";
//                 }
//                 return null;
//               },
//               controller: _passController,
//               obscureText: true,
//               obscuringCharacter: "*",
//               decoration: InputDecoration(
//                 hint: TextView(
//                   text: "Enter your password",
//                   size: 14,
//                   weight: 500,
//                 ),

//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(7),
//                   borderSide: BorderSide(color: AppContants.offWhiteColor),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(7),
//                   borderSide: BorderSide(color: AppContants.offWhiteColor),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(7),
//                   borderSide: BorderSide(color: AppContants.redColor),
//                 ),
//               ),
//             ),
//             if (_login)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     onPressed: () {},
//                     child: Text(
//                       "Forgot Password?",
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xffFF0000),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 16),
//                 child: CommonButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       FutureBuilder(
//                         future: authProvider.loginUser(
//                           _emailController.text,
//                           _passController.text,
//                           false,
//                           userName: _nameController!.text,

//                         ),
//                         builder: (context, snapshot) {
//                           if (!snapshot.hasData) {
//                             return CircularProgressIndicator();
//                           } else {
//                             print(snapshot.data);
//                             return Text("${snapshot.data}");
//                           }
//                         },
//                       );
//                     }
//                   },
//                   isGradient: true,
//                   child: _login
//                       ? TextButton(
//                           onPressed: () async {
//                             if (_formKey.currentState!.validate()) {
//                               //  _emailController.clear();
//                               // _passController.clear();
//                               // _nameController!.clear();
//                               bool isLogin = await authProvider.loginUser(
//                                 _emailController.text,
//                                 _passController.text,
//                                 true,
//                               );
//                               if (isLogin) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         MyHomePage(title: "Hello world"),
//                                   ),
//                                 );
//                               }
//                             }
//                           },
//                           child: TextView(
//                             text: "Login",
//                             size: 14,
//                             weight: 900,
//                             color: AppContants.whiteColor,
//                             textAlignment: true,
//                           ),
//                         )
//                       : TextButton(
//                           onPressed: () async {
//                             if (_formKey.currentState!.validate()) {
//                               // _emailController.clear();
//                               // _passController.clear();
//                               // _nameController!.clear();
//                               bool isRegistered = await authProvider.loginUser(
//                                 _emailController.text,
//                                 _passController.text,
//                                 false,
//                                 userName : _nameController!.text,
//                               );
//                               if (isRegistered) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         MyHomePage(title: "Hello world"),
//                                   ),
//                                 );
//                               }
//                             }
//                           },
//                           child: TextView(
//                             text: "Sign Up",
//                             size: 14,
//                             weight: 900,
//                             color: AppContants.whiteColor,
//                             textAlignment: true,
//                           ),
//                         ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 148.0),
//               child: Divider(thickness: 1),
//             ),

//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 16),
//                 child: CommonButton(
//                   onPressed: () {},
//                   isGradient: false,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Image(image: AssetImage("assets/images/ic_google.png")),
//                       SizedBox(width: 20),
//                       TextView(
//                         text: "Sign up with Google",
//                         size: 14,
//                         weight: 700,
//                         color: AppContants.blackColor,
//                         textAlignment: true,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
