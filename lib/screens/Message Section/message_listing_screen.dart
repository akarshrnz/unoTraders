import 'package:codecarrots_unotraders/provider/message_provider.dart';
import 'package:codecarrots_unotraders/screens/Message%20Section/chat_screen.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late MessageProvider messageProvider;
  @override
  void initState() {
    messageProvider = Provider.of<MessageProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      messageProvider.gerMessageList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(appBarTitle: "Chat"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () async {
            messageProvider.gerMessageList();
          },
          child: Consumer<MessageProvider>(builder: (context, provider, _) {
            return provider.isLoading
                ? Center(child: AppConstant.circularProgressIndicator())
                : provider.errorMessage.isNotEmpty
                    ? Center(
                        child: TextWidget(data: provider.errorMessage),
                      )
                    : ListView.builder(
                        itemCount: provider.allMessageList.length,
                        itemBuilder: (context, index) {
                          final data = provider.allMessageList[index];
                          DateTime date = DateTime.parse(data.time!);
                          return InkWell(
                            onTap: () {
                              if (data.userId == null ||
                                  data.userType == null) {
                              } else {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: ChatScreen(
                                          name: data.name ?? "",
                                          profilePic: data.profilePic ?? "",
                                          toUserId: data.userId!,
                                          toUsertype: data.userType ?? "",
                                        )));
                              }
                            },
                            child: Card(
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: 29,
                                          child: CircleAvatar(
                                            radius: 28,
                                            backgroundImage: NetworkImage(
                                                data.profilePic ?? ""),
                                            backgroundColor:
                                                AppColor.whiteColor,
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          data: data.name ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: AppColor.blackColor,
                                          ),
                                        ),
                                        TextWidget(
                                          data: data.message ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        TextWidget(
                                          data:
                                              "${DateFormat('hh:mm a').format(date)}",
                                        ),

                                        // CircleAvatar(
                                        //   child: TextWidget(data:"5"),
                                        //   backgroundColor: AppColor.green,
                                        // )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
          }),
        ),
      ),
    );
  }
}
