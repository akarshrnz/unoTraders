import 'package:carousel_slider/carousel_slider.dart';
import 'package:codecarrots_unotraders/model/Feeds/trader_feed_model.dart';
import 'package:codecarrots_unotraders/model/bazaar_model.dart';
import 'package:codecarrots_unotraders/model/offer%20listing/trader_offer_listing.dart';
import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/bazaar_detail.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/components/bazaar_items.dart';
import 'package:codecarrots_unotraders/screens/profile/customer/edit_customer_profile.dart';
import 'package:codecarrots_unotraders/services/helper/api_services_url.dart';
import 'package:codecarrots_unotraders/utils/circular_progress.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';

import '../../../utils/color.dart';
import '../../../utils/png.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key}) : super(key: key);

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  List<String> title = ["Feeds", "Offers", "Market or Bazaar"];
  int currentIndex = 0;
  late ProfileProvider profileProvider;
  late BazaarProvider bazaarProvider;
  Future<void>? getCustomerProfile;
  @override
  void initState() {
    super.initState();
    bazaarProvider = Provider.of<BazaarProvider>(context, listen: false);
    // locationProvider.initalizeLocation();
    // locationProvider.clearAll();
    bazaarProvider.intialValue();
    bazaarProvider.fetchBazaarProducts();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    fetchProfile(profileProvider);
  }

  fetchProfile(ProfileProvider profileProvider) {
    profileProvider.clear();
    getCustomerProfile =
        profileProvider.getCustomerProfile(userId: ApiServicesUrl.id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(color: AppColor.blackColor),
        ),
      ),
      body: Consumer<ProfileProvider>(
          builder: (context, ProfileProvider provider, _) {
        return provider.isLoading == true
            ? Constant.circularProgressIndicator()
            : provider.errorMessage.isNotEmpty
                ? const Center(child: Text("Something Went Wrong"))
                : provider.customerProfile == null
                    ? const Center(child: Text("Customer Data does not exist"))
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
                                                        radius:
                                                            size.width * 0.07,
                                                        backgroundImage:
                                                            NetworkImage(provider
                                                                .customerProfile!
                                                                .profilePic!),
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
                                                    color: AppColor.whiteColor,
                                                    size: size.width * 0.04,
                                                  ),
                                                  onPressed: () async {
                                                    await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditCustomerProfile(
                                                                  customerProfile:
                                                                      provider
                                                                          .customerProfile!),
                                                        ));
                                                    fetchProfile(
                                                        profileProvider);
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
                                            //         Text('ID: 23456788'),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    provider
                                                        .customerProfile!.name!,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
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
                              //           Text(
                              //             'Akarsh',
                              //             style: TextStyle(fontWeight: FontWeight.bold),
                              //           ),
                              //           Text('ID: 23456788'),
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
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            border: Border.all(
                                              color: AppColor.secondaryColor,
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Row(
                                            children: [
                                              Constant.kWidth(
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Follow',
                                                    style: TextStyle(
                                                      color:
                                                          AppColor.blackColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    '15,000',
                                                    style: TextStyle(
                                                        color:
                                                            AppColor.blackColor,
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
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            border: Border.all(
                                              color: AppColor.secondaryColor,
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Constant.kWidth(
                                                  width: size.width * .01),
                                              Icon(
                                                Icons.favorite,
                                                size: size.width * .06,
                                                color: AppColor.secondaryColor,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Favourite',
                                                    style: TextStyle(
                                                      color:
                                                          AppColor.blackColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    '10',
                                                    style: TextStyle(
                                                        color:
                                                            AppColor.blackColor,
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
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                      color: AppColor.blackColor,
                                    ),
                                    Constant.kWidth(width: size.width * .02),
                                    Text(
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
                                    Constant.kWidth(width: size.width * .02),
                                    Text(
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
                                    const FaIcon(
                                      FontAwesomeIcons.envelope,
                                      color: AppColor.blackColor,
                                    ),
                                    Constant.kWidth(width: size.width * .02),
                                    Text(provider.customerProfile!.email ?? ""),
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
                              //       Text('www.sonymangottil.com'),
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
                              //       Text('12:00 AM - 12:00 PM'),
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
                                    Constant.kWidth(width: size.width * .02),
                                    Text(provider.customerProfile!.location ??
                                        ""),
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
                                            onTap: () {
                                              setState(() {
                                                currentIndex = index;
                                              });
                                            },
                                            child: Container(
                                              width: size.width * .3,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: currentIndex == index
                                                      ? AppColor.green
                                                      : AppColor.whiteColor,
                                                  border: Border.all(
                                                      color: AppColor.green),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          size.width * .05)),
                                              child: Text(
                                                title[index],
                                                style: TextStyle(
                                                    color: currentIndex == index
                                                        ? AppColor.whiteColor
                                                        : AppColor.blackColor),
                                              ),
                                            ),
                                          )).toList(),
                                ),
                              ),
                              currentIndex == 0
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * .005),
                                      child: viewPost(
                                          size: size, provider: provider),
                                    )
                                  : const SizedBox(),
                              currentIndex == 1
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * .02),
                                      child: viewOffer(
                                          size: size, provider: provider),
                                    )
                                  : const SizedBox(),
                              currentIndex == 2
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * .03),
                                      child: marketOrBazaar(
                                          provider: provider, size: size),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      );
      }),
    );
  }

  Widget viewOffer({required Size size, required ProfileProvider provider}) {
    return Column(
      children: [
        Constant.kheight(height: size.width * .017),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.offerListing.length,
          separatorBuilder: (context, index) =>
              Constant.kheight(height: size.width * .01),
          itemBuilder: (context, index) {
            TraderOfferListingModel offerModel = provider.offerListing[index];
            DateTime createdAt = DateTime.parse(offerModel.createdAt!);
            return Card(
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              shadowColor: AppColor.blackColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size.width * .02)),
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
                                backgroundImage:
                                    NetworkImage(offerModel.profilePic!),
                              ),
                            ),
                            Constant.kWidth(width: size.width * .018),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    offerModel.name ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: AppColor.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.width * .036),
                                  ),
                                  Text(
                                    "Posted: ${createdAt.day} ${DateFormat.MMM().format(createdAt)} ${createdAt.year}, ${DateFormat('hh:mm a').format(createdAt)}",
                                    maxLines: 1,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Constant.kheight(height: size.width * .02),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(size.width * .02),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(size.width * .029),
                                  color: Color.fromARGB(255, 235, 212, 8)
                                      .withOpacity(.9)),
                              child: Text(
                                "Offer Price: \$ ${offerModel.discountPrice}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.whiteColor),
                              ),
                            ),
                            Constant.kWidth(width: size.width * .02),
                            Container(
                              padding: EdgeInsets.all(size.width * .02),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(size.width * .029),
                                  color: Colors.green),
                              child: Text(
                                "Full Price: \$ ${offerModel.fullPrice}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.whiteColor),
                              ),
                            ),
                          ],
                        ),
                        Constant.kheight(height: size.width * .018),
                        Container(
                          child: CarouselSlider.builder(
                              itemCount: offerModel.offerImages!.length,
                              itemBuilder: (context, carIndex, realIndex) {
                                return Container(
                                  margin: EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      offerModel.offerImages![carIndex],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                padEnds: false,
                                scrollPhysics: BouncingScrollPhysics(),
                                clipBehavior: Clip.antiAlias,
                                enableInfiniteScroll: false,
                                viewportFraction: .6,
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 200),
                                // viewportFraction: 1,
                                height: size.width * .5,

                                autoPlay: false,
                                reverse: false,
                                autoPlayInterval: const Duration(seconds: 5),
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
                                  offerModel.description.toString(),
                                  readMoreIconColor: AppColor.green,
                                  numLines: 3,
                                  readMoreAlign: Alignment.centerLeft,
                                  style: TextStyle(fontSize: size.width * .033),
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
                                            border:
                                                Border.all(color: Colors.grey),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.white,
                                                  spreadRadius: 1)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: const FaIcon(
                                          FontAwesomeIcons.thumbsUp,
                                          color: AppColor.primaryColor,
                                        )),
                                  ),
                                  Constant.kWidth(width: size.width * .03),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: size.width * .07,
                                        width: size.width * .1,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.white,
                                                  spreadRadius: 1)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(15)),
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
  }

  Widget marketOrBazaar(
      {required Size size, required ProfileProvider provider}) {
    return Consumer<BazaarProvider>(builder: (context, provider, _) {
      return provider.bazaarProductsList.isEmpty && provider.error == false
          ? Center(child: CircularProgress.indicator())
          : provider.error == true
              ? Center(child: Text(provider.errorMessage.toString()))
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
    //                           Text("No image")
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
    //                       ? const Text("Shortlisted")
    //                       : const Text("Shortlist"),
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

  Text textWidget(
      {required String text,
      required double fontSize,
      required FontWeight fontWeight,
      Color? color}) {
    return Text(
      text,
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? AppColor.blackColor,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }

  Widget viewPost({required Size size, required ProfileProvider provider}) {
    return Column(
      children: [
        Constant.kheight(height: size.width * .017),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.feed.length,
          separatorBuilder: (context, index) =>
              Constant.kheight(height: size.width * .01),
          itemBuilder: (context, index) {
            TraderFeedModel feedModel = provider.feed[index];
            DateTime createdDate = DateTime.parse(feedModel.createdAt!);

            return Card(
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              shadowColor: AppColor.blackColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size.width * .02)),
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
                                backgroundImage:
                                    NetworkImage(feedModel.profilePic ?? ""),
                              ),
                            ),
                            Constant.kWidth(width: size.width * .018),
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
                                        Text(
                                          feedModel.name ?? "",
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: AppColor.blackColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width * .036),
                                        ),
                                        Text(
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
                                        borderRadius: BorderRadius.circular(
                                            size.width * .03),
                                        color: AppColor.green),
                                    child: Text(
                                      "Report",
                                      style:
                                          TextStyle(color: AppColor.whiteColor),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Constant.kheight(height: size.width * .018),
                        Container(
                          child: CarouselSlider.builder(
                              itemCount: feedModel.postImages!.length,
                              itemBuilder: (context, carIndex, realIndex) {
                                return Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      feedModel.postImages![carIndex],
                                      fit: BoxFit.cover,
                                    ),
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
                                autoPlayInterval: const Duration(seconds: 5),
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
                                  style: TextStyle(fontSize: size.width * .033),
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
                                            border:
                                                Border.all(color: Colors.grey),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.white,
                                                  spreadRadius: 1)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: const FaIcon(
                                          FontAwesomeIcons.thumbsUp,
                                          color: AppColor.primaryColor,
                                        )),
                                  ),
                                  Constant.kWidth(width: size.width * .03),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: size.width * .07,
                                        width: size.width * .1,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.white,
                                                  spreadRadius: 1)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(15)),
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
  }
}
