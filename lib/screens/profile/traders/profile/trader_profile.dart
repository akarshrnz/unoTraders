import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:codecarrots_unotraders/model/Feeds/trader_feed_model.dart';
import 'package:codecarrots_unotraders/model/add_post.dart';
import 'package:codecarrots_unotraders/model/offer%20listing/trader_offer_listing.dart';
import 'package:codecarrots_unotraders/provider/current_user_provider.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/Profile/follow_list.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/components/review_circle_widget.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/components/trader_feeds_screen.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/components/trader_offer_screen.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/components/view_review_screen.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/post_an_offer_dialog.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/profile/qr_code_popup.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/profile/trader_profile_edit.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/color.dart';
import '../../../../utils/png.dart';
import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:read_more_text/read_more_text.dart';

import '../../../../utils/color.dart';
import '../../../../utils/png.dart';

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
  final _formKey = GlobalKey<FormState>();
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
      callApi();
    });
  }

  callApi() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    profileProvider.getTraderProfile();
    profileProvider.getFeeds(userType: 'trader', userId: id);
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        title: TextWidget(
          data: 'My Profile',
          style: TextStyle(color: AppColor.blackColor),
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
                            profileModel: provider.traderProfile!)

                    // FutureBuilder<TraderProfileModel>(
                    //     future: ProfileServices.getTraderProfile(id: ApiServicesUrl.id),
                    //     // ApiServicesUrl.id
                    //     builder: (context, AsyncSnapshot<TraderProfileModel> snapshot) {
                    //       if (snapshot.connectionState == ConnectionState.waiting) {
                    //         if (snapshot.hasData) {
                    //           return profileBody(
                    //               context: context,
                    //               size: size,
                    //               profileModel: snapshot.data!);
                    //         } else {
                    //           return SizedBox(
                    //               width: size.width,
                    //               height: size.height,
                    //               child: Center(
                    //                   child: Constant.circularProgressIndicator()));
                    //         }
                    //       } else if (snapshot.connectionState == ConnectionState.done) {
                    //         if (snapshot.hasError) {
                    //           return Center(
                    //             child: TextWidget(data:snapshot.error.toString()),
                    //           );
                    //         } else if (snapshot.hasData) {
                    //           print("started");
                    //           print(snapshot.data!.address);
                    //           return profileBody(
                    //               context: context,
                    //               size: size,
                    //               profileModel: snapshot.data!);
                    //         } else {
                    //           const Center(child: TextWidget(data:"Document does not exist"));
                    //         }
                    //       } else {
                    //         return SizedBox(
                    //             width: size.width,
                    //             height: size.height,
                    //             child:
                    //                 Center(child: Constant.circularProgressIndicator()));
                    //       }
                    //       return SizedBox(
                    //           width: size.width,
                    //           height: size.height,
                    //           child: Center(child: Constant.circularProgressIndicator()));
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
            // Padding(
            // padding: EdgeInsets.symmetric(
            //     horizontal: size.width * .02, vertical: size.width * .01),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           TextWidget(data:
            //             profileModel.name ?? "",
            //             style: const TextStyle(fontWeight: FontWeight.bold),
            //           ),
            //           // TextWidget(data:widget.category),
            //         ],
            //       ),
            //       CircleAvatar(
            //         backgroundColor: AppColor.secondaryColor,
            //         child: TextWidget(data:
            //           profileModel.rating ?? "0",
            //           style: const TextStyle(color: AppColor.whiteBtnColor),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
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
            Row(
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
            // Padding(
            //  padding: EdgeInsets.all(size.width * .02),
            //   child: Row(
            //     children: [
            //       Container(
            //         height: MediaQuery.of(context).size.height * 0.05,
            //         width: MediaQuery.of(context).size.width * 0.67,
            //         decoration: BoxDecoration(
            //           color: AppColor.secondaryColor,
            //           borderRadius: BorderRadius.circular(30.0),
            //         ),
            //         child: Center(
            //             child: TextWidget(data:
            //           'Upcomming Appointment',
            //           style: TextStyle(
            //               color: AppColor.whiteBtnColor,
            //               fontSize: MediaQuery.of(context).size.width * 0.045,
            //              ),
            //         )),
            //       ),
            //     ],
            //   ),
            // ),

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
                                String userType =
                                    sharedPrefs.getString('userType')!;
                                profileProvider.changeTab(index: index);

                                if (index == 0) {
                                  profileProvider.getFeeds(
                                      userType: 'trader', userId: id);
                                } else if (index == 1) {
                                  profileProvider.getOffers(
                                      userType: 'trader', userId: id);
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

  // Widget viewOffers(
  //     {required Size size, required TraderProfileModel profileModel}) {
  //   return

  //   Consumer<ProfileProvider>(
  //       builder: (context, ProfileProvider provider, _) {
  //     return provider.isFeedLoading
  //         ? const Center(child: CircularProgressIndicator())
  //         :
  //         Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Constant.kheight(height: size.width * .012),
  //           InkWell(
  //             onTap: () async {
  //               await showDialog(
  //                 context: context,
  //                 builder: (context) => const PostAnOfferDialog(),
  //               );
  //               setState(() {});
  //             },
  //             child: Container(
  //               alignment: Alignment.center,
  //               height: size.width * .1,
  //               width: size.width,
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(size.width * .04),
  //                   color: AppColor.green,
  //                   border: Border.all(color: AppColor.green)),
  //               child: const TextWidget(data:
  //                 "Post Offer",
  //                 style: TextStyle(color: AppColor.whiteColor),
  //               ),
  //             ),
  //           ),
  //           ListView.separated(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             itemCount: provider.offerListing.length,
  //             separatorBuilder: (context, index) =>
  //                 Constant.kheight(height: size.width * .01),
  //             itemBuilder: (context, index) {
  //             TraderOfferListingModel traderOffer = provider.offerListing[index];

  //               return Card(
  //                 clipBehavior: Clip.antiAlias,
  //                 elevation: 2,
  //                 shadowColor: AppColor.blackColor,
  //                 shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(size.width * .02)),
  //                 child: Padding(
  //                   padding: EdgeInsets.all(size.width * .02),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(children: [
  //                         Expanded(
  //                           child: TextWidget(data:
  //                             traderOffer.title.toString(),
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: size.width * .035),
  //                           ),
  //                         ),
  //                         Container(
  //                           margin: EdgeInsets.all(size.width * 0.02),
  //                           height: size.width * 0.07,
  //                           width: size.width * 0.07,
  //                           decoration: BoxDecoration(
  //                               color: AppColor.green,
  //                               borderRadius:
  //                                   BorderRadius.circular(size.width * 0.02)),
  //                           child: IconButton(
  //                               // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
  //                               icon: FaIcon(
  //                                 FontAwesomeIcons.penToSquare,
  //                                 color: AppColor.whiteColor,
  //                                 size: size.width * 0.04,
  //                               ),
  //                               onPressed: () {}),
  //                         )
  //                       ]),
  //                       const Divider(
  //                         color: Colors.grey,
  //                       ),
  //                       Constant.kheight(height: size.width * .017),
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                               child: DottedBorder(
  //                             color: Colors.black,
  //                             strokeWidth: 1,
  //                             child: Container(
  //                               height: 40,
  //                               child: Row(
  //                                 children: [
  //                                   Expanded(
  //                                       child: Container(
  //                                     alignment: Alignment.center,
  //                                     // decoration: BoxDecoration(
  //                                     //     border: Border.all(color: AppColor.blackColor)),
  //                                     child: TextWidget(data:
  //                                         "Valid From; ${traderOffer.validFrom}"),
  //                                     height: 40,
  //                                   )),
  //                                   const VerticalDivider(),
  //                                   Expanded(
  //                                       child: Container(
  //                                     height: 40,
  //                                     child: TextWidget(data:
  //                                       "Expire; ${traderOffer.validTo}",
  //                                       style: const TextStyle(color: AppColor.red),
  //                                     ),
  //                                     alignment: Alignment.center,
  //                                     // decoration: BoxDecoration(
  //                                     //     border: Border.all(color: AppColor.blackColor)),
  //                                   ))
  //                                 ],
  //                               ),
  //                             ),
  //                           ))
  //                         ],
  //                       ),
  //                       Constant.kheight(height: size.width * .017),
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                               child: Container(
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Container(
  //                                   alignment: Alignment.center,
  //                                   height: size.width * .05,
  //                                   width: size.width * .3,
  //                                   decoration: BoxDecoration(
  //                                       borderRadius:
  //                                           BorderRadius.circular(size.width * .01),
  //                                       color: const Color(0XFFFCE9C8)),
  //                                   child: TextWidget(data:
  //                                       "Offer Price \$ ${traderOffer.discountPrice.toString()}"),
  //                                 ),
  //                                 Container(
  //                                   alignment: Alignment.center,
  //                                   height: size.width * .05,
  //                                   width: size.width * .3,
  //                                   decoration: BoxDecoration(
  //                                       borderRadius:
  //                                           BorderRadius.circular(size.width * .01),
  //                                       color: const Color(0XFFDAFAD3)),
  //                                   child: TextWidget(data:
  //                                       "Full Price \$ ${traderOffer.fullPrice.toString()}"),
  //                                 ),
  //                               ],
  //                             ),
  //                           ))
  //                         ],
  //                       ),
  //                       Constant.kheight(height: size.width * .017),

  //                       SizedBox(
  //                           width: size.width,
  //                           height: size.height * .25,
  //                           child: Container(
  //                             child: CarouselSlider.builder(
  //                                 itemCount: traderOffer.traderofferimages!.length,
  //                                 itemBuilder: (context, cIndex, realIndex) {
  //                                   final image = traderOffer.traderofferimages![cIndex];
  //                                   return Container(
  //                                     padding: const EdgeInsets.only(right: 5),
  //                                     child: ClipRRect(
  //                                       borderRadius: BorderRadius.circular(15),
  //                                       child: Image.network(image,
  //                                           fit: BoxFit.fill,
  //                                           width: size.width * .9),
  //                                     ),
  //                                   );
  //                                 },
  //                                 options: CarouselOptions(
  //                                   padEnds: false,
  //                                   scrollPhysics: const BouncingScrollPhysics(),
  //                                   clipBehavior: Clip.antiAlias,
  //                                   enableInfiniteScroll: false,
  //                                   autoPlayAnimationDuration:
  //                                       const Duration(milliseconds: 200),
  //                                   viewportFraction: .56,
  //                                   height: size.width * .5,
  //                                   autoPlay: false,
  //                                   reverse: false,
  //                                   autoPlayInterval: const Duration(seconds: 5),
  //                                 )),
  //                           )),
  //                       Constant.kheight(height: size.width * .012),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         children: [
  //                           Flexible(
  //                             child: ReadMoreText(
  //                               traderOffer.description.toString(),
  //                               numLines: 3,
  //                               readMoreIconColor: AppColor.green,
  //                               readMoreAlign: Alignment.centerLeft,
  //                               style: TextStyle(fontSize: size.width * .033),
  //                               readMoreTextStyle: TextStyle(
  //                                   fontSize: size.width * .033,
  //                                   color: AppColor.green),
  //                               readMoreText: 'Read More',
  //                               readLessText: 'Read Less',
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       // SizedBox(
  //                       //   height: size.height * .25,
  //                       //   width: size.width,
  //                       //   child: Row(
  //                       //     children: [
  //                       //       SizedBox(
  //                       //           width: size.width * .6,
  //                       //           height: size.height * .25,
  //                       //           child: CarouselSlider.builder(
  //                       //             itemCount: traderOffer.offerImages!.length,
  //                       //             itemBuilder: (context, cIndex, realIndex) {
  //                       // final image =
  //                       //     traderOffer.offerImages![cIndex];
  //                       //               return Padding(
  //                       //                 padding: const EdgeInsets.only(right: 5.0),
  //                       //                 child: ClipRRect(
  //                       //                     borderRadius: BorderRadius.circular(
  //                       //                         size.width * .03),
  //                       //                     child: Image.network(
  //                       //                       image,
  //                       //                       fit: BoxFit.fill,
  //                       //                     )),
  //                       //               );
  //                       //             },
  //                       //             options: CarouselOptions(
  //                       //                 clipBehavior: Clip.antiAlias,
  //                       //                 scrollPhysics:
  //                       //                     const BouncingScrollPhysics(),
  //                       //                 enableInfiniteScroll: false,
  //                       //                 reverse: false,
  //                       //                 padEnds: false,
  //                       //                 autoPlay: true,
  //                       //                 viewportFraction: .56),
  //                       //           )
  //                       //           // ListView.builder(
  //                       //           //   shrinkWrap: true,
  //                       //           //   scrollDirection: Axis.horizontal,
  //                       //           //   itemCount: traderOffer.offerImages!.length,
  //                       //           //   itemBuilder: (context, index) {
  //                       //           //     final image = traderOffer.offerImages![index];
  //                       //           //     return Container(
  //                       //           //       padding: EdgeInsets.all(size.width * .005),
  //                       //           //       child: ImgFade.fadeImage(url: image),
  //                       //           //     );
  //                       //           //   },
  //                       //           // ),
  //                       //           ),
  //                       //       // Expanded(
  //                       //       //   child: Column(
  //                       //       //     crossAxisAlignment: CrossAxisAlignment.center,
  //                       //       //     mainAxisAlignment: MainAxisAlignment.center,
  //                       //       //     children: [
  //                       //       //       TextWidget(data:
  //                       //       //         "Price",
  //                       //       //         style: TextStyle(fontSize: size.width * .03),
  //                       //       //       ),
  //                       //       //       TextWidget(data:
  //                       //       //         "\$ ${traderOffer.fullPrice.toString()}",
  //                       //       //         style: const TextStyle(
  //                       //       //             decoration: TextDecoration.lineThrough),
  //                       //       //       ),
  //                       //       //       Constant.kheight(height: size.width * .012),
  //                       //       //       TextWidget(data:"Discount Price",
  //                       //       //           style:
  //                       //       //               TextStyle(fontSize: size.width * .03)),
  //                       //       //       TextWidget(data:
  //                       //       //         "\$ ${traderOffer.discountPrice.toString()}",
  //                       //       //         style: TextStyle(
  //                       //       //             color: AppColor.green,
  //                       //       //             fontSize: size.width * .035),
  //                       //       //       ),
  //                       //       //     ],
  //                       //       //   ),
  //                       //       // )
  //                       //     ],
  //                       //   ),
  //                       // ),
  //                       Constant.kheight(height: size.width * .01),
  //                       // Row(
  //                       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       //   children: [
  //                       //     Container(
  //                       //       alignment: Alignment.center,
  //                       //       height: size.width * .075,
  //                       //       width: size.width * .43,
  //                       //       decoration: BoxDecoration(
  //                       //           borderRadius:
  //                       //               BorderRadius.circular(size.width * .04),
  //                       //           border: Border.all(color: AppColor.green)),
  //                       //       child: Column(
  //                       //         children: [
  //                       //           const TextWidget(data:"Valid From "),
  //                       //           TextWidget(data:"${traderOffer.validFrom}"),
  //                       //         ],
  //                       //       ),
  //                       //     ),
  //                       //     Container(
  //                       //       alignment: Alignment.center,
  //                       //       height: size.width * .075,
  //                       //       width: size.width * .43,
  //                       //       decoration: BoxDecoration(
  //                       //           borderRadius:
  //                       //               BorderRadius.circular(size.width * .04),
  //                       //           border: Border.all(color: AppColor.green)),
  //                       //       child: Column(
  //                       //         children: [
  //                       //           const TextWidget(data:"Valid Expire"),
  //                       //           TextWidget(data:"${traderOffer.validTo}"),
  //                       //         ],
  //                       //       ),
  //                       //     ),
  //                       //   ],
  //                       // ),
  //                       // Constant.kheight(height: size.width * .03),
  //                       const Divider(),
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                               child: Container(
  //                             child: Row(
  //                               children: [
  //                                 InkWell(
  //                                   onTap: () {},
  //                                   child: Container(
  //                                       alignment: Alignment.center,
  //                                       height: size.width * .07,
  //                                       width: size.width * .1,
  //                                       decoration: BoxDecoration(
  //                                           border: Border.all(color: Colors.grey),
  //                                           boxShadow: const [
  //                                             BoxShadow(
  //                                                 color: Colors.white,
  //                                                 spreadRadius: 1)
  //                                           ],
  //                                           borderRadius:
  //                                               BorderRadius.circular(15)),
  //                                       child: const FaIcon(
  //                                         FontAwesomeIcons.thumbsUp,
  //                                         color: AppColor.primaryColor,
  //                                       )),
  //                                 ),
  //                                 Constant.kWidth(width: size.width * .03),
  //                                 InkWell(
  //                                   onTap: () {},
  //                                   child: Container(
  //                                       alignment: Alignment.center,
  //                                       height: size.width * .07,
  //                                       width: size.width * .1,
  //                                       decoration: BoxDecoration(
  //                                           border: Border.all(color: Colors.grey),
  //                                           boxShadow: const [
  //                                             BoxShadow(
  //                                                 color: Colors.white,
  //                                                 spreadRadius: 1)
  //                                           ],
  //                                           borderRadius:
  //                                               BorderRadius.circular(15)),
  //                                       child: FaIcon(
  //                                         FontAwesomeIcons.commentDots,
  //                                         color: AppColor.primaryColor,
  //                                       )),
  //                                 ),
  //                               ],
  //                             ),
  //                           ))
  //                         ],
  //                       ),
  //                       // CircleAvatar(
  //                       //     radius: size.width * .03,
  //                       //     backgroundColor: AppColor.green,
  //                       //     child: Icon(
  //                       //       Icons.thumb_up,
  //                       //       size: size.width * .034,
  //                       //       color: AppColor.whiteColor,
  //                       //     )),
  //                       // Constant.kheight(height: size.width * .02),
  //                       // Row(
  //                       //   children: [
  //                       //     TextWidget(data:"Likes ()"),
  //                       //     Constant.kWidth(width: size.width * .01),
  //                       //     const TextWidget(data:"Comments")
  //                       //   ],
  //                       // )
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           )
  //         ],
  //        );
  //      }
  //    );
  // }

  Widget viewReviews(
      {required Size size, required TraderProfileModel profileModel}) {
    return Column(
      children: [
        AppConstant.kheight(height: size.width * .012),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.center,
              height: size.width * .07,
              width: size.width * .4,
              decoration:
                  BoxDecoration(border: Border.all(color: AppColor.green)),
              child: TextWidget(data: "Review Notification (0)"),
            ),
            Container(
              alignment: Alignment.center,
              height: size.width * .07,
              width: size.width * .4,
              decoration:
                  BoxDecoration(border: Border.all(color: AppColor.green)),
              child: TextWidget(data: "Bad Review"),
            ),
          ],
        )
      ],
    );
  }

  // Widget viewPost({
  //   required Size size,
  // }) {
  //   return Consumer<ProfileProvider>(
  //       builder: (context, ProfileProvider provider, _) {
  //     return provider.isFeedLoading
  //         ? const Center(child: CircularProgressIndicator())
  //         : Form(
  //             key: _formKey,
  //             child: Column(
  //               children: [
  //                 //post title
  //                 Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: size.width * .02),
  //                   child: TextFieldWidget(
  //                       focusNode: postTitleFocus,
  //                       controller: postTitleController,
  //                       hintText: "Post Title",
  //                       textInputAction: TextInputAction.next,
  //                       onFieldSubmitted: (p0) {
  //                         postTitleFocus.unfocus();
  //                         FocusScope.of(context).requestFocus(descriptionFocus);
  //                       },
  //                       onEditingComplete: () =>
  //                           FocusScope.of(context).nextFocus(),
  //                       validate: (value) {
  //                         if (value == null || value.isEmpty) {
  //                           return "This field is required";
  //                         } else {
  //                           return null;
  //                         }
  //                       }),
  //                 ),
  //                 Constant.kheight(height: size.width * .017),
  //                 //description
  //                 Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: size.width * .02),
  //                   child: TextFieldWidget(
  //                       focusNode: descriptionFocus,
  //                       controller: descriptionController,
  //                       hintText: "Product",
  //                       textInputAction: TextInputAction.next,
  //                       onFieldSubmitted: (p0) {
  //                         descriptionFocus.unfocus();
  //                       },
  //                       onEditingComplete: () =>
  //                           FocusScope.of(context).nextFocus(),
  //                       validate: (value) {
  //                         if (value == null || value.isEmpty) {
  //                           return "This field is required";
  //                         } else {
  //                           return null;
  //                         }
  //                       }),
  //                 ),
  //                 //add photo

  //                 Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: size.width * .02),
  //                   child: Consumer<ImagePickProvider>(
  //                       builder: (context, imageProvider, _) {
  //                     return imageProvider.images.isEmpty == true
  //                         ? Constant.kheight(height: 10)
  //                         : Container(
  //                             margin: const EdgeInsets.symmetric(vertical: 8),
  //                             height: imageProvider.images.isEmpty == true
  //                                 ? 0
  //                                 : 170,
  //                             width: MediaQuery.of(context).size.width,
  //                             decoration: BoxDecoration(
  //                               color: AppColor.whiteColor,
  //                               borderRadius: BorderRadius.circular(20),
  //                             ),
  //                             child: ListView.builder(
  //                               scrollDirection: Axis.horizontal,
  //                               shrinkWrap: true,
  //                               // gridDelegate:
  //                               //     const SliverGridDelegateWithFixedCrossAxisCount(
  //                               //   crossAxisCount: 2,
  //                               // ),
  //                               itemCount: imageProvider.images.length,
  //                               itemBuilder: (BuildContext context, int index) {
  //                                 return Padding(
  //                                   padding: const EdgeInsets.all(5.0),
  //                                   child: Stack(
  //                                     children: [
  //                                       Container(
  //                                         decoration: BoxDecoration(
  //                                             border: Border.all(
  //                                                 color: Colors.black)),
  //                                         child: Image.file(
  //                                           File(imageProvider
  //                                               .images[index].path),
  //                                           height: 190,
  //                                           width: 150,
  //                                           fit: BoxFit.cover,
  //                                         ),
  //                                       ),
  //                                       Positioned(
  //                                         top: 0,
  //                                         right: 1,
  //                                         child: IconButton(
  //                                             onPressed: () {
  //                                               imageProvider.remove(index);
  //                                             },
  //                                             icon: const Icon(
  //                                                 Icons.cancel_outlined)),
  //                                       )
  //                                     ],
  //                                   ),
  //                                 );
  //                               },
  //                             ),
  //                           );
  //                   }),
  //                 ),

  //                 Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: size.width * .02),
  //                   child: SizedBox(
  //                     height: 50,
  //                     width: size.width,
  //                     child: ElevatedButton.icon(
  //                       label: TextWidget(data:
  //                         "Choose Images",
  //                         style: TextStyle(color: Colors.grey[700]),
  //                       ),
  //                       onPressed: () {
  //                         imagePickProvider.pickImage();
  //                       },
  //                       style: ElevatedButton.styleFrom(
  //                           elevation: 0,
  //                           alignment: Alignment.centerLeft,
  //                           side: const BorderSide(
  //                             color: Colors.grey,
  //                           ),
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(5)),
  //                           backgroundColor: AppColor.whiteColor),
  //                       icon: const FaIcon(
  //                         FontAwesomeIcons.images,
  //                         color: Colors.green,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Constant.kheight(height: size.width * .017),
  //                 //post button
  //                 isLoading == true
  //                     ? Constant.circularProgressIndicator()
  //                     : Consumer<ImagePickProvider>(
  //                         builder: (context, provider, _) {
  //                         return Padding(
  //                           padding: EdgeInsets.symmetric(
  //                               horizontal: size.width * .02),
  //                           child: DefaultButton(
  //                               text: "Post",
  //                               onPress: () async {
  //                                 if (_formKey.currentState!.validate() &&
  //                                     provider.imageFile.isNotEmpty) {
  //                                   setState(() {
  //                                     isLoading = true;
  //                                   });

  //                                   AddPostModel postModel = AddPostModel(
  //                                       postTitle: postTitleController.text
  //                                           .trim()
  //                                           .toString(),
  //                                       postContent: descriptionController.text
  //                                           .trim()
  //                                           .toString(),
  //                                       postImages: provider.imageFile,
  //                                       traderId: int.parse(ApiServicesUrl.id));
  //                                   await profileProvider
  //                                       .addPost(addPost: postModel)
  //                                       .then((value) {
  //                                     clearField();
  //                                     Constant.toastMsg(
  //                                         msg: "Post Added Successfully",
  //                                         backgroundColor: AppColor.green);
  //                                     return;
  //                                   }).onError((error, stackTrace) {
  //                                     Constant.toastMsg(
  //                                         msg: "Something Went Wrong",
  //                                         backgroundColor: AppColor.red);

  //                                     return;
  //                                   });
  //                                 } else {
  //                                   Constant.toastMsg(
  //                                       msg: "Please fill all the Fields",
  //                                       backgroundColor: AppColor.red);
  //                                 }
  //                                 setState(() {
  //                                   isLoading = false;
  //                                 });
  //                               },
  //                               radius: size.width * .01),
  //                         );
  //                       }),
  //                 Constant.kheight(height: size.width * .017),
  //                 ListView.separated(
  //                   shrinkWrap: true,
  //                   physics: const NeverScrollableScrollPhysics(),
  //                   itemCount: provider.feed.length,
  //                   separatorBuilder: (context, index) =>
  //                       Constant.kheight(height: size.width * .01),
  //                   itemBuilder: (context, index) {
  //                     TraderFeedModel traderPost = provider.feed[index];
  //                     DateTime createdAt =
  //                         DateTime.parse(traderPost.createdAt!);

  //                     return Card(
  //                       clipBehavior: Clip.antiAlias,
  //                       elevation: 2,
  //                       shadowColor: AppColor.blackColor,
  //                       shape: RoundedRectangleBorder(
  //                           borderRadius:
  //                               BorderRadius.circular(size.width * .02)),
  //                       child: Padding(
  //                         padding: EdgeInsets.all(size.width * .02),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Row(children: [
  //                               Expanded(
  //                                 child: TextWidget(data:
  //                                   traderPost.title.toString(),
  //                                   style: TextStyle(
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: size.width * .035),
  //                                 ),
  //                               ),
  //                               Container(
  //                                 margin: EdgeInsets.all(size.width * 0.02),
  //                                 height: size.width * 0.07,
  //                                 width: size.width * 0.07,
  //                                 decoration: BoxDecoration(
  //                                     color: AppColor.green,
  //                                     borderRadius: BorderRadius.circular(
  //                                         size.width * 0.02)),
  //                                 child: IconButton(
  //                                     // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
  //                                     icon: FaIcon(
  //                                       FontAwesomeIcons.penToSquare,
  //                                       color: AppColor.whiteColor,
  //                                       size: size.width * 0.04,
  //                                     ),
  //                                     onPressed: () {}),
  //                               )
  //                             ]),
  //                             const Divider(
  //                               color: Colors.grey,
  //                             ),
  //                             SizedBox(
  //                               width: size.width,
  //                               child: Row(
  //                                 children: [
  //                                   Container(
  //                                     padding: EdgeInsets.all(size.width * .01),
  //                                     height: size.width * .07,
  //                                     alignment: Alignment.center,
  //                                     decoration: BoxDecoration(
  //                                         border:
  //                                             Border.all(color: AppColor.green),
  //                                         borderRadius: BorderRadius.circular(
  //                                             size.width * .03)),
  //                                     child: Center(
  //                                       child: Row(
  //                                         children: [
  //                                           Padding(
  //                                             padding: EdgeInsets.all(
  //                                                 size.width * .01),
  //                                             child: Icon(
  //                                               Icons.calendar_month_outlined,
  //                                               color: AppColor.green,
  //                                               size: size.width * .03,
  //                                             ),
  //                                           ),
  //                                           Constant.kWidth(
  //                                               width: size.width * .01),
  //                                           TextWidget(data:
  //                                               '${createdAt.day}/${createdAt.month}/${createdAt.year}'),
  //                                           Constant.kWidth(
  //                                               width: size.width * .02),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   Constant.kWidth(width: size.width * .03),
  //                                   //full price
  //                                   Container(
  //                                     height: size.width * .07,
  //                                     alignment: Alignment.center,
  //                                     decoration: BoxDecoration(
  //                                         border:
  //                                             Border.all(color: AppColor.green),
  //                                         borderRadius: BorderRadius.circular(
  //                                             size.width * .03)),
  //                                     child: Row(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.start,
  //                                       children: [
  //                                         Padding(
  //                                           padding: EdgeInsets.all(
  //                                               size.width * .01),
  //                                           child: Icon(
  //                                             Icons.access_time,
  //                                             size: size.width * .03,
  //                                             color: AppColor.green,
  //                                           ),
  //                                         ),
  //                                         Constant.kWidth(
  //                                             width: size.width * .01),
  //                                         TextWidget(data:DateFormat('hh:mm a')
  //                                             .format(createdAt)),
  //                                         Constant.kWidth(
  //                                             width: size.width * .03),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             Constant.kheight(height: size.width * .017),

  //                             SizedBox(
  //                                 width: size.width,
  //                                 height: size.height * .25,
  //                                 child: Container(
  //                                   child: CarouselSlider.builder(
  //                                       itemCount:
  //                                           traderPost.postImages!.length,
  //                                       itemBuilder:
  //                                           (context, carIndex, realIndex) {
  //                                         return Container(
  //                                           padding:
  //                                               const EdgeInsets.only(right: 5),
  //                                           child: ClipRRect(
  //                                             borderRadius:
  //                                                 BorderRadius.circular(
  //                                                     size.width * .02),
  //                                             child: Image.network(
  //                                               traderPost
  //                                                   .postImages![carIndex],
  //                                               fit: BoxFit.cover,
  //                                               // width:
  //                                               //     traderPost.postImages!.length == 1
  //                                               //         ? size.width * .9
  //                                               //         : null,
  //                                             ),
  //                                           ),
  //                                         );
  //                                       },
  //                                       options: CarouselOptions(
  //                                         padEnds: false,
  //                                         scrollPhysics:
  //                                             const BouncingScrollPhysics(),
  //                                         clipBehavior: Clip.antiAlias,
  //                                         enableInfiniteScroll: false,
  //                                         autoPlayAnimationDuration:
  //                                             const Duration(milliseconds: 200),
  //                                         viewportFraction: .56,
  //                                         height: size.width * .5,
  //                                         autoPlay: false,
  //                                         reverse: false,
  //                                         autoPlayInterval:
  //                                             const Duration(seconds: 5),
  //                                       )),
  //                                 )

  //                                 // ListView.separated(
  //                                 //   separatorBuilder: (context, index) => SizedBox(
  //                                 //     width: size.width * .01,
  //                                 //   ),
  //                                 //   shrinkWrap: true,
  //                                 //   scrollDirection: Axis.horizontal,
  //                                 //   itemCount: traderPost.postImages == null
  //                                 //       ? 0
  //                                 //       : traderPost.postImages!.length,
  //                                 //   itemBuilder: (context, index) {
  //                                 //     return

  //                                 //      Container(
  //                                 //         child: Image.network(
  //                                 //             traderPost.postImages![index],
  //                                 //             width: size.width * .9)
  //                                 //         //  ImgFade.fadeImage(
  //                                 //         //     width: size.width * .9,
  //                                 //         //     url: traderPost.postImages![index]),
  //                                 //         );
  //                                 //   },
  //                                 // ),
  //                                 ),
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.start,
  //                               children: [
  //                                 Flexible(
  //                                   child: ReadMoreText(
  //                                     traderPost.postContent.toString(),
  //                                     readMoreIconColor: AppColor.green,
  //                                     numLines: 3,
  //                                     readMoreAlign: Alignment.centerLeft,
  //                                     style: TextStyle(
  //                                         fontSize: size.width * .033),
  //                                     readMoreTextStyle: TextStyle(
  //                                         fontSize: size.width * .033,
  //                                         color: Colors.green),
  //                                     readMoreText: 'Read More',
  //                                     readLessText: 'Read Less',
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),

  //                             const Divider(),
  //                             Row(
  //                               children: [
  //                                 Expanded(
  //                                     child: Container(
  //                                   child: Row(
  //                                     children: [
  //                                       InkWell(
  //                                         onTap: () {},
  //                                         child: Container(
  //                                             alignment: Alignment.center,
  //                                             height: size.width * .07,
  //                                             width: size.width * .1,
  //                                             decoration: BoxDecoration(
  //                                                 border: Border.all(
  //                                                     color: Colors.grey),
  //                                                 boxShadow: const [
  //                                                   BoxShadow(
  //                                                       color: Colors.white,
  //                                                       spreadRadius: 1)
  //                                                 ],
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(
  //                                                         15)),
  //                                             child: const FaIcon(
  //                                               FontAwesomeIcons.thumbsUp,
  //                                               color: AppColor.primaryColor,
  //                                             )),
  //                                       ),
  //                                       Constant.kWidth(
  //                                           width: size.width * .03),
  //                                       InkWell(
  //                                         onTap: () {},
  //                                         child: Container(
  //                                             alignment: Alignment.center,
  //                                             height: size.width * .07,
  //                                             width: size.width * .1,
  //                                             decoration: BoxDecoration(
  //                                                 border: Border.all(
  //                                                     color: Colors.grey),
  //                                                 boxShadow: const [
  //                                                   BoxShadow(
  //                                                       color: Colors.white,
  //                                                       spreadRadius: 1)
  //                                                 ],
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(
  //                                                         15)),
  //                                             child: FaIcon(
  //                                               FontAwesomeIcons.commentDots,
  //                                               color: AppColor.primaryColor,
  //                                             )),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ))
  //                               ],
  //                             ),
  //                             // CircleAvatar(
  //                             //     radius: size.width * .03,
  //                             //     backgroundColor: AppColor.green,
  //                             //     child: Icon(
  //                             //       Icons.thumb_up,
  //                             //       size: size.width * .034,
  //                             //       color: AppColor.whiteColor,
  //                             //     )),
  //                             // Constant.kheight(height: size.width * .02),
  //                             // Row(
  //                             //   children: [
  //                             //     const TextWidget(data:"Likes (0)"),
  //                             //     Constant.kWidth(width: size.width * .01),
  //                             //     const TextWidget(data:"Comments")
  //                             //   ],
  //                             // )
  //                           ],
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ],
  //             ),
  //           );
  //   });
  // }
}
