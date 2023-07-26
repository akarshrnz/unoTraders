import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/provider/current_user_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_insights_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';

import 'package:codecarrots_unotraders/screens/Profile/traders/components/trader_feeds_screen.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/components/trader_offer_screen.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/profile/qr_code_popup.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/color.dart';
import '../../../utils/png.dart';
import '../../Message Section/chat_screen.dart';
import '../../appointments/book_appointment_popup.dart';
import '../../job/job type/customer job  type/review/customer_review.dart';
import 'components/review_circle_widget.dart';
import 'components/view_review_screen.dart';

class UrlTraderProfileVisit extends StatefulWidget {
  final String userName;

  const UrlTraderProfileVisit({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  _TraderProfileState createState() => _TraderProfileState();
}

class _TraderProfileState extends State<UrlTraderProfileVisit> {
  late ProfileProvider profileProvider;
  late ProfileInsightsProvider profileInsightsProvider;
  int currentIndex = 0;
  List<String> title = ["View Post", "View Offers", "View Reviews"];

  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileInsightsProvider =
        Provider.of<ProfileInsightsProvider>(context, listen: false);
    profileProvider.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // // profileProvider.getFeeds(userType: 'trader', userId: widget.id);
      // profileProvider.getFeeds(userType: 'trader', userId: widget.id);
      profileProvider.getProfileByQrCode(userName: widget.userName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: AppColor.whiteColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(PngImages.arrowBack)),
        centerTitle: true,
        title: TextWidget(
          data: 'Trader Profile',
          style: TextStyle(color: AppColor.blackColor),
        ),
      ),
      body: Consumer<ProfileProvider>(
          builder: (context, ProfileProvider traderProvider, _) {
        return traderProvider.qrLoading
            ? Center(child: AppConstant.circularProgressIndicator())
            : traderProvider.qrError.isNotEmpty
                ? Center(
                    child: TextWidget(data: "Something Went Wrong"),
                  )
                : SingleChildScrollView(
                    child: traderProvider.traderProfile == null
                        ? Center(
                            child: TextWidget(data: "No Data"),
                          )
                        : profileBody(
                            context: context,
                            size: size,
                            profileModel: traderProvider.traderProfile!)

                    //  FutureBuilder<TraderProfileModel>(
                    //     future:
                    //         profileProvider.getProfileByQrCode(userName: widget.userName),
                    //     // ProfileServices.getTraderProfileByUserName(
                    //     //     userName: widget.userName),
                    //     builder: (context, AsyncSnapshot<TraderProfileModel> snapshot) {
                    //       if (snapshot.connectionState == ConnectionState.waiting) {
                    //         if (snapshot.hasData) {
                    //           return profileBody(
                    //               context: context,
                    //               size: size,
                    //               profileModel: snapshot.data!);
                    //         } else {
                    //           return Center(child: AppConstant.circularProgressIndicator());
                    //         }
                    //       } else if (snapshot.connectionState == ConnectionState.done) {
                    //         if (snapshot.hasError) {
                    //           return const Center(
                    //             child: TextWidget(data:"Something went wrong"),
                    //           );
                    //         } else if (snapshot.hasData) {
                    //           print("started");
                    //           print(snapshot.data!.address);
                    //           return
                    // profileBody(
                    //               context: context,
                    //               size: size,
                    //               profileModel: snapshot.data!);
                    //         } else {
                    //           const Center(child: TextWidget(data:"Document does not exist"));
                    //         }
                    //       } else {
                    //         return Center(child: AppConstant.circularProgressIndicator());
                    //       }
                    //       return Center(child: AppConstant.circularProgressIndicator());
                    //     }),
                    );
      }),
    );
  }

  Widget profileBody(
      {required BuildContext context,
      required Size size,
      required TraderProfileModel profileModel}) {
    final DateTime from = DateTime.fromMillisecondsSinceEpoch(
        int.parse(profileModel.availableTimeFrom!) * 1000);
    final DateTime to = DateTime.fromMillisecondsSinceEpoch(
        int.parse(profileModel.availableTimeTo!) * 1000);
    return Consumer<ProfileProvider>(
        builder: (context, ProfileProvider provider, _) {
      return Padding(
        padding: EdgeInsets.all(size.width * .02),
        child: Column(
          children: [
            Card(
              shadowColor: Colors.grey,
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.all(size.width * .02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    profileModel.profilePic!.isNotEmpty
                        ? CircleAvatar(
                            backgroundColor: AppColor.green,
                            radius: MediaQuery.of(context).size.width * 0.06,
                            child: CircleAvatar(
                              backgroundColor: AppColor.whiteColor,
                              radius: MediaQuery.of(context).size.width * 0.05,
                              backgroundImage: NetworkImage(
                                profileModel.profilePic!,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.06,
                            child: Image.asset(
                              PngImages.profile,
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            const Icon(
                              Icons.badge,
                              color: AppColor.secondaryColor,
                            ),
                            TextWidget(data: 'ID: ${profileModel.username}'),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) =>
                                  QrCodePopUp(url: profileModel.qrcode ?? ""),
                            );
                          },
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                  height: 50,
                                  child: SvgPicture.network(
                                      profileModel.qrcode ?? ""))),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .035, vertical: size.width * .01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        data: profileModel.name ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextWidget(data: profileModel.mainCategory ?? ""),
                    ],
                  ),
                  // CircleAvatar(
                  //   backgroundColor: AppColor.secondaryColor,
                  //   child: TextWidget(data:
                  //     profileModel.rating ?? "0",
                  //     style: const TextStyle(color: AppColor.whiteBtnColor),
                  //   ),
                  // )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Consumer<CurrentUserProvider>(
                        builder: (context, currentUserprovider, _) {
                      return InkWell(
                        onTap: currentUserprovider.currentUserType!
                                        .toLowerCase() ==
                                    'provider' ||
                                currentUserprovider.currentUserType!
                                        .toLowerCase() ==
                                    'trader'
                            ? null
                            : () async {
                                AppConstant.overlayLoaderShow(context);
                                final sharedPrefs =
                                    await SharedPreferences.getInstance();
                                String id = sharedPrefs.getString('id')!;
                                String userType =
                                    sharedPrefs.getString('userType')!;
                                print("follow tap");
                                if (currentUserprovider.currentUserType!
                                        .toLowerCase() ==
                                    'customer') {
                                  print("customer");
                                  await profileProvider.traderFollowUnfollow(
                                      traderId:
                                          int.parse(provider.qrCodeUserId),
                                      customerId:
                                          userType.toLowerCase() == 'provider'
                                              ? null
                                              : id,
                                      customerType:
                                          userType.toLowerCase() == 'provider'
                                              ? null
                                              : userType);
                                  // if (provider.isProgress == true) return;
                                  // setState(() {});
                                } else {
                                  print("trader");
                                }
                                // ignore: use_build_context_synchronously
                                AppConstant.overlayLoaderHide(context);
                              },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(size.width * .06),
                              border: Border.all(
                                color: AppColor.secondaryColor,
                              )),
                          child: Padding(
                            padding: EdgeInsets.all(size.width * .02),
                            child: Center(
                                child: Row(
                              children: [
                                AppConstant.kWidth(width: size.width * .02),
                                Icon(
                                  Icons.groups,
                                  size: size.width * .09,
                                  color: AppColor.green,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      data: profileModel.isFollow == 1
                                          ? "Following"
                                          : 'Follow',
                                      style: TextStyle(
                                        color: AppColor.blackColor,
                                      ),
                                    ),
                                    TextWidget(
                                      data: profileModel.following.toString(),
                                      style: TextStyle(
                                          color: AppColor.blackColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Consumer<CurrentUserProvider>(
                        builder: (context, currentUserprovider, _) {
                      return InkWell(
                        onTap: () async {
                          AppConstant.overlayLoaderShow(context);
                          final sharedPrefs =
                              await SharedPreferences.getInstance();
                          String id = sharedPrefs.getString('id')!;
                          String userType = sharedPrefs.getString('userType')!;
                          print("follow tap");
                          if (currentUserprovider.currentUserType!
                                  .toLowerCase() ==
                              'customer') {
                            print("customer");
                            await profileProvider.traderFavouriteUnfavourite(
                                traderId: int.parse(provider.qrCodeUserId),
                                customerId: userType.toLowerCase() == 'provider'
                                    ? null
                                    : id,
                                customerType:
                                    userType.toLowerCase() == 'provider'
                                        ? null
                                        : userType);
                            // if (provider.isProgress == true) return;
                            // setState(() {});
                          } else {
                            print("trader");
                          }
                          // ignore: use_build_context_synchronously
                          AppConstant.overlayLoaderHide(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(size.width * .06),
                              border: Border.all(
                                color: AppColor.secondaryColor,
                              )),
                          child: Padding(
                            padding: EdgeInsets.all(size.width * .02),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AppConstant.kWidth(width: size.width * .01),
                                Icon(
                                  Icons.favorite,
                                  size: size.width * .06,
                                  color: profileModel.isFavourite == 1
                                      ? AppColor.red
                                      : AppColor.secondaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      data: 'Favourite',
                                      style: TextStyle(
                                        color: AppColor.blackColor,
                                      ),
                                    ),
                                    TextWidget(
                                      data: profileModel.favorites.toString(),
                                      style: TextStyle(
                                          color: AppColor.blackColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Container(
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(size.width * .06),
            //               border: Border.all(
            //                 color: AppColor.secondaryColor,
            //               )),
            //           child: Padding(
            //             padding: EdgeInsets.all(size.width * .02),
            //             child: Center(
            //                 child: Row(
            //               children: [
            //                 AppConstant.kWidth(width: size.width * .02),
            //                 Icon(
            //                   Icons.groups,
            //                   size: size.width * .09,
            //                   color: AppColor.green,
            //                 ),
            //                 const SizedBox(
            //                   width: 10,
            //                 ),
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     const TextWidget(data:
            //                       'Follow',
            //                       style: TextStyle(
            //                         color: AppColor.blackColor,
            //                       ),
            //                     ),
            //                     TextWidget(data:
            //                       profileModel.following.toString(),
            //                       style: TextStyle(
            //                           color: AppColor.blackColor,
            //                           fontWeight: FontWeight.bold,
            //                           fontSize:
            //                               MediaQuery.of(context).size.width *
            //                                   0.04),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             )),
            //           ),
            //         ),
            //       ),
            //       const SizedBox(
            //         width: 10,
            //       ),
            //       Expanded(
            //         child: Container(
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(size.width * .06),
            //               border: Border.all(
            //                 color: AppColor.secondaryColor,
            //               )),
            //           child: Padding(
            //             padding: EdgeInsets.all(size.width * .02),
            //             child: Center(
            //                 child: Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: [
            //                 AppConstant.kWidth(width: size.width * .01),
            //                 Icon(
            //                   Icons.favorite,
            //                   size: size.width * .06,
            //                   color: AppColor.secondaryColor,
            //                 ),
            //                 const SizedBox(
            //                   width: 10,
            //                 ),
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     const TextWidget(data:
            //                       'Favourite',
            //                       style: TextStyle(
            //                         color: AppColor.blackColor,
            //                       ),
            //                     ),
            //                     TextWidget(data:
            //                       profileModel.favorites.toString(),
            //                       style: TextStyle(
            //                           color: AppColor.blackColor,
            //                           fontWeight: FontWeight.bold,
            //                           fontSize:
            //                               MediaQuery.of(context).size.width *
            //                                   0.04),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             )),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReviewCircleWidget(
                    backgroundColor: Color(0XFFD4B83E),
                    title: "Average score",
                    rating: profileModel.avgScore ?? ""),
                ReviewCircleWidget(
                    backgroundColor: Color(0XFFFF8A65),
                    title: "Reliability",
                    rating: profileModel.avgScore ?? ""),
                ReviewCircleWidget(
                    backgroundColor: Color(0XFFEF5350),
                    title: "Courtesy",
                    rating: profileModel.courScore ?? ""),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReviewCircleWidget(
                      backgroundColor: Color(0XFF467CAB),
                      title: "Tidiness",
                      rating: profileModel.tidiScore ?? ""),
                  ReviewCircleWidget(
                      backgroundColor: Color(0XFF3F51B5),
                      title: "Workmanship",
                      rating: profileModel.workScore ?? ""),
                  ReviewCircleWidget(
                      backgroundColor: Color(0XFF66BB6A),
                      title: "Pricing",
                      rating: profileModel.pricScore ?? ""),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: AppColor.blackColor,
                  ),
                  AppConstant.kWidth(width: size.width * .02),
                  TextWidget(
                      data:
                          '+${profileModel.countryCode} ${profileModel.mobile}'),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.phone_in_talk,
                    color: AppColor.blackColor,
                  ),
                  AppConstant.kWidth(width: size.width * .02),
                  InkWell(
                    onTap: () async {
                      if (profileModel.countryCode != null &&
                          profileModel.mobile != null) {
                        if (profileModel.countryCode!.isNotEmpty &&
                            profileModel.mobile!.isNotEmpty) {
                          final Uri _phoneNo = Uri.parse(
                              'tel:+${profileModel.countryCode ?? ''}${profileModel.mobile ?? ""}');
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
                    child: TextWidget(
                        data:
                            '+${profileModel.countryCode} ${profileModel.mobile}'),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.envelope,
                    color: AppColor.blackColor,
                  ),
                  AppConstant.kWidth(width: size.width * .02),
                  InkWell(
                      onTap: () async {
                        if (profileModel.email!.isNotEmpty) {
                          Uri mail = Uri.parse("mailto:${profileModel.email!}");
                          if (await launchUrl(mail)) {
                            //email app opened
                          } else {
                            //email app is not opened
                          }
                        }
                      },
                      child: TextWidget(data: profileModel.email ?? "")),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.locationDot,
                    color: AppColor.blackColor,
                  ),
                  AppConstant.kWidth(width: size.width * .02),
                  InkWell(
                    onTap: () {
                      print("latitude");
                      print(profileModel.locLatitude!);
                      print(profileModel.locLongitude!);
                      if (profileModel.locLatitude != null &&
                          profileModel.locLongitude != null &&
                          profileModel.location != null) {
                        if (profileModel.locLatitude!.isNotEmpty &&
                            profileModel.locLongitude!.isNotEmpty &&
                            profileModel.location!.isNotEmpty) {
                          MapsLauncher.launchCoordinates(
                              double.parse(profileModel.locLatitude!),
                              double.parse(profileModel.locLongitude!),
                              profileModel.location);
                        }
                      } else {}
                    },
                    child: TextWidget(data: profileModel.location ?? ""),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.timer_outlined),
                  AppConstant.kWidth(width: size.width * .02),
                  TextWidget(
                      data:
                          '${DateFormat('kk:mm:a').format(from)} - ${DateFormat('kk:mm:a').format(to)}'),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            AppConstant.kheight(height: size.width * .02),
            InkWell(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) =>
                      BookAppointmentPopUp(traderid: profileModel.id!),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                height: MediaQuery.of(context).size.height * 0.055,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColor.secondaryColor,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                    child: TextWidget(
                  data: 'Book an Appointment',
                  style: TextStyle(
                      color: AppColor.whiteBtnColor,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w500),
                )),
              ),
            ),
            AppConstant.kheight(height: size.width * .02),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 3,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.055,
                width: MediaQuery.of(context).size.width,
                child: Row(
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
                                    name: profileModel.name ?? "",
                                    profilePic: profileModel.profilePic ?? "",
                                    toUserId: profileModel.id ?? 0,
                                    toUsertype: "trader",
                                  )));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 13,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColor.blackColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          // height: MediaQuery.of(context).size.height * 0.055,
                          // width: MediaQuery.of(context).size.width,
                          child: TextWidget(
                              data: "Message",
                              style: TextStyle(
                                  color: AppColor.whiteBtnColor,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          AppConstant.overlayLoaderShow(context);
                          if (profileModel.isBlocked == 0) {
                            await profileInsightsProvider.blockUnBlockTrader(
                                traderId: profileModel.id ?? 0, status: 1);
                            profileProvider.refreshTraderProfile(
                                traderId: profileModel.id ?? 0);
                            //block
                          } else {
                            //unBlock
                            await profileInsightsProvider.blockUnBlockTrader(
                                traderId: profileModel.id ?? 0, status: 0);
                            profileProvider.refreshTraderProfile(
                                traderId: profileModel.id ?? 0);
                          }
                          // ignore: use_build_context_synchronously
                          AppConstant.overlayLoaderHide(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 13,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColor.blackColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          // height: MediaQuery.of(context).size.height * 0.055,
                          // width: MediaQuery.of(context).size.width,
                          child: TextWidget(
                              data: profileModel.isBlocked == 0
                                  ? "Block"
                                  : "Unblock",
                              style: TextStyle(
                                  color: AppColor.whiteBtnColor,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // InkWell(
            //   onTap: () {
            // Navigator.push(
            //     context,
            //     PageTransition(
            //         type: PageTransitionType.fade,
            //         child: ChatScreen(
            //           name: profileModel.name ?? "",
            //           profilePic: profileModel.profilePic ?? "",
            //           toUserId: profileModel.id ?? 0,
            //           toUsertype: "trader",
            //         )));
            //   },
            //   child: Container(
            //     margin: const EdgeInsets.symmetric(
            //       horizontal: 13,
            //     ),
            //     alignment: Alignment.center,
            //     decoration: BoxDecoration(
            //       color: AppColor.blackColor,
            //       borderRadius: BorderRadius.circular(25),
            //     ),
            //     height: MediaQuery.of(context).size.height * 0.055,
            //     width: MediaQuery.of(context).size.width,
            //     child: TextWidget(
            //         data: "Message",
            //         style: TextStyle(
            //             color: AppColor.whiteBtnColor,
            //             fontSize: MediaQuery.of(context).size.width * 0.045,
            //             fontWeight: FontWeight.w500)),
            //   ),
            // ),

            AppConstant.kheight(height: size.width * .02),

            Consumer<ProfileProvider>(builder: (context, userIdProvider, _) {
              return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  // margin: EdgeInsets.only(
                  //     bottom: size.width * .02, top: size.width * .02),
                  width: size.width,
                  height: size.height * .05,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          title.length,
                          (index) => InkWell(
                                onTap: () {
                                  profileProvider.changeTab(index: index);

                                  if (index == 0) {
                                    profileProvider.getFeeds(
                                        urlUserType: 'trader',
                                        traderId: profileModel.id == null
                                            ? ""
                                            : profileModel.id.toString());
                                    // profileProvider.getFeeds(
                                    //     userType: 'trader',
                                    //     userId: userIdProvider.qrCodeUserId);
                                  } else if (index == 1) {
                                    profileProvider.getOffers(
                                        urlUserType: 'trader',
                                        traderId: profileModel.id == null
                                            ? ""
                                            : profileModel.id.toString());
                                  } else if (index == 2) {
                                    profileProvider.getReview(
                                        traderId: userIdProvider.qrCodeUserId);
                                  } else {}
                                  // setState(() {
                                  //   currentIndex = index;
                                  // });
                                },
                                child: Container(
                                  width: size.width * .29,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: provider.currentIndex == index
                                          ? AppColor.green
                                          : AppColor.whiteColor,
                                      border: Border.all(color: AppColor.green),
                                      borderRadius: BorderRadius.circular(
                                          size.width * .05)),
                                  child: TextWidget(
                                    data: title[index],
                                    style: TextStyle(
                                        color: provider.currentIndex == index
                                            ? AppColor.whiteColor
                                            : AppColor.blackColor),
                                  ),
                                ),
                              )).toList()));
            }),
            provider.currentIndex == 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    // padding:
                    //     EdgeInsets.symmetric(horizontal: size.width * .005),
                    child: TraderFeedScreen(
                      isCustomer: false,
                      userid: provider.qrCodeUserId,
                      isProfileVisit: true,
                    ),
                  )
                : const SizedBox(),
            provider.currentIndex == 1
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: TraderOfferScreen(
                      userid: provider.qrCodeUserId,
                      isProfileVisit: true,
                    ),
                  )
                : const SizedBox(),
            provider.currentIndex == 2
                ? Consumer<CurrentUserProvider>(
                    builder: (context, userProvider, _) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * .03),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              child: CustomerReviewScreen(
                                                jobId: "0",
                                                traderId: provider.qrCodeUserId,
                                                endPoints: "",
                                                status: "",
                                              )));
                                    },
                                    child: Container(
                                        height: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColor.green)),
                                        child:
                                            TextWidget(data: "Add a Review")),
                                  )),
                              AppConstant.kWidth(width: 5),
                              Expanded(
                                  flex: 1,
                                  child: Consumer<ProfileProvider>(
                                      builder: (context, userIdProvider, _) {
                                    return InkWell(
                                      onTap: () {
                                        profileProvider.getBadReview(
                                            traderId:
                                                userIdProvider.qrCodeUserId);
                                      },
                                      child: Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColor.green)),
                                          child:
                                              TextWidget(data: "Bad Review")),
                                    );
                                  }))
                            ],
                          ),
                          ViewReviewScreen(
                            userId: userProvider.currentUserId ?? "",
                            isProfileVisit: false,
                          ),
                        ],
                      ),
                    );
                  })
                : const SizedBox()
            // provider.currentIndex == 2
            //     ? Padding(
            //         padding: const EdgeInsets.symmetric(
            //           horizontal: 15,
            //         ),
            //         child: viewReviews(profileModel: profileModel, size: size),
            //       )
            //     : const SizedBox(),
          ],
        ),
      );
    });
  }

  viewReviews({required TraderProfileModel profileModel, required Size size}) {}
}
