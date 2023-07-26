import 'package:codecarrots_unotraders/model/provider_profile_model.dart';
import 'package:codecarrots_unotraders/provider/trader_category_provider.dart';
import 'package:codecarrots_unotraders/screens/Message%20Section/chat_screen.dart';

import 'package:codecarrots_unotraders/screens/Profile/traders/trader_profile_visit.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';

import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ListTraders extends StatefulWidget {
  final String id;
  final String category;
  const ListTraders({super.key, required this.id, required this.category});

  @override
  State<ListTraders> createState() => _ListTradersState();
}

class _ListTradersState extends State<ListTraders> {
  late TraderCategoryProvider categoryProvider;

  @override
  void initState() {
    categoryProvider =
        Provider.of<TraderCategoryProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      categoryProvider.findTraderCategory(id: widget.id);
    });
    // TODO: implement initState
    super.initState();
  }

  fetchApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getDouble("latitude") == null ||
        prefs.getDouble("longitude") == null) {}
  }

  //  Future<void> _requestPermissionAndStoreLocation() async {
  //   LocationPermission permission = await Geolocator.requestPermission();

  //   if (permission == LocationPermission.denied) {
  //     // Handle if permission is denied
  //     print('Location permission denied');
  //   } else if (permission == LocationPermission.deniedForever) {
  //     // Handle if permission is permanently denied
  //     print('Location permission permanently denied');
  //     await _openAppSettings();
  //   } else {
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );

  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setDouble('latitude', position.latitude);
  //     prefs.setDouble('longitude', position.longitude);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print("id dfdfgdf");
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(appBarTitle: widget.category),
      body: Consumer<TraderCategoryProvider>(
          builder: (BuildContext context, provider, _) {
        return provider.traderFetching
            ? AppConstant.circularProgressIndicator()
            : provider.traderFetchError.isNotEmpty
                ? Center(
                    child: TextWidget(data: provider.traderFetchError),
                  )
                : Column(
                    children: [
                      Flexible(child: bodyWidget(provider.traderList, size))
                    ],
                  );
      }),
    );
  }

  ListView bodyWidget(List<ProviderProfileModel> traderList, Size size) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: traderList.length,
      itemBuilder: (context, index) {
        final data = traderList[index];
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * .02, vertical: size.width * .02),
          width: size.width,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: TraderProfileVisit(
                        id: data.id.toString(),
                        category: widget.category,
                      )));
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(size.width * .02),
                        child: CircleAvatar(
                          radius: size.width * .07,
                          backgroundColor: AppColor.green,
                          child: CircleAvatar(
                            backgroundColor: AppColor.whiteColor,
                            radius: size.width * .06,
                            backgroundImage: NetworkImage(
                              data.profilePic ?? "",
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: size.width * .03, bottom: size.width * .03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title(
                                  text: data.name ?? "",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              Row(
                                children: [
                                  title(
                                      text: data.rating ?? "",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      maxLines: 1),
                                  AppConstant.kWidth(width: size.width * .01),
                                  Expanded(
                                      child: Container(
                                    child: title(
                                        text: "reviews",
                                        color: AppColor.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ))
                                ],
                              ),
                              title(
                                  text: data.completedWorks ?? "",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //       horizontal: size.width * .02),
                  //   child: title(
                  //       text: 'Description missing ',
                  //       maxLines: 2,
                  //       fontWeight: FontWeight.w500),
                  // ),
                  SizedBox(
                    height: size.width * .01,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * .02),
                    child: messageCallRow(context, data, size),
                  ),
                  SizedBox(
                    height: size.width * .02,
                  ),
                ],
              ),
            ),

            //  Card(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         mainAxisSize: MainAxisSize.max,
            //         children: [
            //           Padding(
            //             padding:
            //                 EdgeInsets.all(size.width * .02),
            //             child: CircleAvatar(
            //               radius: size.width * .1,
            //               backgroundColor: AppColor.green,
            //               child: CircleAvatar(
            //                 radius: size.width * .09,
            //                 backgroundImage: NetworkImage(
            //                   data.profilePic!,
            //                 ),
            //               ),
            //             ),
            //           ),
            //           Flexible(
            //             child: Padding(
            //               padding: EdgeInsets.only(
            //                   top: size.width * .03,
            //                   bottom: size.width * .03),
            //               child: Column(
            //                 crossAxisAlignment:
            //                     CrossAxisAlignment.start,
            //                 children: [
            //                   title(
            //                       text: data.name!,
            //                       fontSize: 15,
            //                       fontWeight:
            //                           FontWeight.bold),
            //                   Row(
            //                     children: [
            //                       title(
            //                           text: data.rating!,
            //                           fontSize: 15,
            //                           fontWeight:
            //                               FontWeight.bold,
            //                           maxLines: 1),
            //                       AppConstant.kWidth(
            //                           width:
            //                               size.width * .01),
            //                       Expanded(
            //                           child: Container(
            //                         child: title(
            //                             text: "reviews",
            //                             color: AppColor.green,
            //                             fontSize: 12,
            //                             fontWeight:
            //                                 FontWeight.bold),
            //                       ))
            //                     ],
            //                   ),
            //                   title(
            //                       text: data.completedWorks!,
            //                       fontSize: 15,
            //                       fontWeight:
            //                           FontWeight.bold),
            //                 ],
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //       Container(
            //         height: size.width * .1,
            //         color: AppColor.blackColor,
            //         child: Row(
            //           mainAxisAlignment:
            //               MainAxisAlignment.end,
            //           children: [
            //             bottomButton(
            //               icon: Icons.chat,
            //               label: "Message",
            //               onPressed: () {
            //                 // ignore: avoid_print
            //                 print("pressed");
            //               },
            //             ),
            //             verticaldivider(size),
            //             bottomButton(
            //               icon: Icons.phone,
            //               label: "Phone",
            //               onPressed: () {
            //                 // ignore: avoid_print
            //                 print("pressed");
            //               },
            //             ),
            //             verticaldivider(size),
            //             bottomButton(
            //               icon: Icons.request_quote,
            //               label: "Get a Quote",
            //               onPressed: () {
            //                 // ignore: avoid_print
            //                 print("pressed");
            //               },
            //             ),
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),
          ),
        );
      },
    );
  }

  Row messageCallRow(
      BuildContext context, ProviderProfileModel data, Size size) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: ChatScreen(
                          profilePic: data.profilePic ?? "",
                          toUserId: data.id ?? 0,
                          toUsertype: "trader",
                          name: data.name ?? "",
                        )));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * .05),
                  color: Colors.green,
                ),
                height: size.width * .08,
                child: TextWidget(
                  data: "Message",
                  style: TextStyle(color: AppColor.whiteColor),
                ),
              ),
            )),
        SizedBox(
          width: size.width * .02,
        ),
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: () async {
                print("pressed");
                if (data.mobile != null && data.countryCode != null) {
                  if (data.mobile!.isNotEmpty && data.countryCode!.isNotEmpty) {
                    final Uri _phoneNo = Uri.parse(
                        'tel:+${data.countryCode ?? ''}${data.mobile ?? ""}');
                    if (await launchUrl(_phoneNo)) {
                      print(" opened");
                      //dialer opened
                    } else {
                      print("not opened");
                      //dailer is not opened
                    }
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * .05),
                  color: Colors.green,
                ),
                height: size.width * .08,
                child: TextWidget(
                  data: "Call",
                  style: TextStyle(color: AppColor.whiteColor),
                ),
              ),
            )),
        // SizedBox(
        //   width: size.width * .02,
        // ),
        // Expanded(flex: 1, child: SizedBox())
        // Expanded(
        //     flex: 1,
        //     child: InkWell(
        //       onTap: () {

        //       },
        //       child: Container(
        //         alignment: Alignment.center,
        //         decoration: BoxDecoration(
        //           borderRadius:
        //               BorderRadius.circular(
        //                   size.width * .03),
        //           color: Colors.black,
        //         ),
        //         height: size.width * .06,
        //         child: const TextWidget(data:
        //           "Get a quote",
        //           style: TextStyle(
        //               color:
        //                   AppColor.whiteColor),
        //         ),
        //       ),
        //     )),
      ],
    );
  }

  SizedBox verticaldivider(Size size) {
    return SizedBox(
        height: size.width * .07,
        child: const VerticalDivider(
          color: AppColor.whiteColor,
          width: 2,
        ));
  }

  ElevatedButton bottomButton(
      {required IconData icon,
      required String label,
      required Function() onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppColor.green,
      ),
      label: TextWidget(data: label),
      style: ElevatedButton.styleFrom(backgroundColor: AppColor.blackColor),
    );
  }

  Widget title(
      {required String text,
      required double fontSize,
      required FontWeight fontWeight,
      int? maxLines,
      Color? color}) {
    return TextWidget(
      data: text,
      maxLines: maxLines ?? 2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? AppColor.blackColor),
    );
  }
}
