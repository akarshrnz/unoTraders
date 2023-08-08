import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:codecarrots_unotraders/model/Feeds/trader_feed_model.dart';
import 'package:codecarrots_unotraders/model/bazaar_model.dart';
import 'package:codecarrots_unotraders/model/feed_reaction_model.dart';
import 'package:codecarrots_unotraders/model/offer%20listing/trader_offer_listing.dart';
import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';
import 'package:codecarrots_unotraders/provider/current_user_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/components/bazaar_items.dart';
import 'package:codecarrots_unotraders/screens/Profile/comment%20section/comment_screen.dart';
import 'package:codecarrots_unotraders/screens/Profile/customer/edit_customer_profile.dart';
import 'package:codecarrots_unotraders/screens/Profile/follow_list.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/components/trader_feeds_screen.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/components/trader_offer_screen.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/utils/circular_progress.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/color.dart';
import '../../../utils/png.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key}) : super(key: key);

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  List<String> title = ["Feeds", "Offers", "Market or Bazaar"];
  // int currentIndex = 0;
  late ProfileProvider profileProvider;
  late BazaarProvider bazaarProvider;

  @override
  void initState() {
    super.initState();
    bazaarProvider = Provider.of<BazaarProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.clear();
    bazaarProvider.intialValue();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileProvider.clear();
      callApi();
    });
    // locationProvider.initalizeLocation();
    // locationProvider.clearAll();
  }

  fetchProfile(ProfileProvider profileProvider) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileProvider.clear();
      callApi();
    });
  }

  callApi() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    profileProvider.getCustomerProfile(userId: id);
    profileProvider.getFeeds(urlUserType: 'customer', traderId: null);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        title: TextWidget(
          data: 'My Profile',
          style: TextStyle(color: AppColor.blackColor),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          profileProvider.clear();
          callApi();
        },
        child: Consumer<ProfileProvider>(
            builder: (context, ProfileProvider provider, _) {
          return provider.isLoading == true
              ? AppConstant.circularProgressIndicator()
              : provider.errorMessage.isNotEmpty
                  ? Center(child: TextWidget(data: provider.errorMessage))
                  : provider.customerProfile == null
                      ? const Center(child: SizedBox())
                      : SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .02),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              provider
                                                          .customerProfile!
                                                          .profilePic!
                                                          .isNotEmpty ==
                                                      true
                                                  ? CircleAvatar(
                                                      radius: size.width * 0.08,
                                                      child: CircleAvatar(
                                                        radius:
                                                            size.width * 0.075,
                                                        backgroundColor:
                                                            AppColor.whiteColor,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              AppColor
                                                                  .whiteColor,
                                                          radius:
                                                              size.width * 0.07,
                                                          backgroundImage:
                                                              NetworkImage(provider
                                                                      .customerProfile!
                                                                      .profilePic ??
                                                                  ""),
                                                        ),
                                                      ),
                                                    )
                                                  : CircleAvatar(
                                                      radius: size.width * 0.08,
                                                      child: Image.asset(
                                                        PngImages.profile,
                                                      )),

                                              Container(
                                                margin: EdgeInsets.all(
                                                    size.width * 0.02),
                                                height: size.width * 0.07,
                                                width: size.width * 0.07,
                                                decoration: BoxDecoration(
                                                    color: AppColor.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            size.width * 0.02)),
                                                child: IconButton(
                                                    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                                    icon: FaIcon(
                                                      FontAwesomeIcons
                                                          .penToSquare,
                                                      color:
                                                          AppColor.whiteColor,
                                                      size: size.width * 0.04,
                                                    ),
                                                    onPressed: () async {
                                                      final sharedPrefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      String id = sharedPrefs
                                                          .getString('id')!;
                                                      await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                EditCustomerProfile(
                                                                    customerId:
                                                                        id,
                                                                    customerProfile:
                                                                        provider
                                                                            .customerProfile!),
                                                          ));
                                                      // fetchProfile(
                                                      //     profileProvider);
                                                    }),
                                              )
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.start,
                                              //   children: [
                                              //     Column(
                                              //       children: const [
                                              //         Icon(
                                              //           Icons.badge,
                                              //           color: AppColor.secondaryColor,
                                              //         ),
                                              //         TextWidget(data:'ID: 23456788'),
                                              //       ],
                                              //     ),
                                              //     const Padding(
                                              //       padding: EdgeInsets.all(8.0),
                                              //       child: Icon(
                                              //         Icons.qr_code,
                                              //         color: AppColor.blackColor,
                                              //       ),
                                              //     )
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    TextWidget(
                                                      data: provider
                                                          .customerProfile!
                                                          .name!,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextWidget(
                                                        data:
                                                            'ID: ${provider.customerProfile!.username}'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 20),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Column(
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         children: const [
                                //           TextWidget(data:
                                //             'Akarsh',
                                //             style: TextStyle(fontWeight: FontWeight.bold),
                                //           ),
                                //           TextWidget(data:'ID: 23456788'),
                                //         ],
                                //       ),

                                //     ],
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () async {
                                            final sharedPrefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            String id =
                                                sharedPrefs.getString('id')!;
                                            String userType = sharedPrefs
                                                .getString('userType')!;
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: FollowList(
                                                      id: id,
                                                      type: "customer",
                                                      isFollow: true,
                                                      endPoints:
                                                          'customerfollowlist',
                                                    )));

                                            // profileProvider
                                            //     .refreshCustomerProfile(
                                            //         userId: id);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                border: Border.all(
                                                  color:
                                                      AppColor.secondaryColor,
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Row(
                                                children: [
                                                  AppConstant.kWidth(
                                                      width: size.width * .02),
                                                  Icon(
                                                    Icons.groups,
                                                    size: size.width * .09,
                                                    color: AppColor.green,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextWidget(
                                                        data: 'Follow',
                                                        style: TextStyle(
                                                          color: AppColor
                                                              .blackColor,
                                                        ),
                                                      ),
                                                      TextWidget(
                                                        data:
                                                            "${provider.customerProfile!.following ?? ""}",
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .blackColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: MediaQuery.of(
                                                                        context)
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
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () async {
                                            final sharedPrefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            String id =
                                                sharedPrefs.getString('id')!;
                                            String userType = sharedPrefs
                                                .getString('userType')!;
                                            await Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: FollowList(
                                                      id: id,
                                                      type: "customer",
                                                      isFollow: false,
                                                      endPoints:
                                                          'customerfavouritelist',
                                                    )));

                                            profileProvider
                                                .refreshCustomerProfile(
                                                    userId: id);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                border: Border.all(
                                                  color:
                                                      AppColor.secondaryColor,
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  AppConstant.kWidth(
                                                      width: size.width * .01),
                                                  Icon(
                                                    Icons.favorite,
                                                    size: size.width * .06,
                                                    color:
                                                        AppColor.secondaryColor,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextWidget(
                                                        data: 'Favourite',
                                                        style: TextStyle(
                                                          color: AppColor
                                                              .blackColor,
                                                        ),
                                                      ),
                                                      TextWidget(
                                                        data:
                                                            "${provider.customerProfile!.favorites ?? ""}",
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .blackColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: MediaQuery.of(
                                                                        context)
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
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //user details
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.whatsapp,
                                        color: AppColor.blackColor,
                                      ),
                                      AppConstant.kWidth(
                                          width: size.width * .02),
                                      TextWidget(
                                          data:
                                              '+${provider.customerProfile!.countryCode ?? ''} ${provider.customerProfile!.mobile ?? ""}'),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.phone_in_talk,
                                        color: AppColor.blackColor,
                                      ),
                                      AppConstant.kWidth(
                                          width: size.width * .02),
                                      InkWell(
                                        onTap: () async {
                                          if (provider.customerProfile!
                                                      .countryCode !=
                                                  null &&
                                              provider.customerProfile!
                                                      .mobile !=
                                                  null) {
                                            if (provider.customerProfile!
                                                    .countryCode!.isNotEmpty &&
                                                provider.customerProfile!
                                                    .mobile!.isNotEmpty) {
                                              final Uri _phoneNo = Uri.parse(
                                                  'tel:+${provider.customerProfile!.countryCode ?? ''}${provider.customerProfile!.mobile ?? ""}');
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
                                                '+${provider.customerProfile!.countryCode ?? ''} ${provider.customerProfile!.mobile ?? ""}'),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.envelope,
                                        color: AppColor.blackColor,
                                      ),
                                      AppConstant.kWidth(
                                          width: size.width * .02),
                                      InkWell(
                                          onTap: () async {
                                            if (provider.customerProfile !=
                                                    null &&
                                                provider.customerProfile!.email!
                                                    .isNotEmpty) {
                                              Uri mail = Uri.parse(
                                                  "mailto:${provider.customerProfile!.email!}");
                                              if (await launchUrl(mail)) {
                                                //email app opened
                                              } else {
                                                //email app is not opened
                                              }
                                            }
                                          },
                                          child: TextWidget(
                                              data: provider
                                                      .customerProfile!.email ??
                                                  "")),
                                    ],
                                  ),
                                ),
                                // const Divider(
                                //   color: Colors.grey,
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Row(
                                //     children:  [
                                //       const FaIcon(
                                //         FontAwesomeIcons.globe,
                                //         color: AppColor.blackColor,

                                //       ),Constant.kWidth(width: size.width*.02),
                                //       TextWidget(data:'www.sonymangottil.com'),
                                //     ],
                                //   ),
                                // ),
                                // const Divider(
                                //   color: Colors.grey,
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Row(
                                //     children:  [
                                //       const FaIcon(
                                //         FontAwesomeIcons.clock,
                                //         color: AppColor.blackColor,

                                //       ),Constant.kWidth(width: size.width*.02),
                                //       TextWidget(data:'12:00 AM - 12:00 PM'),
                                //     ],
                                //   ),
                                // ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.locationDot,
                                        color: AppColor.blackColor,
                                      ),
                                      AppConstant.kWidth(
                                          width: size.width * .02),
                                      InkWell(
                                        onTap: () {
                                          print("latitude");
                                          print(provider
                                              .customerProfile!.locLatitude!);
                                          print(provider
                                              .customerProfile!.locLongitude!);
                                          if (provider.customerProfile!
                                                      .locLatitude !=
                                                  null &&
                                              provider.customerProfile!
                                                      .locLongitude !=
                                                  null &&
                                              provider.customerProfile!
                                                      .location !=
                                                  null) {
                                            if (provider.customerProfile!
                                                    .locLatitude!.isNotEmpty &&
                                                provider.customerProfile!
                                                    .locLongitude!.isNotEmpty &&
                                                provider.customerProfile!
                                                    .location!.isNotEmpty) {
                                              MapsLauncher.launchCoordinates(
                                                  double.parse(provider
                                                      .customerProfile!
                                                      .locLatitude!),
                                                  double.parse(provider
                                                      .customerProfile!
                                                      .locLongitude!),
                                                  provider.customerProfile!
                                                      .location);
                                            }
                                          } else {}
                                        },
                                        child: TextWidget(
                                            data: provider.customerProfile!
                                                    .location ??
                                                ""),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),

                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: size.width * .02,
                                      top: size.width * .02),
                                  width: size.width,
                                  height: size.height * .045,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                        title.length,
                                        (index) => InkWell(
                                              onTap: () async {
                                                final sharedPrefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                String id = sharedPrefs
                                                    .getString('id')!;
                                                String userType = sharedPrefs
                                                    .getString('userType')!;
                                                profileProvider.changeTab(
                                                    index: index);
                                                if (index == 0) {
                                                  profileProvider.getFeeds(
                                                    traderId: null,
                                                    urlUserType: 'customer',
                                                  );
                                                } else if (index == 1) {
                                                  profileProvider.getOffers(
                                                      urlUserType: 'customer',
                                                      traderId: null);
                                                } else if (index == 2) {
                                                  profileProvider
                                                      .getMarketOrBazaar(
                                                          bazaarProvider:
                                                              bazaarProvider);
                                                } else {}
                                                // setState(() {
                                                //   currentIndex = index;
                                                // });
                                              },
                                              child: Container(
                                                width: size.width * .3,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: provider
                                                                .currentIndex ==
                                                            index
                                                        ? AppColor.green
                                                        : AppColor.whiteColor,
                                                    border: Border.all(
                                                        color: AppColor.green),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            size.width * .05)),
                                                child: TextWidget(
                                                  data: title[index],
                                                  style: TextStyle(
                                                      color: provider
                                                                  .currentIndex ==
                                                              index
                                                          ? AppColor.whiteColor
                                                          : AppColor
                                                              .blackColor),
                                                ),
                                              ),
                                            )).toList(),
                                  ),
                                ),
                                provider.currentIndex == 0
                                    ? Consumer<CurrentUserProvider>(
                                        builder: (context, userprovider, _) {
                                        return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.width * .005),
                                            child: TraderFeedScreen(
                                              isCustomer: true,
                                              userid:
                                                  userprovider.currentUserId ??
                                                      "0",
                                              isProfileVisit: true,
                                            )

                                            //  viewPost(
                                            //   size: size,
                                            // ),
                                            );
                                      })
                                    : const SizedBox(),
                                provider.currentIndex == 1
                                    ? Consumer<CurrentUserProvider>(
                                        builder: (context, userprovider, _) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * .02),
                                          child: viewOffer(
                                            size: size,
                                          ),
                                        );
                                      })
                                    : const SizedBox(),
                                provider.currentIndex == 2
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * .03),
                                        child: marketOrBazaar(size: size),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        );
        }),
      ),
    );
  }

  Widget viewOffer({
    required Size size,
  }) {
    return Consumer<ProfileProvider>(
        builder: (context, ProfileProvider provider, _) {
      return provider.isOfferLoading
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: const Center(child: CircularProgressIndicator()))
          : Column(
              children: [
                AppConstant.kheight(height: size.width * .017),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.offerListing.length,
                  separatorBuilder: (context, index) =>
                      AppConstant.kheight(height: size.width * .01),
                  itemBuilder: (context, index) {
                    TraderOfferListingModel offerModel =
                        provider.offerListing[index];
                    DateTime createdAt = DateTime.parse(offerModel.createdAt!);
                    return InkWell(
                      onTap: provider.currentOfferReactionIndex == null
                          ? () {}
                          : () {
                              profileProvider.closeAllOfferReaction();
                            },
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 2,
                        shadowColor: AppColor.blackColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(size.width * .02)),
                        child: Padding(
                            padding: EdgeInsets.all(size.width * .02),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppColor.green,
                                        radius: size.width * .055,
                                        child: CircleAvatar(
                                          radius: size.width * .049,
                                          backgroundImage: NetworkImage(
                                              offerModel.profilePic!),
                                        ),
                                      ),
                                      AppConstant.kWidth(
                                          width: size.width * .018),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                              data: offerModel.name ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: AppColor.blackColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: size.width * .036),
                                            ),
                                            TextWidget(
                                              data:
                                                  "Posted: ${createdAt.day} ${DateFormat.MMM().format(createdAt)} ${createdAt.year}, ${DateFormat('hh:mm a').format(createdAt)}",
                                              maxLines: 1,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  AppConstant.kheight(height: size.width * .02),
                                  Row(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.all(size.width * .02),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                size.width * .029),
                                            color:
                                                Color.fromARGB(255, 235, 212, 8)
                                                    .withOpacity(.9)),
                                        child: TextWidget(
                                          data:
                                              "Offer Price: \$ ${offerModel.discountPrice}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.whiteColor),
                                        ),
                                      ),
                                      AppConstant.kWidth(
                                          width: size.width * .02),
                                      Container(
                                        padding:
                                            EdgeInsets.all(size.width * .02),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                size.width * .029),
                                            color: Colors.green),
                                        child: TextWidget(
                                          data:
                                              "Full Price: \$ ${offerModel.fullPrice}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.whiteColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  AppConstant.kheight(
                                      height: size.width * .018),
                                  Container(
                                    child: CarouselSlider.builder(
                                        itemCount: offerModel
                                            .traderofferimages!.length,
                                        itemBuilder:
                                            (context, carIndex, realIndex) {
                                          return Container(
                                            margin: EdgeInsets.all(5),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: offerModel
                                                          .traderofferimages![
                                                      carIndex],
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Center(
                                                              child: const Icon(
                                                                  Icons.error)),
                                                )
                                                //  Image.network(
                                                // offerModel
                                                //     .traderofferimages![carIndex],
                                                //   fit: BoxFit.cover,
                                                // ),
                                                ),
                                          );
                                        },
                                        options: CarouselOptions(
                                          padEnds: false,
                                          scrollPhysics:
                                              BouncingScrollPhysics(),
                                          clipBehavior: Clip.antiAlias,
                                          enableInfiniteScroll: false,
                                          viewportFraction: .6,
                                          autoPlayAnimationDuration:
                                              const Duration(milliseconds: 200),
                                          // viewportFraction: 1,
                                          height: size.width * .5,

                                          autoPlay: false,
                                          reverse: false,
                                          autoPlayInterval:
                                              const Duration(seconds: 5),
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * .02,
                                        right: size.width * .02,
                                        top: size.width * .02),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: ReadMoreText(
                                            offerModel.description.toString(),
                                            readMoreIconColor: AppColor.green,
                                            numLines: 3,
                                            readMoreAlign: Alignment.centerLeft,
                                            style: TextStyle(
                                                fontSize: size.width * .033),
                                            readMoreTextStyle: TextStyle(
                                                fontSize: size.width * .033,
                                                color: Colors.green),
                                            readMoreText: 'Read More',
                                            readLessText: 'Read Less',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  offerModel.likes == null ||
                                          offerModel.firstUser == null
                                      ? SizedBox()
                                      : offerModel.likes! == 0
                                          ? SizedBox()
                                          :
                                          //  offerModel.likes! == 1 &&
                                          //         offerModel.emoji != null &&
                                          //         offerModel.emoji!.isNotEmpty
                                          //     ? SizedBox()
                                          //     :
                                          Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 17,
                                                  backgroundColor:
                                                      AppColor.green,
                                                  child: Icon(
                                                    Icons.thumb_up,
                                                    color: AppColor.whiteColor,
                                                    size: 17,
                                                  ),
                                                ),
                                                AppConstant.kWidth(width: 10),
                                                offerModel.likes == 1
                                                    ? TextWidget(
                                                        data: offerModel.emoji ==
                                                                    null ||
                                                                offerModel
                                                                    .emoji!
                                                                    .isEmpty
                                                            ? "${offerModel.firstUser}"
                                                            : "You")
                                                    : TextWidget(
                                                        data: offerModel.emoji ==
                                                                    null ||
                                                                offerModel
                                                                    .emoji!
                                                                    .isEmpty
                                                            ? "${offerModel.firstUser} and ${offerModel.likes! - 1} others"
                                                            : "You and ${offerModel.likes! - 1} others"),
                                                // offerModel.likes == 1
                                                //     ? TextWidget(
                                                //         data: offerModel
                                                //                     .emoji ==
                                                //                 null
                                                //             ? offerModel.emoji!
                                                //                     .isEmpty
                                                //                 ? "${offerModel.firstUser}"
                                                //                 : "${offerModel.firstUser}"
                                                //             : "You")
                                                //     : TextWidget(
                                                //         data: offerModel
                                                //                     .emoji ==
                                                //                 null
                                                //             ? offerModel.emoji!
                                                //                     .isEmpty
                                                //                 ? "${offerModel.firstUser}and ${offerModel.likes! - 1} others"
                                                //                 : "${offerModel.firstUser}and ${offerModel.likes! - 1} others"
                                                //             : "You and ${offerModel.likes! - 1} others"),
                                              ],
                                            ),
                                  Center(
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                provider.currentOfferReactionIndex ==
                                                            index &&
                                                        offerModel
                                                            .isReactionOpened!
                                                    ? SizedBox(
                                                        height: 40, width: 40)
                                                    : InkWell(
                                                        onTap: () {
                                                          profileProvider
                                                              .changeOfferReactionByIndex(
                                                                  index);
                                                        },
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 40,
                                                            width: 40,
                                                            decoration: BoxDecoration(
                                                                // border: Border.all(
                                                                //     color: Colors
                                                                //         .grey),
                                                                // boxShadow: const [
                                                                //   BoxShadow(
                                                                //       color: Colors
                                                                //           .white,
                                                                //       spreadRadius:
                                                                //           1)
                                                                // ],
                                                                // borderRadius:
                                                                //     BorderRadius
                                                                //         .circular(
                                                                //             15)
                                                                ),
                                                            child: offerModel.emoji != null && offerModel.emoji!.isNotEmpty
                                                                ? Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(5),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      currentReaction(
                                                                          offerModel
                                                                              .emoji!),
                                                                      height:
                                                                          35,
                                                                    ),
                                                                  )
                                                                : const FaIcon(
                                                                    FontAwesomeIcons
                                                                        .thumbsUp,
                                                                    color: AppColor
                                                                        .primaryColor,
                                                                  )),
                                                      ),
                                                AppConstant.kWidth(width: 12),
                                                provider.currentOfferReactionIndex ==
                                                            index &&
                                                        offerModel
                                                            .isReactionOpened!
                                                    ? SizedBox(
                                                        height: 40, width: 40)
                                                    : InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                  type:
                                                                      PageTransitionType
                                                                          .fade,
                                                                  child:
                                                                      CommentScreen(
                                                                    postId: offerModel
                                                                        .id
                                                                        .toString(),
                                                                    postImages:
                                                                        offerModel.traderofferimages ??
                                                                            [],
                                                                    profilePic:
                                                                        offerModel.profilePic ??
                                                                            "",
                                                                    description:
                                                                        offerModel
                                                                            .description
                                                                            .toString(),
                                                                    replyUrl: Url
                                                                        .postOfferReplyComment,
                                                                    postCommentUrl:
                                                                        Url.postOfferComment,
                                                                    endPoint:
                                                                        'traderoffercomments',
                                                                    traderId: offerModel
                                                                        .traderId
                                                                        .toString(),
                                                                  )));
                                                        },
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 40,
                                                            width: 40,
                                                            decoration: BoxDecoration(
                                                                // border: Border.all(
                                                                //     color: Colors
                                                                //         .grey),
                                                                // boxShadow: const [
                                                                //   BoxShadow(
                                                                //       color: Colors
                                                                //           .white,
                                                                //       spreadRadius:
                                                                //           1)
                                                                // ],
                                                                // borderRadius:
                                                                //     BorderRadius
                                                                //         .circular(
                                                                //             15)
                                                                ),
                                                            child: FaIcon(
                                                              FontAwesomeIcons
                                                                  .commentDots,
                                                              color: AppColor
                                                                  .primaryColor,
                                                            )),
                                                      ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Positioned(
                                          top: 3,
                                          child:
                                              provider.currentOfferReactionIndex ==
                                                          index &&
                                                      offerModel
                                                          .isReactionOpened!
                                                  ? ShowUpAnimation(
                                                      delayStart:
                                                          Duration(seconds: 0),
                                                      animationDuration:
                                                          Duration(
                                                              milliseconds: 1),
                                                      curve: Curves.bounceIn,
                                                      direction:
                                                          Direction.vertical,
                                                      offset: 0.5,
                                                      child: Container(
                                                        width: 220,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                profileProvider.postOfferReaction(
                                                                    postId:
                                                                        offerModel.id ??
                                                                            0,
                                                                    reactionEmoji:
                                                                        reactionKeyword[
                                                                            0],
                                                                    index:
                                                                        index);
                                                              },
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/image/like.svg',
                                                                height: 35,
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                profileProvider.postOfferReaction(
                                                                    postId:
                                                                        offerModel.id ??
                                                                            0,
                                                                    reactionEmoji:
                                                                        reactionKeyword[1]
                                                                            .toString(),
                                                                    index:
                                                                        index);
                                                              },
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/image/heart.svg',
                                                                height: 35,
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                profileProvider.postOfferReaction(
                                                                    postId:
                                                                        offerModel.id ??
                                                                            0,
                                                                    reactionEmoji:
                                                                        reactionKeyword[
                                                                            2],
                                                                    index:
                                                                        index);
                                                              },
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/image/laughing.svg',
                                                                height: 35,
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                profileProvider.postOfferReaction(
                                                                    postId:
                                                                        offerModel.id ??
                                                                            0,
                                                                    reactionEmoji:
                                                                        reactionKeyword[
                                                                            3],
                                                                    index:
                                                                        index);
                                                              },
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/image/angry.svg',
                                                                height: 35,
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                profileProvider.postOfferReaction(
                                                                    postId:
                                                                        offerModel.id ??
                                                                            0,
                                                                    reactionEmoji:
                                                                        reactionKeyword[
                                                                            4],
                                                                    index:
                                                                        index);
                                                              },
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/image/sad.svg',
                                                                height: 35,
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                profileProvider.postOfferReaction(
                                                                    postId:
                                                                        offerModel.id ??
                                                                            0,
                                                                    reactionEmoji:
                                                                        reactionKeyword[
                                                                            5],
                                                                    index:
                                                                        index);
                                                              },
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/image/wow.svg',
                                                                height: 35,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                        ),
                                      ],
                                    ),
                                  )
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //         child: Container(
                                  //       child: Row(
                                  //         children: [
                                  //           InkWell(
                                  //             onTap: () {},
                                  //             child: Container(
                                  //                 alignment: Alignment.center,
                                  //                 height: size.width * .07,
                                  //                 width: size.width * .1,
                                  //                 decoration: BoxDecoration(
                                  //                     border: Border.all(
                                  //                         color: Colors.grey),
                                  //                     boxShadow: const [
                                  //                       BoxShadow(
                                  //                           color: Colors.white,
                                  //                           spreadRadius: 1)
                                  //                     ],
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(
                                  //                             15)),
                                  //                 child: const FaIcon(
                                  //                   FontAwesomeIcons.thumbsUp,
                                  //                   color:
                                  //                       AppColor.primaryColor,
                                  //                 )),
                                  //           ),
                                  //           AppConstant.kWidth(
                                  //               width: size.width * .03),
                                  //           InkWell(
                                  //             onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     PageTransition(
                                  //         type: PageTransitionType
                                  //             .fade,
                                  //         child: CommentScreen(
                                  //           postId: offerModel.id
                                  //               .toString(),
                                  //           postImages: offerModel
                                  //                   .traderofferimages ??
                                  //               [],
                                  //           profilePic: offerModel
                                  //                   .profilePic ??
                                  //               "",
                                  //           description:
                                  //               offerModel
                                  //                   .description
                                  //                   .toString(),
                                  //           replyUrl: Url
                                  //               .postOfferReplyComment,
                                  //           postCommentUrl: Url
                                  //               .postOfferComment,
                                  //           endPoint:
                                  //               'traderoffercomments',
                                  //           traderId: offerModel
                                  //               .traderId
                                  //               .toString(),
                                  //         )));
                                  //             },
                                  //             child: Container(
                                  //                 alignment: Alignment.center,
                                  //                 height: size.width * .07,
                                  //                 width: size.width * .1,
                                  //                 decoration: BoxDecoration(
                                  //                     border: Border.all(
                                  //                         color: Colors.grey),
                                  //                     boxShadow: const [
                                  //                       BoxShadow(
                                  //                           color: Colors.white,
                                  //                           spreadRadius: 1)
                                  //                     ],
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(
                                  //                             15)),
                                  //                 child: FaIcon(
                                  //                   FontAwesomeIcons
                                  //                       .commentDots,
                                  //                   color:
                                  //                       AppColor.primaryColor,
                                  //                 )),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ))
                                  //   ],
                                  // ),
                                ])),
                      ),
                    );
                  },
                )
              ],
            );
    });
  }

  Widget marketOrBazaar({
    required Size size,
  }) {
    return Consumer<BazaarProvider>(builder: (context, provider, _) {
      return Consumer<ProfileProvider>(
          builder: (context, ProfileProvider profileProvider, _) {
        return profileProvider.isFeedLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.bazaarProductsList.length,
                itemBuilder: (context, index) {
                  // DateTime date = DateTime.parse(provider
                  //     .bazaarProductsList[index].createdAt!);

                  return ChangeNotifierProvider.value(
                    value: provider.bazaarProductsList[index],
                    child: const BazaarItems(isShortListOnly: true),
                  );
                },
              );
      });
    });

    // Container(
    //   alignment: Alignment.center,
    //   padding: EdgeInsets.all(size.width * .02),
    //   width: size.width,
    //   child: ListView.builder(
    //     shrinkWrap: true,
    //     physics: const BouncingScrollPhysics(),
    //     scrollDirection: Axis.vertical,
    //     itemCount: provider.marketOrBazaarList.length,
    //     itemBuilder: (context, index) {
    //       BazaarModel data = provider.marketOrBazaarList[index];
    //       DateTime date = DateTime.parse(data.createdAt!);

    //       return InkWell(
    //         onTap: () {
    //           Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                   builder: (context) => BazaarDetail(bazaarModel: data)));
    //         },
    //         child: Card(
    //           clipBehavior: Clip.antiAlias,
    //           shadowColor: Colors.grey,
    //           elevation: 1,
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(10)),
    //           child: Column(
    //             children: [
    //               Padding(
    //                 padding: EdgeInsets.only(
    //                   left: size.width * .03,
    //                 ),
    //                 child: textWidget(
    //                     text: data.product ?? "",
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.w500),
    //               ),
    //               Padding(
    //                 padding: EdgeInsets.only(
    //                     left: size.width * .03,
    //                     bottom: size.width * .03,
    //                     top: size.width * .01),
    //                 child: textWidget(
    //                     text:
    //                         "Posted: ${date.day} ${DateFormat.MMM().format(date)} ${date.year}, ${DateFormat('hh:mm a').format(date)}",
    //                     color: AppColor.green,
    //                     fontSize: 14,
    //                     fontWeight: FontWeight.w500),
    //               ),
    //               Container(
    //                 margin: EdgeInsets.only(
    //                   left: size.width * .016,
    //                 ),
    //                 child: data.bazaarimages!.isEmpty
    //                     ? Column(
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: const [
    //                           Icon(
    //                             Icons.broken_image,
    //                             color: Colors.grey,
    //                           ),
    //                           TextWidget(data:"No image")
    //                         ],
    //                       )
    //                     : ClipRRect(
    //                         borderRadius: BorderRadius.circular(7),
    //                         child: ImgFade.fadeImage(
    //                             height: size.height * .3,
    //                             width: size.width * .5,
    //                             url: data.bazaarimages![0])),
    //               ),
    //               Padding(
    //                 padding: EdgeInsets.only(
    //                   left: size.width * .03,
    //                 ),
    //                 child: ElevatedButton.icon(
    //                   onPressed: () {},
    //                   icon: const Icon(
    //                     Icons.check_box,
    //                     size: 15,
    //                   ),
    //                   label: data.wishlist == 1
    //                       ? const TextWidget(data:"Shortlisted")
    //                       : const TextWidget(data:"Shortlist"),
    //                   style: ElevatedButton.styleFrom(
    //                       backgroundColor: data.wishlist == 1
    //                           ? AppColor.blackColor
    //                           : AppColor.green,
    //                       minimumSize: Size(size.width * .44, size.width * .06),
    //                       shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(20))),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }

  TextWidget textWidget(
      {required String text,
      required double fontSize,
      required FontWeight fontWeight,
      Color? color}) {
    return TextWidget(
      data: text,
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? AppColor.blackColor,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }

  Widget viewPost({
    required Size size,
  }) {
    return Consumer<ProfileProvider>(
        builder: (context, ProfileProvider provider, _) {
      return provider.isFeedLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                AppConstant.kheight(height: size.width * .017),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.feed.length,
                  separatorBuilder: (context, index) =>
                      AppConstant.kheight(height: size.width * .01),
                  itemBuilder: (context, index) {
                    TraderFeedModel feedModel = provider.feed[index];
                    DateTime createdDate = DateTime.parse(feedModel.createdAt!);

                    return Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 2,
                      shadowColor: AppColor.blackColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * .02)),
                      child: Padding(
                          padding: EdgeInsets.all(size.width * .02),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppColor.green,
                                      radius: size.width * .055,
                                      child: CircleAvatar(
                                        radius: size.width * .049,
                                        backgroundImage: NetworkImage(
                                            feedModel.profilePic ?? ""),
                                      ),
                                    ),
                                    AppConstant.kWidth(
                                        width: size.width * .018),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                  data: feedModel.name ?? "",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color:
                                                          AppColor.blackColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          size.width * .036),
                                                ),
                                                TextWidget(
                                                  data:
                                                      "Posted: ${createdDate.day} ${DateFormat.MMM().format(createdDate)} ${createdDate.year}, ${DateFormat('hh:mm a').format(createdDate)}",
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.width * .023,
                                                vertical: size.width * .01),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.width * .03),
                                                color: AppColor.green),
                                            child: TextWidget(
                                              data: "Report",
                                              style: TextStyle(
                                                  color: AppColor.whiteColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                AppConstant.kheight(height: size.width * .018),
                                Container(
                                  child: CarouselSlider.builder(
                                      itemCount: feedModel.postImages!.length,
                                      itemBuilder:
                                          (context, carIndex, realIndex) {
                                        return Container(
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: feedModel
                                                    .postImages![carIndex],
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Center(
                                                            child: const Icon(
                                                                Icons.error)),
                                              )

                                              //  Image.network(
                                              //   feedModel.postImages![carIndex],
                                              //   fit: BoxFit.cover,
                                              // ),
                                              ),
                                        );
                                      },
                                      options: CarouselOptions(
                                        padEnds: false,
                                        scrollPhysics: BouncingScrollPhysics(),
                                        clipBehavior: Clip.antiAlias,
                                        enableInfiniteScroll: false,
                                        viewportFraction: .58,
                                        autoPlayAnimationDuration:
                                            const Duration(milliseconds: 200),
                                        // viewportFraction: 1,
                                        height: size.width * .5,

                                        autoPlay: false,
                                        reverse: false,
                                        autoPlayInterval:
                                            const Duration(seconds: 5),
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: size.width * .02,
                                      right: size.width * .02,
                                      top: size.width * .02),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: ReadMoreText(
                                          feedModel.postContent.toString(),
                                          readMoreIconColor: AppColor.green,
                                          numLines: 3,
                                          readMoreAlign: Alignment.centerLeft,
                                          style: TextStyle(
                                              fontSize: size.width * .033),
                                          readMoreTextStyle: TextStyle(
                                              fontSize: size.width * .033,
                                              color: Colors.green),
                                          readMoreText: 'Read More',
                                          readLessText: 'Read Less',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                                alignment: Alignment.center,
                                                height: size.width * .07,
                                                width: size.width * .1,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: Colors.white,
                                                          spreadRadius: 1)
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: const FaIcon(
                                                  FontAwesomeIcons.thumbsUp,
                                                  color: AppColor.primaryColor,
                                                )),
                                          ),
                                          AppConstant.kWidth(
                                              width: size.width * .03),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child: CommentScreen(
                                                        postId: feedModel.id
                                                            .toString(),
                                                        postImages: feedModel
                                                            .postImages!,
                                                        profilePic: feedModel
                                                                .profilePic ??
                                                            "",
                                                        description: feedModel
                                                            .postContent
                                                            .toString(),
                                                        replyUrl: Url
                                                            .postFeedReplyComment,
                                                        postCommentUrl:
                                                            Url.postFeedComment,
                                                        endPoint:
                                                            'traderpostcomments',
                                                        traderId: feedModel
                                                            .traderId
                                                            .toString(),
                                                      )));
                                            },
                                            child: Container(
                                                alignment: Alignment.center,
                                                height: size.width * .07,
                                                width: size.width * .1,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: Colors.white,
                                                          spreadRadius: 1)
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: FaIcon(
                                                  FontAwesomeIcons.commentDots,
                                                  color: AppColor.primaryColor,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ])),
                    );
                  },
                )
              ],
            );
    });
  }
}
