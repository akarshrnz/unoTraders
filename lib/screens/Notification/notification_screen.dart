import 'package:codecarrots_unotraders/model/notification%20model/notification_model.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/message_services.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(appBarTitle: "Notification"),
      body: FutureBuilder<List<NotificationModel>>(
        future: MessageServices.getNotification(),
        builder: (context, AsyncSnapshot<List<NotificationModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              List<NotificationModel> data1 = snapshot.data ?? [];
              List<NotificationModel> data = data1.reversed.toList();
              print(data.length);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                      AppConstant.kheight(height: 7),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final notification = data[index];
                    DateTime date = DateTime.parse(notification.time ?? "");
                    return Card(
                      elevation: .3,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 29,
                              backgroundColor: Colors.grey[100],
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 23,
                                  backgroundColor: AppColor.whiteColor,
                                  backgroundImage:
                                      AssetImage("assets/logo/app_icon.png"),
                                ),
                              ),
                            ),
                            AppConstant.kWidth(width: 10),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    data: notification.notification ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  AppConstant.kheight(height: 5),
                                  TextWidget(
                                    data:
                                        "${date.day}-${date.month}-${date.year} ${DateFormat('hh:mm a').format(date)}",
                                    maxLines: 1,
                                    style: TextStyle(color: AppColor.green),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
              // return ListView.builder(
              //   itemCount: data.length,
              //   itemBuilder: (context, index) {
              //     print(data.length);
              //     print("object");
              // final notification = data[index];
              // DateTime date = DateTime.parse(notification.time ?? "");
              //     Card(child: Text("data")

              //         // Row(
              //         //   children: [
              //         //     Expanded(
              //         //       flex: 1,
              //         //       child:
              // CircleAvatar(
              //         //         backgroundColor: AppColor.whiteColor,
              //         //         backgroundImage:
              //         //             AssetImage("assets/logo/logo.png"),
              //         //       ),
              //         //     ),
              //         //     Expanded(
              //         //       flex: 2,
              //         //       child: Column(
              //         //         children: [
              //         //           TextWidget(
              //         //             data: notification.notification ?? "",
              //         //             overflow: TextOverflow.ellipsis,
              //         //           ),
              //         //           TextWidget(
              //         //             data:
              //         //                 "${date.day}-${date.month}-${date.year} ${DateFormat('hh:mm a').format(date)}",
              //         //             maxLines: 1,
              //         //             style: TextStyle(color: AppColor.green),
              //         //             overflow: TextOverflow.ellipsis,
              //         //           )
              //         //         ],
              //         //       ),
              //         //     )
              //         //   ],
              //         // ),
              //         );
              //   },
              // );
            } else {
              Center(child: TextWidget(data: "Document does not exist"));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
