import 'package:codecarrots_unotraders/model/feed_reaction_model.dart';
import 'package:codecarrots_unotraders/model/offer%20listing/trader_offer_listing.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/Profile/comment%20section/comment_screen.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/post_an_offer_dialog.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:show_up_animation/show_up_animation.dart';

class TraderOfferScreen extends StatelessWidget {
  final String userid;
  final bool isProfileVisit;
  const TraderOfferScreen(
      {super.key, required this.userid, required this.isProfileVisit});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return Consumer<ProfileProvider>(
        builder: (context, ProfileProvider provider, _) {
      return provider.isOfferLoading
          ? SizedBox(
              width: size.width,
              height: 200,
              child: const Center(child: CircularProgressIndicator()))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppConstant.kheight(height: size.width * .012),
                isProfileVisit
                    ? const SizedBox()
                    : InkWell(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => const PostAnOfferDialog(),
                          );
                          // setState(() {});
                          // profileProvider.getTraderOffers(
                          //     userType: 'trader', userId: userid);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: size.width * .1,
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(size.width * .04),
                              color: AppColor.green,
                              border: Border.all(color: AppColor.green)),
                          child: TextWidget(
                            data: "Post Offer",
                            style: TextStyle(color: AppColor.whiteColor),
                          ),
                        ),
                      ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.offerListing.length,
                  separatorBuilder: (context, index) =>
                      AppConstant.kheight(height: size.width * .01),
                  itemBuilder: (context, index) {
                    TraderOfferListingModel traderOffer =
                        provider.offerListing[index];

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
                              Row(children: [
                                Expanded(
                                  child: TextWidget(
                                    data: traderOffer.title.toString(),
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
                                      borderRadius: BorderRadius.circular(
                                          size.width * 0.02)),
                                  child: IconButton(
                                      // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                      icon: FaIcon(
                                        FontAwesomeIcons.penToSquare,
                                        color: AppColor.whiteColor,
                                        size: size.width * 0.04,
                                      ),
                                      onPressed: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (context) =>
                                              PostAnOfferDialog(
                                                  traderOffer: traderOffer),
                                        );
                                      }),
                                )
                              ]),
                              const Divider(
                                color: Colors.grey,
                              ),
                              AppConstant.kheight(height: size.width * .017),
                              Row(
                                children: [
                                  Expanded(
                                      child: DottedBorder(
                                    color: Colors.black,
                                    strokeWidth: 1,
                                    child: Container(
                                      height: 40,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            // decoration: BoxDecoration(
                                            //     border: Border.all(color: AppColor.blackColor)),
                                            child: TextWidget(
                                                data:
                                                    "Valid From; ${traderOffer.validFrom}"),
                                            height: 40,
                                          )),
                                          const VerticalDivider(),
                                          Expanded(
                                              child: Container(
                                            height: 40,
                                            child: TextWidget(
                                              data:
                                                  "Expire; ${traderOffer.validTo}",
                                              style: const TextStyle(
                                                  color: AppColor.red),
                                            ),
                                            alignment: Alignment.center,
                                            // decoration: BoxDecoration(
                                            //     border: Border.all(color: AppColor.blackColor)),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                              AppConstant.kheight(height: size.width * .017),
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: size.width * .05,
                                          width: size.width * .3,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      size.width * .01),
                                              color: const Color(0XFFFCE9C8)),
                                          child: TextWidget(
                                              data:
                                                  "Offer Price \$ ${traderOffer.discountPrice.toString()}"),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: size.width * .05,
                                          width: size.width * .3,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      size.width * .01),
                                              color: const Color(0XFFDAFAD3)),
                                          child: TextWidget(
                                              data:
                                                  "Full Price \$ ${traderOffer.fullPrice.toString()}"),
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                              AppConstant.kheight(height: size.width * .017),
                              SizedBox(
                                  width: size.width,
                                  height: size.height * .25,
                                  child: Container(
                                    child: ListView.builder(
                                      itemCount:
                                          traderOffer.traderofferimages!.length,
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 7),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            traderOffer
                                                .traderofferimages![index],
                                            fit: BoxFit.cover,
                                            width: 220,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                              // SizedBox(
                              //     width: size.width,
                              //     height: size.height * .25,
                              //     child: Container(
                              //       child: CarouselSlider.builder(
                              //           itemCount:
                              //               traderOffer.traderofferimages!.length,
                              //           itemBuilder:
                              //               (context, cIndex, realIndex) {
                              //             final image = traderOffer
                              //                 .traderofferimages![cIndex];
                              //             return Container(
                              //               padding:
                              //                   const EdgeInsets.only(right: 5),
                              //               child: ClipRRect(
                              //                 borderRadius:
                              //                     BorderRadius.circular(15),
                              //                 child: Image.network(image,
                              //                     fit: BoxFit.fill,
                              //                     width: size.width * .9),
                              //               ),
                              //             );
                              //           },
                              //           options: CarouselOptions(
                              //             padEnds: false,
                              //             scrollPhysics:
                              //                 const BouncingScrollPhysics(),
                              //             clipBehavior: Clip.antiAlias,
                              //             enableInfiniteScroll: false,
                              //             autoPlayAnimationDuration:
                              //                 const Duration(milliseconds: 200),
                              //             viewportFraction: .56,
                              //             height: size.width * .5,
                              //             autoPlay: false,
                              //             reverse: false,
                              //             autoPlayInterval:
                              //                 const Duration(seconds: 5),
                              //           )),
                              //     )),
                              AppConstant.kheight(height: size.width * .012),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: ReadMoreText(
                                      traderOffer.description.toString(),
                                      numLines: 3,
                                      readMoreIconColor: AppColor.green,
                                      readMoreAlign: Alignment.centerLeft,
                                      style: TextStyle(
                                          fontSize: size.width * .033),
                                      readMoreTextStyle: TextStyle(
                                          fontSize: size.width * .033,
                                          color: AppColor.green),
                                      readMoreText: 'Read More',
                                      readLessText: 'Read Less',
                                    ),
                                  ),
                                ],
                              ),
                              AppConstant.kheight(height: size.width * .01),
                              const Divider(),
                              traderOffer.likes == null ||
                                      traderOffer.firstUser == null
                                  ? const SizedBox()
                                  : traderOffer.likes! == 0
                                      ? const SizedBox()
                                      :
                                      //  traderOffer.likes! == 1 &&
                                      //         traderOffer.emoji != null &&
                                      //         traderOffer.emoji!.isNotEmpty
                                      //     ? SizedBox()
                                      //     :
                                      Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 17,
                                              backgroundColor: AppColor.green,
                                              child: Icon(
                                                Icons.thumb_up,
                                                color: AppColor.whiteColor,
                                                size: 17,
                                              ),
                                            ),
                                            AppConstant.kWidth(width: 10),
                                            traderOffer.likes == 1
                                                ? TextWidget(
                                                    data: traderOffer.emoji ==
                                                                null ||
                                                            traderOffer
                                                                .emoji!.isEmpty
                                                        ? "${traderOffer.firstUser}"
                                                        : "You"

                                                    //  traderOffer.emoji ==
                                                    //         null
                                                    //     ? traderOffer
                                                    //             .emoji!.isEmpty
                                                    //         ? "${traderOffer.firstUser}"
                                                    //         : "${traderOffer.firstUser}"
                                                    //     : "you"

                                                    )
                                                : TextWidget(
                                                    data: traderOffer.emoji ==
                                                                null ||
                                                            traderOffer
                                                                .emoji!.isEmpty
                                                        ? "${traderOffer.firstUser} and ${traderOffer.likes! - 1} others"
                                                        : "You and ${traderOffer.likes! - 1} others"

                                                    //  traderOffer.emoji ==
                                                    //         null
                                                    //     ? traderOffer
                                                    //             .emoji!.isEmpty
                                                    //         ? "${traderOffer.firstUser}and ${traderOffer.likes! - 1} others"
                                                    //         : "${traderOffer.firstUser}and ${traderOffer.likes! - 1} others"
                                                    //     : "You and ${traderOffer.likes! - 1} others"

                                                    ),
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
                                                    traderOffer
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
                                                        alignment:
                                                            Alignment.center,
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                            BoxDecoration(
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
                                                        child: traderOffer
                                                                        .emoji !=
                                                                    null &&
                                                                traderOffer
                                                                    .emoji!
                                                                    .isNotEmpty
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  currentReaction(
                                                                      traderOffer
                                                                          .emoji!),
                                                                  height: 35,
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
                                                    traderOffer
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
                                                                postId: traderOffer
                                                                    .id
                                                                    .toString(),
                                                                postImages:
                                                                    traderOffer
                                                                        .traderofferimages!,
                                                                profilePic:
                                                                    traderOffer
                                                                            .profilePic ??
                                                                        "",
                                                                description: traderOffer
                                                                    .description
                                                                    .toString(),
                                                                replyUrl: Url
                                                                    .postFeedReplyComment,
                                                                postCommentUrl:
                                                                    Url.postFeedComment,
                                                                endPoint:
                                                                    'traderpostcomments',
                                                                traderId: traderOffer
                                                                    .traderId
                                                                    .toString(),
                                                              )));
                                                    },
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
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
                                                  traderOffer.isReactionOpened!
                                              ? ShowUpAnimation(
                                                  delayStart:
                                                      Duration(seconds: 0),
                                                  animationDuration:
                                                      Duration(milliseconds: 1),
                                                  curve: Curves.bounceIn,
                                                  direction: Direction.vertical,
                                                  offset: 0.5,
                                                  child: Container(
                                                    width: 220,
                                                    height: 30,
                                                    decoration: BoxDecoration(),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            profileProvider.postOfferReaction(
                                                                postId:
                                                                    traderOffer
                                                                            .id ??
                                                                        0,
                                                                reactionEmoji:
                                                                    reactionKeyword[
                                                                        0],
                                                                index: index);
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/image/like.svg',
                                                            height: 35,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            profileProvider.postOfferReaction(
                                                                postId:
                                                                    traderOffer
                                                                            .id ??
                                                                        0,
                                                                reactionEmoji:
                                                                    reactionKeyword[
                                                                            1]
                                                                        .toString(),
                                                                index: index);
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/image/heart.svg',
                                                            height: 35,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            profileProvider.postOfferReaction(
                                                                postId:
                                                                    traderOffer
                                                                            .id ??
                                                                        0,
                                                                reactionEmoji:
                                                                    reactionKeyword[
                                                                        2],
                                                                index: index);
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/image/laughing.svg',
                                                            height: 35,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            profileProvider.postOfferReaction(
                                                                postId:
                                                                    traderOffer
                                                                            .id ??
                                                                        0,
                                                                reactionEmoji:
                                                                    reactionKeyword[
                                                                        3],
                                                                index: index);
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/image/angry.svg',
                                                            height: 35,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            profileProvider.postOfferReaction(
                                                                postId:
                                                                    traderOffer
                                                                            .id ??
                                                                        0,
                                                                reactionEmoji:
                                                                    reactionKeyword[
                                                                        4],
                                                                index: index);
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/image/sad.svg',
                                                            height: 35,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            profileProvider.postOfferReaction(
                                                                postId:
                                                                    traderOffer
                                                                            .id ??
                                                                        0,
                                                                reactionEmoji:
                                                                    reactionKeyword[
                                                                        5],
                                                                index: index);
                                                          },
                                                          child:
                                                              SvgPicture.asset(
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
                              //                         BorderRadius.circular(15)),
                              //                 child: const FaIcon(
                              //                   FontAwesomeIcons.thumbsUp,
                              //                   color: AppColor.primaryColor,
                              //                 )),
                              //           ),
                              //           AppConstant.kWidth(
                              //               width: size.width * .03),
                              //           InkWell(
                              //             onTap: () {
                              // Navigator.push(
                              //     context,
                              //     PageTransition(
                              //         type: PageTransitionType.fade,
                              //         child: CommentScreen(
                              //           postId: traderOffer.id
                              //               .toString(),
                              //           postImages: traderOffer
                              //               .traderofferimages!,
                              //           profilePic: traderOffer
                              //                   .profilePic ??
                              //               "",
                              //           description: traderOffer
                              //               .description
                              //               .toString(),
                              //           replyUrl: Url
                              //               .postFeedReplyComment,
                              //           postCommentUrl:
                              //               Url.postFeedComment,
                              //           endPoint:
                              //               'traderpostcomments',
                              //           traderId: traderOffer
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
                              //                         BorderRadius.circular(15)),
                              //                 child: FaIcon(
                              //                   FontAwesomeIcons.commentDots,
                              //                   color: AppColor.primaryColor,
                              //                 )),
                              //           ),
                              //         ],
                              //       ),
                              //     ))
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            );
    });
  }
}
