import 'package:cached_network_image/cached_network_image.dart';
import 'package:codecarrots_unotraders/provider/current_user_provider.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/Profile/follow_list.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/components/review_circle_widget.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/components/trader_feeds_screen.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/components/trader_offer_screen.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/components/view_review_screen.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/profile/qr_code_popup.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/profile/Trader%20Profile%20Edit/trader_profile_edit_main_screen.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/color.dart';
import '../../../../utils/png.dart';
import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:flutter/foundation.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TraderProfile extends StatefulWidget {
  const TraderProfile({Key? key}) : super(key: key);

  @override
  _TraderProfileState createState() => _TraderProfileState();
}

class _TraderProfileState extends State<TraderProfile> {
  late ImagePickProvider imagePickProvider;
  late ProfileProvider profileProvider;
  // int currentIndex = 0;
  List<String> title = ["View Post", "View Offers", "View Reviews"];
  late FocusNode postTitleFocus;
  late FocusNode descriptionFocus;
  late TextEditingController postTitleController;
  late TextEditingController descriptionController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    imagePickProvider = Provider.of<ImagePickProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.clear();
    imagePickProvider.initialValues();
    initialize();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callApi(context);
    });
  }

  callApi(BuildContext context) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;

    profileProvider.getTraderProfile(context: context);
    print("call trader profile");
    profileProvider.getFeeds(urlUserType: 'trader', traderId: id);
  }

  initialize() {
    postTitleFocus = FocusNode();
    descriptionFocus = FocusNode();
    postTitleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    postTitleFocus.dispose();
    descriptionFocus.dispose();
    postTitleController.dispose();
    descriptionController.dispose();
  }

  clearField() {
    postTitleController.clear();
    descriptionController.clear();
    imagePickProvider.clearImage();
    postTitleFocus.unfocus();
    descriptionFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print("trader profile build");
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        title: TextWidget(
          data: 'My Profile',
          style: const TextStyle(color: AppColor.blackColor),
        ),
      ),
      body: Consumer<ProfileProvider>(
          builder: (context, ProfileProvider provider, _) {
        return provider.isLoading
            ? Center(child: AppConstant.circularProgressIndicator())
            : provider.errorMessage.isNotEmpty
                ? Center(
                    child: TextWidget(data: "Something Went Wrong"),
                  )
                : SingleChildScrollView(
                    child: provider.traderProfile == null
                        ? const SizedBox()
                        : profileBody(
                            context: context,
                            size: size,
                            profileModel: provider.traderProfile!));
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

    return Padding(
      padding: EdgeInsets.only(
          left: size.width * .02,
          right: size.width * .02,
          top: size.width * .02),
      child: Consumer<ProfileProvider>(
          builder: (context, ProfileProvider provider, _) {
        return Column(
          children: [
            Card(
              shadowColor: Colors.grey,
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.all(size.width * .02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        profileModel.profilePic!.isNotEmpty
                            ? CircleAvatar(
                                backgroundColor: AppColor.green,
                                radius:
                                    MediaQuery.of(context).size.width * 0.07,
                                child: CircleAvatar(
                                  backgroundColor: AppColor.whiteColor,
                                  radius:
                                      MediaQuery.of(context).size.width * 0.066,
                                  child: CircleAvatar(
                                    backgroundColor: AppColor.whiteColor,
                                    radius: MediaQuery.of(context).size.width *
                                        0.06,
                                    backgroundImage: CachedNetworkImageProvider(
                                      profileModel.profilePic!,
                                    ),
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.06,
                                child: Image.asset(
                                  PngImages.profile,
                                ),
                              ),
                        Container(
                          margin: EdgeInsets.all(size.width * 0.02),
                          height: size.width * 0.07,
                          width: size.width * 0.07,
                          decoration: BoxDecoration(
                              color: AppColor.green,
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.02)),
                          child: IconButton(
                              // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                              icon: FaIcon(
                                FontAwesomeIcons.penToSquare,
                                color: AppColor.whiteColor,
                                size: size.width * 0.04,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: TraderProfileEdit(
                                            profileModel: profileModel,
                                            traderId: profileModel.id == null
                                                ? ""
                                                : profileModel.id.toString())));
                              }),
                        ),
                      ],
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
                            Consumer<CurrentUserProvider>(builder: (context,
                                CurrentUserProvider currentUserProvider, _) {
                              return TextWidget(
                                  data:
                                      '${currentUserProvider.currentUserType}',style: TextStyle(fontWeight: FontWeight.bold),);
                            }),
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
                        // const Padding(
                        //   padding: EdgeInsets.all(8.0),
                        //   child: Icon(
                        //     Icons.qr_code,
                        //     color: AppColor.blackColor,
                        //   ),
                        // )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .03, vertical: size.width * .017),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        data: profileModel.name ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextWidget(
                        data: profileModel.mainCategory ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .017),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: FollowList(
                                  id: "",
                                  type: "trader",
                                  isFollow: true,
                                  endPoints: 'traderfollowlist',
                                )));
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
                                size: size.width * .06,
                                color: AppColor.green,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    data: 'Follow',
                                    style: TextStyle(
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                  TextWidget(
                                    data: profileModel.following.toString(),
                                    style: TextStyle(
                                        color: AppColor.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04),
                                  ),
                                ],
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: FollowList(
                                  id: "",
                                  type: "trader",
                                  isFollow: false,
                                  endPoints: 'traderfavouritelist',
                                )));
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
                                color: AppColor.secondaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    data: 'Favourites',
                                    style: TextStyle(
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                  TextWidget(
                                    data: profileModel.favorites.toString(),
                                    style: TextStyle(
                                        color: AppColor.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04),
                                  ),
                                ],
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReviewCircleWidget(
                    backgroundColor: Color(0XFFD4B83E),
                    title: "Average score",
                    rating: profileModel.avgScore ?? "0"),
                ReviewCircleWidget(
                    backgroundColor: Color(0XFFFF8A65),
                    title: "Reliability",
                    rating: profileModel.avgScore ?? "0"),
                ReviewCircleWidget(
                    backgroundColor: Color(0XFFEF5350),
                    title: "Courtesy",
                    rating: profileModel.courScore ?? "0"),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReviewCircleWidget(
                    backgroundColor: Color(0XFF467CAB),
                    title: "Tidiness",
                    rating: profileModel.tidiScore ?? "0"),
                ReviewCircleWidget(
                    backgroundColor: Color(0XFF3F51B5),
                    title: "Workmanship",
                    rating: profileModel.workScore ?? "0"),
                ReviewCircleWidget(
                    backgroundColor: Color(0XFF66BB6A),
                    title: "Pricing",
                    rating: profileModel.pricScore ?? "0"),
              ],
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
                  const Icon(Icons.call_outlined),
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
                  const Icon(Icons.mail_outline),
                  AppConstant.kWidth(width: size.width * .02),
                  TextWidget(data: profileModel.email.toString()),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            // Padding(
            //   padding: EdgeInsets.all(size.width * .02),
            //   child: Row(
            //     children: [
            //       const Icon(Icons.signal_cellular_connected_no_internet_0_bar),
            //       Constant.kWidth(width: size.width * .02),
            //       TextWidget(data:profileModel.webUrl.toString()),
            //     ],
            //   ),
            // ),
            // const Divider(
            //   color: Colors.grey,
            // ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.location_on),
                  AppConstant.kWidth(width: size.width * .02),
                  Expanded(
                      child:
                          TextWidget(data: profileModel.location.toString())),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            AppConstant.kheight(height: size.width * .02),

            Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                width: size.width,
                height: size.height * .05,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        title.length,
                        (index) => InkWell(
                              onTap: () async {
                                final sharedPrefs =
                                    await SharedPreferences.getInstance();
                                String id = sharedPrefs.getString('id')!;

                                profileProvider.changeTab(index: index);

                                if (index == 0) {
                                  // profileProvider.getFeeds(
                                  //     userType: 'trader', userId: id);
                                  profileProvider.getFeeds(
                                      urlUserType: 'trader', traderId: id);
                                } else if (index == 1) {
                                  profileProvider.getOffers(
                                      urlUserType: 'trader', traderId: id);
                                } else if (index == 2) {
                                  profileProvider.getReview(traderId: id);
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
                            )).toList())),
            provider.currentIndex == 0
                ? Consumer<CurrentUserProvider>(
                    builder: (context, userProvider, _) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TraderFeedScreen(
                        isCustomer: false,
                        userid: userProvider.currentUserId ?? "",
                        isProfileVisit: false,
                      ),
                    );
                  })
                : const SizedBox(),
            provider.currentIndex == 1
                ? Consumer<CurrentUserProvider>(
                    builder: (context, userProvider, _) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TraderOfferScreen(
                        userid: userProvider.currentUserId ?? "",
                        isProfileVisit: false,
                      ),
                    );
                  })
                : const SizedBox(),
            provider.currentIndex == 2
                ? Consumer<CurrentUserProvider>(
                    builder: (context, userProvider, _) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * .03),
                      child: ViewReviewScreen(
                        userId: userProvider.currentUserId ?? "",
                        isProfileVisit: false,
                      ),
                    );
                  })
                : const SizedBox(),
          ],
        );
      }),
    );
  }
}
