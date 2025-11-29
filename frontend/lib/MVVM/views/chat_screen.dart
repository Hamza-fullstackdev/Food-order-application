
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Widgets/text_view.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isReciver = true;
  late final TextEditingController _messageController;
  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: CircleAvatar(
                          backgroundColor: AppColors.lightGreyColor2,
                          child: Icon(Icons.arrow_back_ios, size: 15),
                        ),
                      ),
                      SizedBox(width: 10),
                      TextViewNormal(text: 'Robert Fox'),
                    ],
                  ),
                  SizedBox(height: 20),

                  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return isReciver
                          ? Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,

                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: kIsWeb
                                        ? MediaQuery.of(context).size.width *
                                              0.7
                                        : MediaQuery.of(context).size.width *
                                              0.55,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: AppColors.darkOrangeColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextViewNormal(
                                          text: 'Are you coming?',
                                          colors: AppColors.whiteColor,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextViewNormal(
                                              text: '8:12 pm',
                                              colors: AppColors.whiteColor,
                                            ),
                                            SizedBox(width: 10),
                                            Icon(
                                              Icons.checklist_rtl_sharp,
                                              color: AppColors.whiteColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  CircleAvatar(
                                    backgroundColor: AppColors.lightOrangeColor,
                                    maxRadius: 20,
                                    minRadius: 20,
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColors.darkGreyColor,
                                    maxRadius: 20,
                                    minRadius: 20,
                                  ),
                                  SizedBox(width: 10),

                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: kIsWeb
                                        ? MediaQuery.of(context).size.width *
                                              0.7
                                        : MediaQuery.of(context).size.width *
                                              0.55,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: AppColors.lightGreyColor2,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextViewNormal(
                                          text: 'Are you coming?',
                                          colors: AppColors.blackColor,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextViewNormal(
                                              text: '8:12 pm',
                                              colors: AppColors.blackColor,
                                            ),
                                            SizedBox(width: 10),
                                            Icon(
                                              Icons.checklist_rtl_sharp,
                                              color: AppColors.blackColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: TextFormField(
                  controller: _messageController,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.emoji_emotions_outlined),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send_outlined,
                        color: AppColors.orangeColor,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Write something",
                    hintStyle: TextStyle(color: AppColors.darkGreyColor),
                    filled: true,
                    fillColor: AppColors.lightGreyColor2,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
