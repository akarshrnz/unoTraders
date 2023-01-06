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

class TraderProfileVisit extends StatefulWidget {
  final String id;
  final String category;
  const TraderProfileVisit({Key? key, required this.id, required this.category})
      : super(key: key);

  @override
  _TraderProfileState createState() => _TraderProfileState();
}

class _TraderProfileState extends State<TraderProfileVisit> {
  int currentIndex = 0;
  List<String> title = ["View Post", "View Offers", "View Reviews"];

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
        title: const Text(
          'Trader Profile',
          style: TextStyle(color: AppColor.blackColor),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<TraderProfileModel>(
            future: ProfileServices.getTraderProfile(id: widget.id),
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
      padding: EdgeInsets.all(size.width * .01),
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
                          radius: MediaQuery.of(context).size.width * 0.06,
                          child: CircleAvatar(
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
            padding: EdgeInsets.all(size.width * .02),
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
                    Text(widget.category),
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
            padding: EdgeInsets.all(size.width * .02),
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
                            size: size.width * .09,
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
                Expanded(child: Text(profileModel.address.toString())),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Constant.kheight(height: size.width * .02),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.92,
            decoration: BoxDecoration(
              color: AppColor.secondaryColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
                child: Text(
              'Book an Appointment',
              style: TextStyle(
                  color: AppColor.whiteBtnColor,
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.w500),
            )),
          ),
          Constant.kheight(height: size.width * .02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .027),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: AppColor.blackColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Center(
                      child: Text(
                    'Get a Quote',
                    style: TextStyle(
                        color: AppColor.whiteBtnColor,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w500),
                  )),
                ),
                Constant.kWidth(width: size.width * .02),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: AppColor.blackColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                      child: Text(
                    'Message',
                    style: TextStyle(
                        color: AppColor.whiteBtnColor,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w500),
                  )),
                ),
                Constant.kWidth(width: size.width * .01),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: AppColor.secondaryColor,
                      )),
                  child: const CircleAvatar(
                      backgroundColor: AppColor.whiteBtnColor,
                      child: Icon(
                        Icons.thumb_up_alt_outlined,
                        color: AppColor.secondaryColor,
                      )),
                ),
                // Expanded(
                //   child: Padding(
                //     padding:  EdgeInsets.all(size.width*.02),
                //     child: Container(  width: MediaQuery.of(context).size.width * 0.9,
                //       height: MediaQuery.of(context).size.height * 0.06,
                //       decoration: BoxDecoration(
                //         color: AppColor.blackColor,
                //         borderRadius: BorderRadius.circular(30.0),
                //       ),
                //       child: Center(
                //           child: Text(
                //         'Get a Quote',
                //         style: TextStyle(
                //             color: AppColor.whiteBtnColor,
                //             fontSize: MediaQuery.of(context).size.width * 0.045,
                //             fontWeight: FontWeight.w500),
                //       )),
                //     ),
                //   ),
                // ),
                // Expanded(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Container(  width: MediaQuery.of(context).size.width * 0.9,
                //       height: MediaQuery.of(context).size.height * 0.06,
                //       decoration: BoxDecoration(
                //         color: AppColor.blackColor,
                //         borderRadius: BorderRadius.circular(30.0),
                //       ),
                //       child: Center(
                //           child: Text(
                //         'Message',
                //         style: TextStyle(
                //             color: AppColor.whiteBtnColor,
                //             fontSize: MediaQuery.of(context).size.width * 0.045,
                //             fontWeight: FontWeight.w500),
                //       )),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(20.0),
                //         border: Border.all(
                //           color: AppColor.secondaryColor,
                //         )),
                //     child: const CircleAvatar(
                //         backgroundColor: AppColor.whiteBtnColor,
                //         child: Icon(
                //           Icons.thumb_up_alt_outlined,
                //           color: AppColor.secondaryColor,
                //         )),
                //   ),
                // )
              ],
            ),
          ),
          Constant.kheight(height: size.width * .02),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * .027),
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
                          height: size.height * .045,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: currentIndex == index
                                  ? AppColor.green
                                  : AppColor.whiteColor,
                              border: Border.all(color: AppColor.green),
                              borderRadius:
                                  BorderRadius.circular(size.width * .045)),
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
          Constant.kheight(height: size.width * .01),
          currentIndex == 0
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .02),
                  child: viewPost(profileModel: profileModel, size: size),
                )
              : const SizedBox(),
          currentIndex == 1
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .03),
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
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: profileModel.traderposts!.isEmpty
              ? 0
              : profileModel.traderoffers!.length,
          separatorBuilder: (context, index) =>
              Constant.kheight(height: size.width * .01),
          itemBuilder: (context, index) {
            Traderoffers traderOffer = profileModel.traderoffers![index];

            return profileModel.traderposts!.isEmpty
                ? const SizedBox()
                : Card(
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
                          ]),
                          const Divider(
                            color: Colors.grey,
                          ),
                          Constant.kheight(height: size.width * .017),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: ReadMoreText(
                                  traderOffer.offerDescription.toString(),
                                  numLines: 3,
                                  readMoreAlign: Alignment.centerLeft,
                                  style: TextStyle(fontSize: size.width * .033),
                                  readMoreTextStyle: TextStyle(
                                      fontSize: size.width * .033,
                                      color: Colors.blue),
                                  readMoreText: 'Read More',
                                  readLessText: 'Read Less',
                                ),
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
                                    itemCount: traderOffer.offerImages!.isEmpty
                                        ? 0
                                        : traderOffer.offerImages!.length,
                                    itemBuilder: (context, index) {
                                      return traderOffer.offerImages!.isEmpty
                                          ? const SizedBox()
                                          : Container(
                                              padding: EdgeInsets.all(
                                                  size.width * .01),
                                              child: ImgFade.fadeImage(
                                                  url: traderOffer
                                                      .offerImages![index]),
                                            );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Price",
                                        style: TextStyle(
                                            fontSize: size.width * .03),
                                      ),
                                      Text(
                                        "\$ ${traderOffer.fullPrice.toString()}",
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                      Constant.kheight(
                                          height: size.width * .012),
                                      Text("Discount Price",
                                          style: TextStyle(
                                              fontSize: size.width * .03)),
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
    return ListView.separated(
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
                Constant.kheight(height: size.width * .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: ReadMoreText(
                        traderPost.postContent.toString(),
                        numLines: 3,
                        readMoreAlign: Alignment.centerLeft,
                        style: TextStyle(fontSize: size.width * .033),
                        readMoreTextStyle: TextStyle(
                            fontSize: size.width * .033, color: Colors.blue),
                        readMoreText: 'Read More',
                        readLessText: 'Read Less',
                      ),
                      // child: Text(
                      //   providerPost.postContent.toString(),
                      //   style: TextStyle(fontSize: size.width * .035),
                      // ),
                    ),
                  ],
                ),
                Constant.kheight(height: size.width * .03),
                SizedBox(
                  width: size.width,
                  height: size.height * .25,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: traderPost.postImages!.length,
                    itemBuilder: (context, index) {
                      final images = traderPost.postImages![index];
                      return Container(
                        padding: EdgeInsets.all(size.width * .01),
                        child: ImgFade.fadeImage(
                            width: size.width * .9, url: images),
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
    );
  }
}
