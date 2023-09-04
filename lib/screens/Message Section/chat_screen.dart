import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:codecarrots_unotraders/model/bazaar_detail_post_model.dart';
import 'package:codecarrots_unotraders/model/message/bazaar_store_message_model.dart';
import 'package:codecarrots_unotraders/model/message/send_message_model.dart';
import 'package:codecarrots_unotraders/provider/current_user_provider.dart';
import 'package:codecarrots_unotraders/provider/message_provider.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/bazaar_detail_page.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatScreen extends StatefulWidget {
  BazaarStoreMessageModel? storeBazaar;
  final String name;
  final int toUserId;
  final String profilePic;
  final String toUsertype;
  ChatScreen(
      {super.key,
      this.storeBazaar,
      required this.toUserId,
      required this.toUsertype,
      required this.profilePic,
      required this.name});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();
  TextEditingController sendMessageController = TextEditingController();
  FocusNode focusnode = FocusNode();
  late MessageProvider messageProvider;

  bool _isKeyboardVisible = false;

  @override
  void dispose() {
    scrollController.dispose();
    focusnode.dispose();
    sendMessageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    messageProvider = Provider.of<MessageProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.storeBazaar == null) {
        callChat();
      } else {
        storeBazaarCallChat();
      }
    });

    super.initState();
  }

  void _scrollToBottom() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });

    // await Future.delayed(const Duration(milliseconds: 300));
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   scrollController.animateTo(scrollController.position.minScrollExtent,
    //       duration: const Duration(milliseconds: 400),
    //       curve: Curves.fastOutSlowIn);
    // });
    // scrollController.animateTo(
    //   scrollController.position.maxScrollExtent,
    //   duration: Duration(milliseconds: 100),
    //   curve: Curves.easeOut,
    // );
  }

  callChat() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    if (userType.toLowerCase() == "provider") {
      userType = "trader";
    }
    SendMessageModel send = SendMessageModel(
        toUserId: widget.toUserId.toString(),
        toUserType: widget.toUsertype,
        userId: id,
        userType: userType,
        message: null);
    await messageProvider.getOneToOneMessage(apiBody: send);
    _scrollToBottom();
  }

  storeBazaarCallChat() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    if (userType.toLowerCase() == "provider") {
      userType = "trader";
    }
    SendMessageModel send = SendMessageModel(
        toUserId: widget.toUserId.toString(),
        toUserType: widget.toUsertype,
        userId: id,
        userType: userType,
        message: null);
    await messageProvider.bazaarMessage(
        apiBody: send, storeBazaar: widget.storeBazaar!);
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>start");
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 100.0, right: 5),
          child: FloatingActionButton(
            child: Icon(
              Icons.change_circle_rounded,
              color: AppColor.green,
              size: 45,
            ),
            backgroundColor: AppColor.whiteColor,
            onPressed: () async {
              callChat();
            },
          ),
        ),
        body: Consumer<MessageProvider>(builder: (context, provider, _) {
          return Column(
            children: [
              SizedBox(
                height: 70,
                child: Card(
                  elevation: .8,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Image.asset(PngImages.arrowBack))),
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.profilePic),
                        backgroundColor: AppColor.green,
                      ),
                      AppConstant.kWidth(width: 7),
                      Flexible(
                        child: TextWidget(
                          data: widget.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: provider.oneToOneLoading
                      ? Center(child: AppConstant.circularProgressIndicator())
                      : provider.oneToOneMessageError.isNotEmpty
                          ? Center(
                              child: TextWidget(
                                  data: provider.oneToOneMessageError),
                            )
                          : Consumer<CurrentUserProvider>(
                              builder: (context, userProvider, _) {
                              String currentUserId =
                                  userProvider.currentUserId ?? "";
                              String currentType =
                                  userProvider.currentUserType ?? "";
                              if (currentType.toLowerCase() == "provider") {
                                currentType = 'trader';
                              }
                              print(currentType);
                              print(currentUserId);
                              return ListView.separated(
                                controller: scrollController,
                                shrinkWrap: true,
                                itemCount: provider.oneToOneChat.length,
                                itemBuilder: (context, index) {
                                  final data = provider.oneToOneChat[index];
                                  return data.productId == 0
                                      ? BubbleSpecialThree(
                                          text: data.message ?? "",
                                          color: currentUserId ==
                                                      data.userId.toString() &&
                                                  currentType ==
                                                      data.userType.toString()
                                              ? Color(0XFF4CAF50)
                                              : Color(0XFFEEEEEE),
                                          isSender: currentUserId ==
                                                      data.userId.toString() &&
                                                  currentType ==
                                                      data.userType.toString()
                                              ? true
                                              : false,
                                          tail: false,
                                          textStyle: TextStyle(
                                              color: currentUserId ==
                                                          data.userId
                                                              .toString() &&
                                                      currentType ==
                                                          data.userType
                                                              .toString()
                                                  ? AppColor.whiteColor
                                                  : AppColor.blackColor,
                                              fontSize: 16),
                                        )
                                      : Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          width: size.width,
                                          child: Align(
                                            alignment: currentUserId ==
                                                        data.userId
                                                            .toString() &&
                                                    currentType ==
                                                        data.userType.toString()
                                                ? Alignment.centerRight
                                                : Alignment.centerRight,
                                            child: Container(
                                              width: 200,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: currentUserId ==
                                                              data.userId
                                                                  .toString() &&
                                                          currentType ==
                                                              data.userType
                                                                  .toString()
                                                      ? Color(0XFF4CAF50)
                                                      : null),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      final sharedPrefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      String id = sharedPrefs
                                                          .getString('id')!;
                                                      String userType =
                                                          sharedPrefs.getString(
                                                              'userType')!;
                                                      BazaarDetailPostModel
                                                          postBody =
                                                          BazaarDetailPostModel(
                                                              productId:
                                                                  data.id,
                                                              userId:
                                                                  int.parse(id),
                                                              userType:
                                                                  userType);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  BazaarDetailScreen(
                                                                    postBody:
                                                                        postBody,
                                                                  )));
                                                    },
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          data.productImage ??
                                                              "",
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Center(
                                                              child: Column(
                                                        children: [
                                                          const Icon(
                                                            Icons.error,
                                                            color: AppColor.red,
                                                          ),
                                                          TextWidget(
                                                              data:
                                                                  "Failed to load")
                                                        ],
                                                      )),
                                                    ),
                                                  ),
                                                  // Image.network(
                                                  //     data.productImage ?? ""),
                                                  AppConstant.kheight(
                                                      height: 5),
                                                  Wrap(
                                                    children: [
                                                      Center(
                                                        child: TextWidget(
                                                          data: data.message ??
                                                              "",
                                                          style: TextStyle(
                                                              color: currentUserId ==
                                                                          data.userId
                                                                              .toString() &&
                                                                      currentType ==
                                                                          data.userType
                                                                              .toString()
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                },
                                separatorBuilder: (context, index) =>
                                    AppConstant.kheight(height: 10),
                              );
                            })),
              provider.sendMsgLoading
                  ? SpinKitThreeBounce(
                      color: Colors.grey,
                      size: 20.0,
                    )
                  : SizedBox(),
              Container(
                child: Row(
                  children: [
                    AppConstant.kWidth(width: 20),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey)),
                        child: TextField(
                          focusNode: focusnode,
                          controller: sendMessageController,
                          decoration: InputDecoration(
                              hintText: "Write something",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    AppConstant.kWidth(width: 5),
                    InkWell(
                      onTap: () async {
                        focusnode.unfocus();
                        final sharedPrefs =
                            await SharedPreferences.getInstance();
                        String id = sharedPrefs.getString('id')!;
                        String userType = sharedPrefs.getString('userType')!;
                        if (userType.toLowerCase() == "provider") {
                          userType = "trader";
                        }
                        SendMessageModel send = SendMessageModel(
                            toUserId: widget.toUserId.toString(),
                            toUserType: widget.toUsertype,
                            userId: id,
                            userType: userType,
                            message: sendMessageController.text.trim());

                        SendMessageModel callAllMessage = SendMessageModel(
                            toUserId: widget.toUserId.toString(),
                            toUserType: widget.toUsertype,
                            userId: id,
                            userType: userType,
                            message: null);

                        bool res = await messageProvider.sendMessage(
                            send: send, getAllMessage: callAllMessage);
                        if (res == true) {
                          sendMessageController.clear();
                          _scrollToBottom();
                        }
                      },
                      child: const CircleAvatar(
                        backgroundColor: AppColor.green,
                        radius: 23,
                        child: Icon(
                          Icons.send,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                    AppConstant.kWidth(width: 15),
                  ],
                ),
                width: size.width,
                height: 80,
                decoration: BoxDecoration(color: Colors.grey[200]),
              )
            ],
          );
        }),
      ),
    );
  }
}
