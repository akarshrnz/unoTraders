import 'dart:io';

import 'package:codecarrots_unotraders/model/add_post.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/profile/traders/post_an_offer_dialog.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/services/helper/api_services_url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/color.dart';
import '../../../utils/png.dart';
import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feed_reaction/models/feed_reaction_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:read_more_text/read_more_text.dart';

import '../../../utils/color.dart';
import '../../../utils/png.dart';

class TraderProfile extends StatefulWidget {
  const TraderProfile({Key? key}) : super(key: key);

  @override
  _TraderProfileState createState() => _TraderProfileState();
}

class _TraderProfileState extends State<TraderProfile> {
  late ImagePickProvider imagePickProvider;
  late ProfileProvider profileProvider;
  int currentIndex = 0;
  List<String> title = ["View Post", "View Offers", "View Reviews"];
  late FocusNode postTitleFocus;
  late FocusNode descriptionFocus;
  late TextEditingController postTitleController;
  late TextEditingController descriptionController;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void initState() {
    imagePickProvider = Provider.of<ImagePickProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    imagePickProvider.initialValues();
    initialize();
    super.initState();
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
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        title: const Text(
          'Trader Profile',
          style: TextStyle(color: AppColor.blackColor),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<TraderProfileModel>(
            future: ProfileServices.getTrderProfile(id: ApiServicesUrl.id),
            // ApiServicesUrl.id
            builder: (context, AsyncSnapshot<TraderProfileModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                if (snapshot.hasData) {
                  return profileBody(
                      context: context,
                      size: size,
                      profileModel: snapshot.data!);
                } else {
                  return Constant.circularProgressIndicator();
                }
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                } else if (snapshot.hasData) {
                  print("started");
                  print(snapshot.data!.address);
                  return profileBody(
                      context: context,
                      size: size,
                      profileModel: snapshot.data!);
                } else {
                  const Center(child: Text("Document does not exist"));
                }
              } else {
                return Constant.circularProgressIndicator();
              }
              return Constant.circularProgressIndicator();
            }),
      ),
    );
  }

  Widget profileBody(
      {required BuildContext context,
      required Size size,
      required TraderProfileModel profileModel}) {
    return Padding(
      padding: EdgeInsets.all(size.width * .02),
      child: Column(
        children: [
          // Card(
          //                       elevation: 1,
          //                       child: Padding(
          //                         padding: const EdgeInsets.all(10),
          //                         child: Row(
          //                           mainAxisAlignment:
          //                               MainAxisAlignment.spaceBetween,
          //                           children: [
          //                             Row(
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.start,
          //                               children: [
          //                                 provider
          //                                             .customerProfile!
          //                                             .profilePic!
          //                                             .isNotEmpty ==
          //                                         true
          //                                     ? CircleAvatar(
          //                                         radius: size.width * 0.08,
          //                                         child: CircleAvatar(
          //                                           radius:
          //                                               size.width * 0.075,
          //                                           backgroundColor:
          //                                               AppColor.whiteColor,
          //                                           child: CircleAvatar(
          //                                             radius:
          //                                                 size.width * 0.07,
          //                                             backgroundImage:
          //                                                 NetworkImage(provider
          //                                                     .customerProfile!
          //                                                     .profilePic!),
          //                                           ),
          //                                         ),
          //                                       )
          //                                     : CircleAvatar(
          //                                         radius: size.width * 0.08,
          //                                         child: Image.asset(
          //                                           PngImages.profile,
          //                                         )),

          //                                 Container(
          //                                   margin: EdgeInsets.all(
          //                                       size.width * 0.02),
          //                                   height: size.width * 0.07,
          //                                   width: size.width * 0.07,
          //                                   decoration: BoxDecoration(
          //                                       color: AppColor.green,
          //                                       borderRadius:
          //                                           BorderRadius.circular(
          //                                               size.width * 0.02)),
          //                                   child: IconButton(
          //                                       // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
          //                                       icon: FaIcon(
          //                                         FontAwesomeIcons
          //                                             .penToSquare,
          //                                         color: AppColor.whiteColor,
          //                                         size: size.width * 0.04,
          //                                       ),
          //                                       onPressed: () {
          //                                         Navigator.push(
          //                                             context,
          //                                             MaterialPageRoute(
          //                                               builder: (context) =>
          //                                                   EditCustomerProfile(
          //                                                       customerProfile:
          //                                                           provider
          //                                                               .customerProfile!),
          //                                             ));
          //                                       }),
          //                                 )

          //                               ],
          //                             ),
          //                             Padding(
          //                               padding:
          //                                   const EdgeInsets.only(left: 20),
          //                               child: Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Column(
          //                                     crossAxisAlignment:
          //                                         CrossAxisAlignment.end,
          //                                     children: [
          //                                       Text(
          //                                         provider
          //                                             .customerProfile!.name!,
          //                                         style: const TextStyle(
          //                                             fontWeight:
          //                                                 FontWeight.bold),
          //                                       ),
          //                                       Text(
          //                                           'ID: ${provider.customerProfile!.username}'),
          //                                     ],
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
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
                              radius: MediaQuery.of(context).size.width * 0.06,
                              child: CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.05,
                                backgroundImage: NetworkImage(
                                  'https://i.pinimg.com/736x/82/17/5c/82175caf7d103a2a0aead645966c3577.jpg',
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.06,
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
                            onPressed: () {}),
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
                          Text('ID: ${profileModel.username}'),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.qr_code,
                          color: AppColor.blackColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * .02, vertical: size.width * .01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileModel.name ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // Text(widget.category),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: AppColor.secondaryColor,
                  child: Text(
                    profileModel.rating ?? "0",
                    style: const TextStyle(color: AppColor.whiteBtnColor),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .017),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.width * .06),
                        border: Border.all(
                          color: AppColor.secondaryColor,
                        )),
                    child: Padding(
                      padding: EdgeInsets.all(size.width * .02),
                      child: Center(
                          child: Row(
                        children: [
                          Constant.kWidth(width: size.width * .02),
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
                              const Text(
                                'Follow',
                                style: TextStyle(
                                  color: AppColor.blackColor,
                                ),
                              ),
                              Text(
                                profileModel.followers.toString(),
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
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.width * .06),
                        border: Border.all(
                          color: AppColor.secondaryColor,
                        )),
                    child: Padding(
                      padding: EdgeInsets.all(size.width * .02),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Constant.kWidth(width: size.width * .01),
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
                              const Text(
                                'Favourite',
                                style: TextStyle(
                                  color: AppColor.blackColor,
                                ),
                              ),
                              Text(
                                profileModel.favourites.toString(),
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
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(size.width * .02),
            child: Row(
              children: [
                const Icon(Icons.chat_bubble_outline),
                Constant.kWidth(width: size.width * .02),
                Text('+${profileModel.countryCode} ${profileModel.mobile}'),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.all(size.width * .02),
            child: Row(
              children: [
                const Icon(Icons.call_outlined),
                Constant.kWidth(width: size.width * .02),
                Text('+${profileModel.countryCode} ${profileModel.mobile}'),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.all(size.width * .02),
            child: Row(
              children: [
                const Icon(Icons.mail_outline),
                Constant.kWidth(width: size.width * .02),
                Text(profileModel.email.toString()),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.all(size.width * .02),
            child: Row(
              children: [
                const Icon(Icons.signal_cellular_connected_no_internet_0_bar),
                Constant.kWidth(width: size.width * .02),
                Text(profileModel.webUrl.toString()),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          // Padding(
          //   padding: EdgeInsets.all(size.width * .02),
          //   child: Row(
          //     children: const [
          //       Icon(Icons.timer_outlined),
          //       Text('12:00 AM - 12:00 PM'),
          //     ],
          //   ),
          // ),
          // const Divider(
          //   color: Colors.grey,
          // ),
          Padding(
            padding: EdgeInsets.all(size.width * .02),
            child: Row(
              children: [
                const Icon(Icons.location_on),
                Constant.kWidth(width: size.width * .02),
                Text(profileModel.address.toString()),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
           Constant.kheight(height: size.width * .02),
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
          //             child: Text(
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
            margin: EdgeInsets.only(
                bottom: size.width * .02, top: size.width * .02),
            width: size.width,
            height: size.height * .05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              border: Border.all(color: AppColor.green),
                              borderRadius:
                                  BorderRadius.circular(size.width * .05)),
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
                  padding: EdgeInsets.symmetric(horizontal: size.width * .005),
                  child: viewPost(profileModel: profileModel, size: size),
                )
              : const SizedBox(),
          currentIndex == 1
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .02),
                  child: viewOffers(profileModel: profileModel, size: size),
                )
              : const SizedBox(),
          currentIndex == 2
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .03),
                  child: viewReviews(profileModel: profileModel, size: size),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget viewOffers(
      {required Size size, required TraderProfileModel profileModel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constant.kheight(height: size.width * .012),
        InkWell(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => const PostAnOfferDialog(),
            );
            setState(() {});
          },
          child: Container(
            alignment: Alignment.center,
            height: size.width * .1,
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * .04),
                color: AppColor.green,
                border: Border.all(color: AppColor.green)),
            child: const Text(
              "Post Offer",
              style: TextStyle(color: AppColor.whiteColor),
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: profileModel.traderoffers!.length,
          separatorBuilder: (context, index) =>
              Constant.kheight(height: size.width * .01),
          itemBuilder: (context, index) {
            Traderoffers traderOffer = profileModel.traderoffers![index];

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
                    Row(children: [
                      Expanded(
                        child: Text(
                          traderOffer.offerTitle.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * .035),
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
                            onPressed: () {}),
                      )
                    ]),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Constant.kheight(height: size.width * .017),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ReadMoreText(
                          traderOffer.offerDescription.toString(),
                          numLines: 3,
                          readMoreAlign: Alignment.centerLeft,
                          style: TextStyle(fontSize: size.width * .033),
                          readMoreTextStyle: TextStyle(
                              fontSize: size.width * .033, color: Colors.blue),
                          readMoreText: 'Read More',
                          readLessText: 'Read Less',
                        ),
                      ],
                    ),
                    Constant.kheight(height: size.width * .012),
                    SizedBox(
                      height: size.height * .25,
                      width: size.width,
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width * .6,
                            height: size.height * .25,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: traderOffer.offerImages!.length,
                              itemBuilder: (context, index) {
                                final image = traderOffer.offerImages![index];
                                return Container(
                                  padding: EdgeInsets.all(size.width * .005),
                                  child: ImgFade.fadeImage(url: image),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Price",
                                  style: TextStyle(fontSize: size.width * .03),
                                ),
                                Text(
                                  "\$ ${traderOffer.fullPrice.toString()}",
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough),
                                ),
                                Constant.kheight(height: size.width * .012),
                                Text("Discount Price",
                                    style:
                                        TextStyle(fontSize: size.width * .03)),
                                Text(
                                  "\$ ${traderOffer.discountPrice.toString()}",
                                  style: TextStyle(
                                      color: AppColor.green,
                                      fontSize: size.width * .035),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Constant.kheight(height: size.width * .03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: size.width * .075,
                          width: size.width * .43,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(size.width * .04),
                              border: Border.all(color: AppColor.green)),
                          child: Column(
                            children: [
                              const Text("Valid From "),
                              Text("${traderOffer.validFrom}"),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: size.width * .075,
                          width: size.width * .43,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(size.width * .04),
                              border: Border.all(color: AppColor.green)),
                          child: Column(
                            children: [
                              const Text("Valid Expire"),
                              Text("${traderOffer.validTo}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Constant.kheight(height: size.width * .03),
                    CircleAvatar(
                        radius: size.width * .03,
                        backgroundColor: AppColor.green,
                        child: Icon(
                          Icons.thumb_up,
                          size: size.width * .034,
                          color: AppColor.whiteColor,
                        )),
                    Constant.kheight(height: size.width * .02),
                    Row(
                      children: [
                        Text("Likes ()"),
                        Constant.kWidth(width: size.width * .01),
                        const Text("Comments")
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget viewReviews(
      {required Size size, required TraderProfileModel profileModel}) {
    return Column(
      children: [
        Constant.kheight(height: size.width * .012),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.center,
              height: size.width * .07,
              width: size.width * .4,
              decoration:
                  BoxDecoration(border: Border.all(color: AppColor.green)),
              child: Text("Review Notification (0)"),
            ),
            Container(
              alignment: Alignment.center,
              height: size.width * .07,
              width: size.width * .4,
              decoration:
                  BoxDecoration(border: Border.all(color: AppColor.green)),
              child: Text("Bad Review"),
            ),
          ],
        )
      ],
    );
  }

  Widget viewPost(
      {required Size size, required TraderProfileModel profileModel}) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //post title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .02),
            child: TextFieldWidget(
                focusNode: postTitleFocus,
                controller: postTitleController,
                hintText: "Post Title",
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (p0) {
                  postTitleFocus.unfocus();
                  FocusScope.of(context).requestFocus(descriptionFocus);
                },
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  } else {
                    return null;
                  }
                }),
          ),
          Constant.kheight(height: size.width * .017),
          //description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .02),
            child: TextFieldWidget(
                focusNode: descriptionFocus,
                controller: descriptionController,
                hintText: "Product",
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (p0) {
                  descriptionFocus.unfocus();
                },
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  } else {
                    return null;
                  }
                }),
          ),
          //add photo

          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .02),
            child: Consumer<ImagePickProvider>(
                builder: (context, imageProvider, _) {
              return imageProvider.images.isEmpty == true
                  ? Constant.kheight(height: 10)
                  : Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: imageProvider.images.isEmpty == true ? 0 : 170,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        // gridDelegate:
                        //     const SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 2,
                        // ),
                        itemCount: imageProvider.images.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Image.file(
                                    File(imageProvider.images[index].path),
                                    height: 190,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 1,
                                  child: IconButton(
                                      onPressed: () {
                                        imageProvider.remove(index);
                                      },
                                      icon: const Icon(Icons.cancel_outlined)),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
            }),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .02),
            child: SizedBox(
              height: 50,
              width: size.width,
              child: ElevatedButton.icon(
                label: Text(
                  "Choose Images",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                onPressed: () {
                  imagePickProvider.pickImage();
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    alignment: Alignment.centerLeft,
                    side: const BorderSide(
                      color: Colors.grey,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: AppColor.whiteColor),
                icon: const FaIcon(
                  FontAwesomeIcons.images,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Constant.kheight(height: size.width * .017),
          //post button
          isLoading == true
              ? Constant.circularProgressIndicator()
              : Consumer<ImagePickProvider>(builder: (context, provider, _) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .02),
                    child: DefaultButton(
                        text: "Post",
                        onPress: () async {
                          if (_formKey.currentState!.validate() &&
                              provider.imageFile.isNotEmpty) {
                            setState(() {
                              isLoading = true;
                            });

                            AddPostModel postModel = AddPostModel(
                                postTitle:
                                    postTitleController.text.trim().toString(),
                                postContent: descriptionController.text
                                    .trim()
                                    .toString(),
                                postImages: provider.imageFile,
                                traderId: int.parse(ApiServicesUrl.id));
                            await profileProvider
                                .addPost(addPost: postModel)
                                .then((value) {
                              clearField();
                              Constant.toastMsg(
                                  msg: "Post Added Successfully",
                                  backgroundColor: AppColor.green);
                              return;
                            }).onError((error, stackTrace) {
                              Constant.toastMsg(
                                  msg: "Something Went Wrong",
                                  backgroundColor: AppColor.red);

                              return;
                            });
                          } else {
                            Constant.toastMsg(
                                msg: "Please fill all the Fields",
                                backgroundColor: AppColor.red);
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        radius: size.width * .01),
                  );
                }),
          Constant.kheight(height: size.width * .017),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: profileModel.traderposts!.length,
            separatorBuilder: (context, index) =>
                Constant.kheight(height: size.width * .01),
            itemBuilder: (context, index) {
              Traderposts traderPost = profileModel.traderposts![index];
              DateTime createdAt = DateTime.parse(traderPost.createdAt!);

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
                      Row(children: [
                        Expanded(
                          child: Text(
                            traderPost.postTitle.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * .035),
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
                              onPressed: () {}),
                        )
                      ]),
                      const Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: size.width,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(size.width * .01),
                              height: size.width * .07,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.green),
                                  borderRadius:
                                      BorderRadius.circular(size.width * .03)),
                              child: Center(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(size.width * .01),
                                      child: Icon(
                                        Icons.calendar_month_outlined,
                                        color: AppColor.green,
                                        size: size.width * .03,
                                      ),
                                    ),
                                    Constant.kWidth(width: size.width * .01),
                                    Text(
                                        '${createdAt.day}/${createdAt.month}/${createdAt.year}'),
                                    Constant.kWidth(width: size.width * .02),
                                  ],
                                ),
                              ),
                            ),
                            Constant.kWidth(width: size.width * .03),
                            //full price
                            Container(
                              height: size.width * .07,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.green),
                                  borderRadius:
                                      BorderRadius.circular(size.width * .03)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(size.width * .01),
                                    child: Icon(
                                      Icons.access_time,
                                      size: size.width * .03,
                                      color: AppColor.green,
                                    ),
                                  ),
                                  Constant.kWidth(width: size.width * .01),
                                  Text(DateFormat('hh:mm a').format(createdAt)),
                                  Constant.kWidth(width: size.width * .03),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Constant.kheight(height: size.width * .017),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ReadMoreText(
                            traderPost.postContent.toString(),
                            numLines: 3,
                            readMoreAlign: Alignment.centerLeft,
                            style: TextStyle(fontSize: size.width * .033),
                            readMoreTextStyle: TextStyle(
                                fontSize: size.width * .033,
                                color: Colors.blue),
                            readMoreText: 'Read More',
                            readLessText: 'Read Less',
                          ),
                        ],
                      ),
                      Constant.kheight(height: size.width * .012),
                      SizedBox(
                        width: size.width,
                        height: size.height * .25,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: traderPost.postImages == null
                              ? 0
                              : traderPost.postImages!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: ImgFade.fadeImage(
                                  width: size.width * .9,
                                  url: traderPost.postImages![index]),
                            );
                          },
                        ),
                      ),
                      Constant.kheight(height: size.width * .03),
                      CircleAvatar(
                          radius: size.width * .03,
                          backgroundColor: AppColor.green,
                          child: Icon(
                            Icons.thumb_up,
                            size: size.width * .034,
                            color: AppColor.whiteColor,
                          )),
                      Constant.kheight(height: size.width * .02),
                      Row(
                        children: [
                          const Text("Likes (0)"),
                          Constant.kWidth(width: size.width * .01),
                          const Text("Comments")
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


// class TraderProfile extends StatefulWidget {
//   const TraderProfile({Key? key}) : super(key: key);

//   @override
//   _TraderProfileState createState() => _TraderProfileState();
// }

// class _TraderProfileState extends State<TraderProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         bottomOpacity: 0.0,
//         elevation: 0.0,
//         backgroundColor: AppColor.whiteColor,
//         leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Image.asset(PngImages.arrowBack)),
//         centerTitle: true,
//         title: const Text(
//           'Trader Profile',
//           style: TextStyle(color: AppColor.blackColor),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Card(
//               shadowColor: Colors.grey,
//               elevation: 10,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CircleAvatar(
//                       radius: MediaQuery.of(context).size.width * 0.05,
//                       child: Image.asset(
//                         PngImages.profile,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Column(
//                           children: const [
//                             Icon(
//                               Icons.badge,
//                               color: AppColor.secondaryColor,
//                             ),
//                             Text('ID: 23456788'),
//                           ],
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Icon(
//                             Icons.qr_code,
//                             color: AppColor.blackColor,
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         'David William',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text('Electrician'),
//                     ],
//                   ),
//                   const CircleAvatar(
//                     backgroundColor: AppColor.secondaryColor,
//                     child: Text(
//                       '4.8',
//                       style: TextStyle(color: AppColor.whiteBtnColor),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30.0),
//                           border: Border.all(
//                             color: AppColor.secondaryColor,
//                           )),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Center(
//                             child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             const Icon(
//                               Icons.person,
//                               color: AppColor.secondaryColor,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Follow',
//                                   style: TextStyle(
//                                     color: AppColor.blackColor,
//                                   ),
//                                 ),
//                                 Text(
//                                   '15,000',
//                                   style: TextStyle(
//                                       color: AppColor.blackColor,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:
//                                           MediaQuery.of(context).size.width *
//                                               0.04),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         )),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30.0),
//                           border: Border.all(
//                             color: AppColor.secondaryColor,
//                           )),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Center(
//                             child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             const Icon(
//                               Icons.favorite,
//                               color: AppColor.secondaryColor,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Favourite',
//                                   style: TextStyle(
//                                     color: AppColor.blackColor,
//                                   ),
//                                 ),
//                                 Text(
//                                   '10',
//                                   style: TextStyle(
//                                       color: AppColor.blackColor,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:
//                                           MediaQuery.of(context).size.width *
//                                               0.04),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         )),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: const [
//                   Icon(Icons.chat_bubble_outline),
//                   Text('+91 9605591928'),
//                 ],
//               ),
//             ),
//             const Divider(
//               color: Colors.grey,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: const [
//                   Icon(Icons.call_outlined),
//                   Text('+91 9605591928'),
//                 ],
//               ),
//             ),
//             const Divider(
//               color: Colors.grey,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: const [
//                   Icon(Icons.mail_outline),
//                   Text('sonymangottil@gmail.com'),
//                 ],
//               ),
//             ),
//             const Divider(
//               color: Colors.grey,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: const [
//                   Icon(Icons.signal_cellular_connected_no_internet_0_bar),
//                   Text('www.sonymangottil.com'),
//                 ],
//               ),
//             ),
//             const Divider(
//               color: Colors.grey,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: const [
//                   Icon(Icons.timer_outlined),
//                   Text('12:00 AM - 12:00 PM'),
//                 ],
//               ),
//             ),
//             const Divider(
//               color: Colors.grey,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: const [
//                   Icon(Icons.navigation_outlined),
//                   Text('36 Goldcraft, Yeovil, Somerset'),
//                 ],
//               ),
//             ),
//             const Divider(
//               color: Colors.grey,
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height * 0.07,
//               width: MediaQuery.of(context).size.width * 0.9,
//               decoration: BoxDecoration(
//                 color: AppColor.secondaryColor,
//                 borderRadius: BorderRadius.circular(30.0),
//               ),
//               child: Center(
//                   child: Text(
//                 'Book an Appointment',
//                 style: TextStyle(
//                     color: AppColor.whiteBtnColor,
//                     fontSize: MediaQuery.of(context).size.width * 0.045,
//                     fontWeight: FontWeight.w500),
//               )),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * 0.06,
//                       decoration: BoxDecoration(
//                         color: AppColor.blackColor,
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                       child: Center(
//                           child: Text(
//                         'Get a Quote',
//                         style: TextStyle(
//                             color: AppColor.whiteBtnColor,
//                             fontSize: MediaQuery.of(context).size.width * 0.045,
//                             fontWeight: FontWeight.w500),
//                       )),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * 0.06,
//                       decoration: BoxDecoration(
//                         color: AppColor.blackColor,
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                       child: Center(
//                           child: Text(
//                         'Message',
//                         style: TextStyle(
//                             color: AppColor.whiteBtnColor,
//                             fontSize: MediaQuery.of(context).size.width * 0.045,
//                             fontWeight: FontWeight.w500),
//                       )),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20.0),
//                       border: Border.all(
//                         color: AppColor.secondaryColor,
//                       )
//                     ),
//                     child: const CircleAvatar(
//                       backgroundColor: AppColor.whiteBtnColor,
//                         child: Icon(
//                       Icons.thumb_up_alt_outlined,
//                       color: AppColor.secondaryColor,
//                     )),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
