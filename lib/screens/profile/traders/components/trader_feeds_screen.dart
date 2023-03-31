import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:codecarrots_unotraders/model/add_post.dart';
import 'package:codecarrots_unotraders/model/feed_reaction_model.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/Profile/comment%20section/comment_screen.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/trader_post_popup.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:custom_pointed_popup/custom_pointed_popup.dart';
import 'package:custom_pointed_popup/utils/triangle_painter.dart';
import 'package:el_tooltip2/el_tooltip2.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:just_the_tooltip_fork/just_the_tooltip_fork.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:super_tooltip_ext/super_tooltip.dart';

import '../../../../model/Feeds/trader_feed_model.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

class TraderFeedScreen extends StatefulWidget {
  final bool isCustomer;
  final String userid;
  final bool isProfileVisit;
  const TraderFeedScreen(
      {super.key,
      required this.userid,
      required this.isProfileVisit,
      required this.isCustomer});

  @override
  State<TraderFeedScreen> createState() => _TraderFeedScreenState();
}

class _TraderFeedScreenState extends State<TraderFeedScreen> {
  late ImagePickProvider imagePickProvider;
  late ProfileProvider profileProvider;
  late FocusNode postTitleFocus;
  late FocusNode descriptionFocus;
  late TextEditingController postTitleController;
  late TextEditingController descriptionController;
  bool isLoading = false;

  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    imagePickProvider = Provider.of<ImagePickProvider>(context, listen: false);
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

  final GlobalKey widgetKey = GlobalKey();

  CustomPointedPopup getCustomPointedPopup(BuildContext context) {
    return CustomPointedPopup(
      backgroundColor: Colors.red,
      context: context,

      widthFractionWithRespectToDeviceWidth: 3,
      displayBelowWidget: true,
      triangleDirection: TriangleDirection.FullLeft,
      popupElevation: 10,

      ///you can also add border radius
      ////popupBorderRadius:,
      item: CustomPointedPopupItem(
        title: '',
        iconWidget: Icon(
          Icons.add_moderator,
          color: Theme.of(context).cardColor,
        ),
      ),
      onClickWidget: (onClickMenu) {
        print('popup item clicked');
      },
      onDismiss: () {
        print('on dismissed called');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("feed screen>>");

    return Consumer<ProfileProvider>(
        builder: (context, ProfileProvider provider, _) {
      return provider.isFeedLoading
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: const Center(child: CircularProgressIndicator()))
          : Column(
              children: [
                //post title
                AppConstant.kheight(height: 5),
                widget.isProfileVisit
                    ? const SizedBox()
                    : InkWell(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (context) =>
                                TraderPostPopUp(userid: widget.userid),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColor.green,
                              border: Border.all(color: AppColor.green)),
                          child: TextWidget(
                            data: "Add Post",
                            style: TextStyle(color: AppColor.whiteColor),
                          ),
                        ),
                      ),

                AppConstant.kheight(height: 8),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.feed.length,
                  separatorBuilder: (context, index) =>
                      AppConstant.kheight(height: 5),
                  itemBuilder: (context, index) {
                    TraderFeedModel traderPost = provider.feed[index];
                    DateTime createdAt = DateTime.parse(traderPost.createdAt!);

                    return InkWell(
                      onTap: provider.currentFeedReactionIndex == null
                          ? () {}
                          : () {
                              profileProvider.closeAllFeedReaction();
                            },
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 2,
                        shadowColor: AppColor.blackColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColor.green,
                                    radius: 27,
                                    child: CircleAvatar(
                                      backgroundColor: AppColor.whiteColor,
                                      radius: 23,
                                      backgroundImage: NetworkImage(
                                          traderPost.profilePic ?? ""),
                                    ),
                                  ),
                                  AppConstant.kWidth(width: 7),
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
                                                data: traderPost.name ?? "",
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: AppColor.blackColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              TextWidget(
                                                data:
                                                    "Posted: ${createdAt.day} ${DateFormat.MMM().format(createdAt)} ${createdAt.year}, ${DateFormat('hh:mm a').format(createdAt)}",
                                              )
                                            ],
                                          ),
                                        ),
                                        widget.isCustomer == true
                                            ? Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 9, vertical: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: AppColor.green),
                                                child: TextWidget(
                                                  data: "Report",
                                                  style: TextStyle(
                                                      color:
                                                          AppColor.whiteColor),
                                                ),
                                              )
                                            : widget.isProfileVisit
                                                ? const SizedBox()
                                                : Container(
                                                    margin: EdgeInsets.all(8),
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        color: AppColor.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: IconButton(
                                                        // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .penToSquare,
                                                          color: AppColor
                                                              .whiteColor,
                                                          size: 16,
                                                        ),
                                                        onPressed: () async {
                                                          String? res =
                                                              await showDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                TraderPostPopUp(
                                                                    userid: widget
                                                                        .userid,
                                                                    traderPost:
                                                                        traderPost),
                                                          );
                                                        }),
                                                  )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              // Row(children: [
                              //   Expanded(
                              //     child: TextWidget(
                              //       data: traderPost.title.toString(),
                              //       style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: size.width * .035),
                              //     ),
                              //   ),
                              // widget.isProfileVisit
                              //     ? const SizedBox()
                              //     : Container(
                              //         margin:
                              //             EdgeInsets.all(size.width * 0.02),
                              //         height: size.width * 0.07,
                              //         width: size.width * 0.07,
                              //         decoration: BoxDecoration(
                              //             color: AppColor.green,
                              //             borderRadius: BorderRadius.circular(
                              //                 size.width * 0.02)),
                              //         child: IconButton(
                              //             // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                              //             icon: FaIcon(
                              //               FontAwesomeIcons.penToSquare,
                              //               color: AppColor.whiteColor,
                              //               size: size.width * 0.04,
                              //             ),
                              //             onPressed: () async {
                              //               String? res = await showDialog(
                              //                 context: context,
                              //                 builder: (context) =>
                              //                     TraderPostPopUp(
                              //                         userid: widget.userid,
                              //                         traderPost: traderPost),
                              //               );
                              //             }),
                              //       )
                              // ]),
                              // const Divider(
                              //   color: Colors.grey,
                              // ),
                              // SizedBox(
                              //   width: size.width,
                              //   child: Row(
                              //     children: [
                              //       Container(
                              //         padding: EdgeInsets.all(size.width * .01),
                              //         height: size.width * .07,
                              //         alignment: Alignment.center,
                              //         decoration: BoxDecoration(
                              //             border:
                              //                 Border.all(color: AppColor.green),
                              //             borderRadius: BorderRadius.circular(
                              //                 size.width * .03)),
                              //         child: Center(
                              //           child: Row(
                              //             children: [
                              //               Padding(
                              //                 padding: EdgeInsets.all(
                              //                     size.width * .01),
                              //                 child: Icon(
                              //                   Icons.calendar_month_outlined,
                              //                   color: AppColor.green,
                              //                   size: size.width * .03,
                              //                 ),
                              //               ),
                              //               AppConstant.kWidth(
                              //                   width: size.width * .01),
                              //               TextWidget(
                              //                   data:
                              //                       '${createdAt.day}/${createdAt.month}/${createdAt.year}'),
                              //               AppConstant.kWidth(
                              //                   width: size.width * .02),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //       AppConstant.kWidth(width: size.width * .03),
                              //       //full price
                              //       Container(
                              //         height: size.width * .07,
                              //         alignment: Alignment.center,
                              //         decoration: BoxDecoration(
                              //             border:
                              //                 Border.all(color: AppColor.green),
                              //             borderRadius: BorderRadius.circular(
                              //                 size.width * .03)),
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.start,
                              //           children: [
                              //             Padding(
                              //               padding: EdgeInsets.all(
                              //                   size.width * .01),
                              //               child: Icon(
                              //                 Icons.access_time,
                              //                 size: size.width * .03,
                              //                 color: AppColor.green,
                              //               ),
                              //             ),
                              //             AppConstant.kWidth(
                              //                 width: size.width * .01),
                              //             TextWidget(
                              //                 data: DateFormat('hh:mm a')
                              //                     .format(createdAt)),
                              //             AppConstant.kWidth(
                              //                 width: size.width * .03),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              AppConstant.kheight(height: 8),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  child: ListView.builder(
                                    itemCount: traderPost.postImages!.length,
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, imgIndex) => Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          traderPost.postImages![imgIndex],
                                          fit: BoxFit.cover,
                                          width: 230,
                                        ),
                                      ),
                                    ),
                                  )),
                              AppConstant.kheight(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: ReadMoreText(
                                      traderPost.postContent.toString(),
                                      readMoreIconColor: AppColor.green,
                                      numLines: 3,
                                      readMoreAlign: Alignment.centerLeft,
                                      style: TextStyle(fontSize: 16),
                                      readMoreTextStyle: TextStyle(
                                          fontSize: 13, color: Colors.green),
                                      readMoreText: 'Read More',
                                      readLessText: 'Read Less',
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              // Container(
                              //   width: 220,
                              //   height: 30,
                              //   decoration:
                              //       BoxDecoration(color: Colors.grey.shade200),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     children: [
                              //       SvgPicture.asset(
                              //         'assets/image/like.svg',
                              //         height: 35,
                              //       ),
                              //       SvgPicture.asset(
                              //         'assets/image/heart.svg',
                              //         height: 35,
                              //       ),
                              //       SvgPicture.asset(
                              //         'assets/image/laughing.svg',
                              //         height: 35,
                              //       ),
                              //       SvgPicture.asset(
                              //         'assets/image/angry.svg',
                              //         height: 35,
                              //       ),
                              //       SvgPicture.asset(
                              //         'assets/image/sad.svg',
                              //         height: 35,
                              //       ),
                              //       SvgPicture.asset(
                              //         'assets/image/wow.svg',
                              //         height: 35,
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // Center(
                              //   child: Stack(
                              //     children: [
                              //       Column(
                              //         children: [
                              //           SizedBox(
                              //             height: 25,
                              //           ),
                              //           Row(
                              //             children: [
                              //               Container(
                              //                   alignment: Alignment.center,
                              //                   height: size.width * .07,
                              //                   width: size.width * .1,
                              //                   decoration: BoxDecoration(
                              //                       border: Border.all(
                              //                           color: Colors.grey),
                              //                       boxShadow: const [
                              //                         BoxShadow(
                              //                             color: Colors.white,
                              //                             spreadRadius: 1)
                              //                       ],
                              //                       borderRadius:
                              //                           BorderRadius.circular(
                              //                               15)),
                              //                   child: const FaIcon(
                              //                     FontAwesomeIcons.thumbsUp,
                              //                     color: AppColor.primaryColor,
                              //                   )),
                              //               AppConstant.kWidth(
                              //                   width: size.width * .03),
                              //               InkWell(
                              //                 onTap: () {
                              //                   Navigator.push(
                              //                       context,
                              //                       PageTransition(
                              //                           type: PageTransitionType
                              //                               .fade,
                              //                           child: CommentScreen(
                              //                             postId: traderPost.id
                              //                                 .toString(),
                              //                             postImages: traderPost
                              //                                 .postImages!,
                              //                             profilePic: traderPost
                              //                                     .profilePic ??
                              //                                 "",
                              //                             description:
                              //                                 traderPost
                              //                                     .postContent
                              //                                     .toString(),
                              //                             replyUrl: Url
                              //                                 .postFeedReplyComment,
                              //                             postCommentUrl: Url
                              //                                 .postFeedComment,
                              //                             endPoint:
                              //                                 'traderpostcomments',
                              //                             traderId: traderPost
                              //                                 .traderId
                              //                                 .toString(),
                              //                           )));
                              //                 },
                              //                 child: Container(
                              //                     alignment: Alignment.center,
                              //                     height: size.width * .07,
                              //                     width: size.width * .1,
                              //                     decoration: BoxDecoration(
                              //                         border: Border.all(
                              //                             color: Colors.grey),
                              //                         boxShadow: const [
                              //                           BoxShadow(
                              //                               color: Colors.white,
                              //                               spreadRadius: 1)
                              //                         ],
                              //                         borderRadius:
                              //                             BorderRadius.circular(
                              //                                 15)),
                              //                     child: FaIcon(
                              //                       FontAwesomeIcons
                              //                           .commentDots,
                              //                       color:
                              //                           AppColor.primaryColor,
                              //                     )),
                              //               ),
                              //             ],
                              //           )
                              //         ],
                              //       ),
                              //       Positioned(
                              //         top: 17,
                              //         child: Container(
                              //           width: 220,
                              //           height: 30,
                              //           decoration: BoxDecoration(),
                              //           child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.start,
                              //             children: [
                              // SvgPicture.asset(
                              //   'assets/image/like.svg',
                              //   height: 35,
                              // ),
                              //               SvgPicture.asset(
                              //                 'assets/image/heart.svg',
                              //                 height: 35,
                              //               ),
                              //               SvgPicture.asset(
                              //                 'assets/image/laughing.svg',
                              //                 height: 35,
                              //               ),
                              //               SvgPicture.asset(
                              //                 'assets/image/angry.svg',
                              //                 height: 35,
                              //               ),
                              //               SvgPicture.asset(
                              //                 'assets/image/sad.svg',
                              //                 height: 35,
                              //               ),
                              //               SvgPicture.asset(
                              //                 'assets/image/wow.svg',
                              //                 height: 35,
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // )
                              // ReactionContainer(
                              //     onReactionChanged: (value) {},
                              //     child:
                              //         SizedBox(height: 40, child: Text("data")),
                              //     reactions: [
                              //       Reaction(
                              //           icon: Icon(Icons.percent), value: 1),
                              //       Reaction(
                              //           icon: Icon(Icons.javascript), value: 2),
                              //       Reaction(
                              //           icon: Icon(Icons.wallet), value: 3),
                              //       Reaction(
                              //           icon: Icon(Icons.wallet_giftcard),
                              //           value: 4)
                              //     ]),
                              // SizedBox(
                              //   child: ReactionButton(
                              //     initialReaction: Reaction(
                              //         icon: Container(
                              //             alignment: Alignment.center,
                              //             height: size.width * .07,
                              //             width: size.width * .1,
                              //             decoration: BoxDecoration(
                              //                 border: Border.all(
                              //                     color: Colors.grey),
                              //                 boxShadow: const [
                              //                   BoxShadow(
                              //                       color: Colors.white,
                              //                       spreadRadius: 1)
                              //                 ],
                              //                 borderRadius:
                              //                     BorderRadius.circular(15)),
                              //             child: const FaIcon(
                              //               FontAwesomeIcons.thumbsUp,
                              //               color: AppColor.primaryColor,
                              //             )),
                              //         value: 7),

                              //     //  Reaction(
                              //     //     icon: SvgPicture.asset(
                              //     //       'assets/image/sad.svg',
                              //     //       height: 35,
                              //     //     ),
                              //     //     value: 7),
                              //     itemScale: 0.1,
                              //     boxOffset: Offset(90, 170),
                              //     boxElevation: 0,
                              //     boxReactionSpacing: 0,
                              //     boxHorizontalPosition:
                              //         HorizontalPosition.CENTER,
                              //     boxRadius: 0,
                              //     onReactionChanged: (value) {
                              //       print(value.toString());
                              //     },
                              //     reactions: [
                              //       Reaction(
                              //           icon: SvgPicture.asset(
                              //             'assets/image/like.svg',
                              //             height: 35,
                              //           ),
                              //           value: 1),
                              //       Reaction(
                              //           icon: SvgPicture.asset(
                              //             'assets/image/heart.svg',
                              //             height: 35,
                              //           ),
                              //           value: 2),
                              //       Reaction(
                              //           icon: SvgPicture.asset(
                              //             'assets/image/laughing.svg',
                              //             height: 35,
                              //           ),
                              //           value: 3),
                              //       Reaction(
                              //           icon: SvgPicture.asset(
                              //             'assets/image/wow.svg',
                              //             height: 35,
                              //           ),
                              //           value: 4),
                              //       Reaction(
                              //           icon: SvgPicture.asset(
                              //             'assets/image/sad.svg',
                              //             height: 35,
                              //           ),
                              //           value: 5),
                              //       Reaction(
                              //           icon: SvgPicture.asset(
                              //             'assets/image/angry.svg',
                              //             height: 35,
                              //           ),
                              //           value: 6),
                              //     ],
                              //   ),
                              // )

                              //reaction button
                              // SizedBox(
                              //   height: 40,
                              //   child: Row(
                              //     children: [
                              //       Row(
                              //         children: [
                              //           // SizedBox(
                              //           //   child: ReactionButton(
                              //           //     itemScale: 0.01,
                              //           //     shouldChangeReaction: true,
                              //           //     boxOffset: Offset(110, 10),
                              //           //     boxElevation: 0,
                              //           //     boxReactionSpacing: 0,
                              //           //     boxPosition: VerticalPosition.TOP,
                              //           //     boxHorizontalPosition:
                              //           //         HorizontalPosition.START,
                              //           //     boxRadius: 50,
                              //           //     initialReaction: Reaction(
                              //           //         icon: Container(
                              //           //             alignment: Alignment.center,
                              //           //             height: 35,
                              //           //             width: 50,
                              //           //             decoration: BoxDecoration(
                              //           //                 border: Border.all(
                              //           //                     color: Colors.grey),
                              //           //                 boxShadow: const [
                              //           //                   BoxShadow(
                              //           //                       color: Colors.white,
                              //           //                       spreadRadius: 1)
                              //           //                 ],
                              //           //                 borderRadius:
                              //           //                     BorderRadius.circular(
                              //           //                         15)),
                              //           //             child: const FaIcon(
                              //           //               FontAwesomeIcons.thumbsUp,
                              //           //               color:
                              //           //                   AppColor.primaryColor,
                              //           //             )),
                              //           //         value: 7),

                              //           //     //  Reaction(
                              //           //     //     icon: SvgPicture.asset(
                              //           //     //       'assets/image/sad.svg',
                              //           //     //       height: 35,
                              //           //     //     ),
                              //           //     //     value: 7),

                              //           //     onReactionChanged: (value) {
                              //           //       print(value.toString());
                              //           //     },
                              //           //     reactions: [
                              //           //       Reaction(
                              //           //           icon: Padding(
                              //           //             padding: const EdgeInsets
                              //           //                 .symmetric(horizontal: 5),
                              //           //             child: SvgPicture.asset(
                              //           //               'assets/image/like.svg',
                              //           //               height: 35,
                              //           //             ),
                              //           //           ),
                              //           //           value: 1),
                              //           //       Reaction(
                              //           //           icon: Padding(
                              //           //             padding: const EdgeInsets
                              //           //                 .symmetric(horizontal: 5),
                              //           //             child: SvgPicture.asset(
                              //           //               'assets/image/heart.svg',
                              //           //               height: 35,
                              //           //             ),
                              //           //           ),
                              //           //           value: 2),
                              //           //       Reaction(
                              //           //           icon: Padding(
                              //           //             padding: const EdgeInsets
                              //           //                 .symmetric(horizontal: 5),
                              //           //             child: SvgPicture.asset(
                              //           //               'assets/image/laughing.svg',
                              //           //               height: 35,
                              //           //             ),
                              //           //           ),
                              //           //           value: 3),
                              //           //       Reaction(
                              //           //           icon: Padding(
                              //           //             padding: const EdgeInsets
                              //           //                 .symmetric(horizontal: 5),
                              //           //             child: SvgPicture.asset(
                              //           //               'assets/image/wow.svg',
                              //           //               height: 35,
                              //           //             ),
                              //           //           ),
                              //           //           value: 4),
                              //           //       Reaction(
                              //           //           icon: Padding(
                              //           //             padding: const EdgeInsets
                              //           //                 .symmetric(horizontal: 5),
                              //           //             child: SvgPicture.asset(
                              //           //               'assets/image/sad.svg',
                              //           //               height: 35,
                              //           //             ),
                              //           //           ),
                              //           //           value: 5),
                              //           //       Reaction(
                              //           //           icon: Padding(
                              //           //             padding: const EdgeInsets
                              //           //                 .symmetric(horizontal: 5),
                              //           //             child: SvgPicture.asset(
                              //           //               'assets/image/angry.svg',
                              //           //               height: 35,
                              //           //             ),
                              //           //           ),
                              //           //           value: 6),
                              //           //     ],
                              //           //   ),
                              //           // ),

                              //           // InkWell(
                              //           //   onTap: () {

                              //           //   },
                              //           //   child: Container(
                              //           //       alignment: Alignment.center,
                              //           //       height: 35,
                              //           //       width: 50,
                              //           //       decoration: BoxDecoration(
                              //           //           border: Border.all(
                              //           //               color: Colors.grey),
                              //           //           boxShadow: const [
                              //           //             BoxShadow(
                              //           //                 color: Colors.white,
                              //           //                 spreadRadius: 1)
                              //           //           ],
                              //           //           borderRadius:
                              //           //               BorderRadius.circular(15)),
                              //           //       child: const FaIcon(
                              //           //         FontAwesomeIcons.thumbsUp,
                              //           //         color: AppColor.primaryColor,
                              //           //       )),
                              //           // ),
                              //           AppConstant.kWidth(width: 12),
                              //           InkWell(
                              //             onTap: () {
                              //               Navigator.push(
                              //                   context,
                              //                   PageTransition(
                              //                       type: PageTransitionType.fade,
                              //                       child: CommentScreen(
                              //                         postId: traderPost.id
                              //                             .toString(),
                              //                         postImages:
                              //                             traderPost.postImages!,
                              //                         profilePic:
                              //                             traderPost.profilePic ??
                              //                                 "",
                              //                         description: traderPost
                              //                             .postContent
                              //                             .toString(),
                              //                         replyUrl: Url
                              //                             .postFeedReplyComment,
                              //                         postCommentUrl:
                              //                             Url.postFeedComment,
                              //                         endPoint:
                              //                             'traderpostcomments',
                              //                         traderId: traderPost
                              //                             .traderId
                              //                             .toString(),
                              //                       )));
                              //             },
                              //             child: Container(
                              //                 alignment: Alignment.center,
                              //                 height: 35,
                              //                 width: 50,
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
                              //       )
                              //     ],
                              //   ),
                              // ),
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
                                            InkWell(
                                              onTap: () {
                                                profileProvider
                                                    .changeFeedReactionByIndex(
                                                        index);
                                              },
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  height: 40,
                                                  width: 40,
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
                                                    color:
                                                        AppColor.primaryColor,
                                                  )),
                                            ),
                                            AppConstant.kWidth(width: 12),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .fade,
                                                        child: CommentScreen(
                                                          postId: traderPost.id
                                                              .toString(),
                                                          postImages: traderPost
                                                              .postImages!,
                                                          profilePic: traderPost
                                                                  .profilePic ??
                                                              "",
                                                          description:
                                                              traderPost
                                                                  .postContent
                                                                  .toString(),
                                                          replyUrl: Url
                                                              .postFeedReplyComment,
                                                          postCommentUrl: Url
                                                              .postFeedComment,
                                                          endPoint:
                                                              'traderpostcomments',
                                                          traderId: traderPost
                                                              .traderId
                                                              .toString(),
                                                        )));
                                              },
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  height: 40,
                                                  width: 40,
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
                                                    FontAwesomeIcons
                                                        .commentDots,
                                                    color:
                                                        AppColor.primaryColor,
                                                  )),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Positioned(
                                      top: 3,
                                      child:
                                          provider.currentFeedReactionIndex ==
                                                      index &&
                                                  traderPost.isReactionOpened!
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
                                                            profileProvider.postReaction(
                                                                postId: traderPost
                                                                        .id ??
                                                                    0,
                                                                reactionEmoji:
                                                                    ReactionKeyword
                                                                            .Like
                                                                        .toString(),
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
                                                            profileProvider.postReaction(
                                                                postId: traderPost
                                                                        .id ??
                                                                    0,
                                                                reactionEmoji:
                                                                    ReactionKeyword
                                                                            .Love
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
                                                            profileProvider.postReaction(
                                                                postId: traderPost
                                                                        .id ??
                                                                    0,
                                                                reactionEmoji:
                                                                    ReactionKeyword
                                                                            .HaHa
                                                                        .toString(),
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
                                                            profileProvider.postReaction(
                                                                postId: traderPost
                                                                        .id ??
                                                                    0,
                                                                reactionEmoji:
                                                                    ReactionKeyword
                                                                            .Angry
                                                                        .toString(),
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
                                                            profileProvider.postReaction(
                                                                postId: traderPost
                                                                        .id ??
                                                                    0,
                                                                reactionEmoji:
                                                                    ReactionKeyword
                                                                            .Sad
                                                                        .toString(),
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
                                                            profileProvider.postReaction(
                                                                postId: traderPost
                                                                        .id ??
                                                                    0,
                                                                reactionEmoji:
                                                                    ReactionKeyword
                                                                            .Wow
                                                                        .toString(),
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
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
    });
  }
}




// import 'dart:io';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:codecarrots_unotraders/model/add_post.dart';
// import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
// import 'package:codecarrots_unotraders/provider/profile_provider.dart';
// import 'package:codecarrots_unotraders/screens/Profile/comment%20section/comment_screen.dart';
// import 'package:codecarrots_unotraders/screens/Profile/traders/trader_post_popup.dart';
// import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
// import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
// import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
// import 'package:codecarrots_unotraders/services/helper/url.dart';
// import 'package:codecarrots_unotraders/utils/color.dart';
// import 'package:codecarrots_unotraders/utils/app_constant.dart';
// import 'package:custom_pointed_popup/custom_pointed_popup.dart';
// import 'package:custom_pointed_popup/utils/triangle_painter.dart';
// import 'package:el_tooltip2/el_tooltip2.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import 'package:flutter_svg/svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:just_the_tooltip_fork/just_the_tooltip_fork.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';
// import 'package:read_more_text/read_more_text.dart';

// import '../../../../model/Feeds/trader_feed_model.dart';
// import 'package:flutter_reaction_button/flutter_reaction_button.dart';

// class TraderFeedScreen extends StatefulWidget {
//   final bool isCustomer;
//   final String userid;
//   final bool isProfileVisit;
//   const TraderFeedScreen(
//       {super.key,
//       required this.userid,
//       required this.isProfileVisit,
//       required this.isCustomer});

//   @override
//   State<TraderFeedScreen> createState() => _TraderFeedScreenState();
// }

// class _TraderFeedScreenState extends State<TraderFeedScreen> {
//   late ImagePickProvider imagePickProvider;
//   late ProfileProvider profileProvider;
//   late FocusNode postTitleFocus;
//   late FocusNode descriptionFocus;
//   late TextEditingController postTitleController;
//   late TextEditingController descriptionController;
//   bool isLoading = false;
//   @override
//   final _formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     profileProvider = Provider.of<ProfileProvider>(context, listen: false);
//     imagePickProvider = Provider.of<ImagePickProvider>(context, listen: false);
//     initialize();

//     super.initState();
//   }

//   initialize() {
//     postTitleFocus = FocusNode();
//     descriptionFocus = FocusNode();
//     postTitleController = TextEditingController();
//     descriptionController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     postTitleFocus.dispose();
//     descriptionFocus.dispose();
//     postTitleController.dispose();
//     descriptionController.dispose();
//   }

//   clearField() {
//     postTitleController.clear();
//     descriptionController.clear();
//     imagePickProvider.clearImage();
//     postTitleFocus.unfocus();
//     descriptionFocus.unfocus();
//   }

//   final GlobalKey widgetKey = GlobalKey();

//   CustomPointedPopup getCustomPointedPopup(BuildContext context) {
//     return CustomPointedPopup(
//       backgroundColor: Colors.red,
//       context: context,

//       widthFractionWithRespectToDeviceWidth: 3,
//       displayBelowWidget: true,
//       triangleDirection: TriangleDirection.FullLeft,
//       popupElevation: 10,

//       ///you can also add border radius
//       ////popupBorderRadius:,
//       item: CustomPointedPopupItem(
//         title: '',
//         iconWidget: Icon(
//           Icons.add_moderator,
//           color: Theme.of(context).cardColor,
//         ),
//       ),
//       onClickWidget: (onClickMenu) {
//         print('popup item clicked');
//       },
//       onDismiss: () {
//         print('on dismissed called');
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("feed screen");
//     final size = MediaQuery.of(context).size;
//     return Consumer<ProfileProvider>(
//         builder: (context, ProfileProvider provider, _) {
//       return provider.isFeedLoading
//           ? SizedBox(
//               width: size.width,
//               height: 200,
//               child: const Center(child: CircularProgressIndicator()))
//           : Column(
//               children: [
//                 //post title
//                 AppConstant.kheight(height: size.width * .017),
//                 widget.isProfileVisit
//                     ? const SizedBox()
//                     : InkWell(
//                         onTap: () async {
//                           await showDialog(
//                             context: context,
//                             builder: (context) =>
//                                 TraderPostPopUp(userid: widget.userid),
//                           );
//                         },
//                         child: Container(
//                           alignment: Alignment.center,
//                           height: size.width * .1,
//                           width: size.width,
//                           decoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadius.circular(size.width * .04),
//                               color: AppColor.green,
//                               border: Border.all(color: AppColor.green)),
//                           child: TextWidget(
//                             data: "Add Post",
//                             style: TextStyle(color: AppColor.whiteColor),
//                           ),
//                         ),
//                       ),

//                 AppConstant.kheight(height: size.width * .017),
//                 ListView.separated(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: provider.feed.length,
//                   separatorBuilder: (context, index) =>
//                       AppConstant.kheight(height: size.width * .01),
//                   itemBuilder: (context, index) {
//                     TraderFeedModel traderPost = provider.feed[index];
//                     DateTime createdAt = DateTime.parse(traderPost.createdAt!);

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
//                             Row(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: AppColor.green,
//                                   radius: size.width * .055,
//                                   child: CircleAvatar(
//                                     radius: size.width * .049,
//                                     backgroundImage: NetworkImage(
//                                         traderPost.profilePic ?? ""),
//                                   ),
//                                 ),
//                                 AppConstant.kWidth(width: size.width * .018),
//                                 Expanded(
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             TextWidget(
//                                               data: traderPost.name ?? "",
//                                               maxLines: 1,
//                                               style: TextStyle(
//                                                   color: AppColor.blackColor,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: size.width * .036),
//                                             ),
//                                             TextWidget(
//                                               data:
//                                                   "Posted: ${createdAt.day} ${DateFormat.MMM().format(createdAt)} ${createdAt.year}, ${DateFormat('hh:mm a').format(createdAt)}",
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       widget.isCustomer == true
//                                           ? Container(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: size.width * .023,
//                                                   vertical: size.width * .01),
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           size.width * .03),
//                                                   color: AppColor.green),
//                                               child: TextWidget(
//                                                 data: "Report",
//                                                 style: TextStyle(
//                                                     color: AppColor.whiteColor),
//                                               ),
//                                             )
//                                           : widget.isProfileVisit
//                                               ? const SizedBox()
//                                               : Container(
//                                                   margin: EdgeInsets.all(
//                                                       size.width * 0.02),
//                                                   height: size.width * 0.07,
//                                                   width: size.width * 0.07,
//                                                   decoration: BoxDecoration(
//                                                       color: AppColor.green,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               size.width *
//                                                                   0.02)),
//                                                   child: IconButton(
//                                                       // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
//                                                       icon: FaIcon(
//                                                         FontAwesomeIcons
//                                                             .penToSquare,
//                                                         color:
//                                                             AppColor.whiteColor,
//                                                         size: size.width * 0.04,
//                                                       ),
//                                                       onPressed: () async {
//                                                         String? res =
//                                                             await showDialog(
//                                                           context: context,
//                                                           builder: (context) =>
//                                                               TraderPostPopUp(
//                                                                   userid: widget
//                                                                       .userid,
//                                                                   traderPost:
//                                                                       traderPost),
//                                                         );
//                                                       }),
//                                                 )
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                             // Row(children: [
//                             //   Expanded(
//                             //     child: TextWidget(
//                             //       data: traderPost.title.toString(),
//                             //       style: TextStyle(
//                             //           fontWeight: FontWeight.bold,
//                             //           fontSize: size.width * .035),
//                             //     ),
//                             //   ),
//                             // widget.isProfileVisit
//                             //     ? const SizedBox()
//                             //     : Container(
//                             //         margin:
//                             //             EdgeInsets.all(size.width * 0.02),
//                             //         height: size.width * 0.07,
//                             //         width: size.width * 0.07,
//                             //         decoration: BoxDecoration(
//                             //             color: AppColor.green,
//                             //             borderRadius: BorderRadius.circular(
//                             //                 size.width * 0.02)),
//                             //         child: IconButton(
//                             //             // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
//                             //             icon: FaIcon(
//                             //               FontAwesomeIcons.penToSquare,
//                             //               color: AppColor.whiteColor,
//                             //               size: size.width * 0.04,
//                             //             ),
//                             //             onPressed: () async {
//                             //               String? res = await showDialog(
//                             //                 context: context,
//                             //                 builder: (context) =>
//                             //                     TraderPostPopUp(
//                             //                         userid: widget.userid,
//                             //                         traderPost: traderPost),
//                             //               );
//                             //             }),
//                             //       )
//                             // ]),
//                             // const Divider(
//                             //   color: Colors.grey,
//                             // ),
//                             // SizedBox(
//                             //   width: size.width,
//                             //   child: Row(
//                             //     children: [
//                             //       Container(
//                             //         padding: EdgeInsets.all(size.width * .01),
//                             //         height: size.width * .07,
//                             //         alignment: Alignment.center,
//                             //         decoration: BoxDecoration(
//                             //             border:
//                             //                 Border.all(color: AppColor.green),
//                             //             borderRadius: BorderRadius.circular(
//                             //                 size.width * .03)),
//                             //         child: Center(
//                             //           child: Row(
//                             //             children: [
//                             //               Padding(
//                             //                 padding: EdgeInsets.all(
//                             //                     size.width * .01),
//                             //                 child: Icon(
//                             //                   Icons.calendar_month_outlined,
//                             //                   color: AppColor.green,
//                             //                   size: size.width * .03,
//                             //                 ),
//                             //               ),
//                             //               AppConstant.kWidth(
//                             //                   width: size.width * .01),
//                             //               TextWidget(
//                             //                   data:
//                             //                       '${createdAt.day}/${createdAt.month}/${createdAt.year}'),
//                             //               AppConstant.kWidth(
//                             //                   width: size.width * .02),
//                             //             ],
//                             //           ),
//                             //         ),
//                             //       ),
//                             //       AppConstant.kWidth(width: size.width * .03),
//                             //       //full price
//                             //       Container(
//                             //         height: size.width * .07,
//                             //         alignment: Alignment.center,
//                             //         decoration: BoxDecoration(
//                             //             border:
//                             //                 Border.all(color: AppColor.green),
//                             //             borderRadius: BorderRadius.circular(
//                             //                 size.width * .03)),
//                             //         child: Row(
//                             //           mainAxisAlignment:
//                             //               MainAxisAlignment.start,
//                             //           children: [
//                             //             Padding(
//                             //               padding: EdgeInsets.all(
//                             //                   size.width * .01),
//                             //               child: Icon(
//                             //                 Icons.access_time,
//                             //                 size: size.width * .03,
//                             //                 color: AppColor.green,
//                             //               ),
//                             //             ),
//                             //             AppConstant.kWidth(
//                             //                 width: size.width * .01),
//                             //             TextWidget(
//                             //                 data: DateFormat('hh:mm a')
//                             //                     .format(createdAt)),
//                             //             AppConstant.kWidth(
//                             //                 width: size.width * .03),
//                             //           ],
//                             //         ),
//                             //       ),
//                             //     ],
//                             //   ),
//                             // ),
//                             AppConstant.kheight(height: size.width * .017),
//                             SizedBox(
//                                 width: size.width,
//                                 height: size.height * .25,
//                                 child: Container(
//                                   child: ListView.builder(
//                                     itemCount: traderPost.postImages!.length,
//                                     scrollDirection: Axis.horizontal,
//                                     physics: BouncingScrollPhysics(),
//                                     itemBuilder: (context, index) => Padding(
//                                       padding: const EdgeInsets.only(right: 7),
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(10),
//                                         child: Image.network(
//                                           traderPost.postImages![index],
//                                           fit: BoxFit.cover,
//                                           width: 220,
//                                         ),
//                                       ),
//                                     ),
//                                   ),

//                                   //   CarouselSlider.builder(
//                                   // itemCount:
//                                   //     traderPost.postImages!.length,
//                                   //       itemBuilder:
//                                   //           (context, carIndex, realIndex) {
//                                   //         return Container(
//                                   //           padding:
//                                   //               const EdgeInsets.only(right: 5),
//                                   //           child: ClipRRect(
//                                   // borderRadius:
//                                   //     BorderRadius.circular(
//                                   //         size.width * .02),
//                                   // child: Image.network(
//                                   //   traderPost
//                                   //       .postImages![carIndex],
//                                   //   fit: BoxFit.cover,
//                                   // ),
//                                   //           ),
//                                   //         );
//                                   //       },
//                                   //       options: CarouselOptions(
//                                   //         padEnds: false,
//                                   //         scrollPhysics:
//                                   //             const BouncingScrollPhysics(),
//                                   //         clipBehavior: Clip.antiAlias,
//                                   //         enableInfiniteScroll: false,
//                                   //         autoPlayAnimationDuration:
//                                   //             const Duration(milliseconds: 200),
//                                   //         viewportFraction: .56,
//                                   //         height: size.width * .5,
//                                   //         autoPlay: false,
//                                   //         reverse: false,
//                                   //         autoPlayInterval:
//                                   //             const Duration(seconds: 5),
//                                   //       )),
//                                 )),
//                             AppConstant.kheight(height: size.width * .017),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Flexible(
//                                   child: ReadMoreText(
//                                     traderPost.postContent.toString(),
//                                     readMoreIconColor: AppColor.green,
//                                     numLines: 3,
//                                     readMoreAlign: Alignment.centerLeft,
//                                     style:
//                                         TextStyle(fontSize: size.width * .033),
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
//                             // Container(
//                             //   width: 220,
//                             //   height: 30,
//                             //   decoration:
//                             //       BoxDecoration(color: Colors.grey.shade200),
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment.start,
//                             //     children: [
//                             //       SvgPicture.asset(
//                             //         'assets/image/like.svg',
//                             //         height: 35,
//                             //       ),
//                             //       SvgPicture.asset(
//                             //         'assets/image/heart.svg',
//                             //         height: 35,
//                             //       ),
//                             //       SvgPicture.asset(
//                             //         'assets/image/laughing.svg',
//                             //         height: 35,
//                             //       ),
//                             //       SvgPicture.asset(
//                             //         'assets/image/angry.svg',
//                             //         height: 35,
//                             //       ),
//                             //       SvgPicture.asset(
//                             //         'assets/image/sad.svg',
//                             //         height: 35,
//                             //       ),
//                             //       SvgPicture.asset(
//                             //         'assets/image/wow.svg',
//                             //         height: 35,
//                             //       )
//                             //     ],
//                             //   ),
//                             // ),
//                             // Center(
//                             //   child: Stack(
//                             //     children: [
//                             //       Column(
//                             //         children: [
//                             //           SizedBox(
//                             //             height: 25,
//                             //           ),
//                             //           Row(
//                             //             children: [
//                             //               Container(
//                             //                   alignment: Alignment.center,
//                             //                   height: size.width * .07,
//                             //                   width: size.width * .1,
//                             //                   decoration: BoxDecoration(
//                             //                       border: Border.all(
//                             //                           color: Colors.grey),
//                             //                       boxShadow: const [
//                             //                         BoxShadow(
//                             //                             color: Colors.white,
//                             //                             spreadRadius: 1)
//                             //                       ],
//                             //                       borderRadius:
//                             //                           BorderRadius.circular(
//                             //                               15)),
//                             //                   child: const FaIcon(
//                             //                     FontAwesomeIcons.thumbsUp,
//                             //                     color: AppColor.primaryColor,
//                             //                   )),
//                             //               AppConstant.kWidth(
//                             //                   width: size.width * .03),
//                             //               InkWell(
//                             //                 onTap: () {
//                             //                   Navigator.push(
//                             //                       context,
//                             //                       PageTransition(
//                             //                           type: PageTransitionType
//                             //                               .fade,
//                             //                           child: CommentScreen(
//                             //                             postId: traderPost.id
//                             //                                 .toString(),
//                             //                             postImages: traderPost
//                             //                                 .postImages!,
//                             //                             profilePic: traderPost
//                             //                                     .profilePic ??
//                             //                                 "",
//                             //                             description:
//                             //                                 traderPost
//                             //                                     .postContent
//                             //                                     .toString(),
//                             //                             replyUrl: Url
//                             //                                 .postFeedReplyComment,
//                             //                             postCommentUrl: Url
//                             //                                 .postFeedComment,
//                             //                             endPoint:
//                             //                                 'traderpostcomments',
//                             //                             traderId: traderPost
//                             //                                 .traderId
//                             //                                 .toString(),
//                             //                           )));
//                             //                 },
//                             //                 child: Container(
//                             //                     alignment: Alignment.center,
//                             //                     height: size.width * .07,
//                             //                     width: size.width * .1,
//                             //                     decoration: BoxDecoration(
//                             //                         border: Border.all(
//                             //                             color: Colors.grey),
//                             //                         boxShadow: const [
//                             //                           BoxShadow(
//                             //                               color: Colors.white,
//                             //                               spreadRadius: 1)
//                             //                         ],
//                             //                         borderRadius:
//                             //                             BorderRadius.circular(
//                             //                                 15)),
//                             //                     child: FaIcon(
//                             //                       FontAwesomeIcons
//                             //                           .commentDots,
//                             //                       color:
//                             //                           AppColor.primaryColor,
//                             //                     )),
//                             //               ),
//                             //             ],
//                             //           )
//                             //         ],
//                             //       ),
//                             //       Positioned(
//                             //         top: 17,
//                             //         child: Container(
//                             //           width: 220,
//                             //           height: 30,
//                             //           decoration: BoxDecoration(),
//                             //           child: Row(
//                             //             mainAxisAlignment:
//                             //                 MainAxisAlignment.start,
//                             //             children: [
//                             // SvgPicture.asset(
//                             //   'assets/image/like.svg',
//                             //   height: 35,
//                             // ),
//                             //               SvgPicture.asset(
//                             //                 'assets/image/heart.svg',
//                             //                 height: 35,
//                             //               ),
//                             //               SvgPicture.asset(
//                             //                 'assets/image/laughing.svg',
//                             //                 height: 35,
//                             //               ),
//                             //               SvgPicture.asset(
//                             //                 'assets/image/angry.svg',
//                             //                 height: 35,
//                             //               ),
//                             //               SvgPicture.asset(
//                             //                 'assets/image/sad.svg',
//                             //                 height: 35,
//                             //               ),
//                             //               SvgPicture.asset(
//                             //                 'assets/image/wow.svg',
//                             //                 height: 35,
//                             //               )
//                             //             ],
//                             //           ),
//                             //         ),
//                             //       ),
//                             //     ],
//                             //   ),
//                             // )
//                             // ReactionContainer(
//                             //     onReactionChanged: (value) {},
//                             //     child:
//                             //         SizedBox(height: 40, child: Text("data")),
//                             //     reactions: [
//                             //       Reaction(
//                             //           icon: Icon(Icons.percent), value: 1),
//                             //       Reaction(
//                             //           icon: Icon(Icons.javascript), value: 2),
//                             //       Reaction(
//                             //           icon: Icon(Icons.wallet), value: 3),
//                             //       Reaction(
//                             //           icon: Icon(Icons.wallet_giftcard),
//                             //           value: 4)
//                             //     ]),
//                             // SizedBox(
//                             //   child: ReactionButton(
//                             //     initialReaction: Reaction(
//                             //         icon: Container(
//                             //             alignment: Alignment.center,
//                             //             height: size.width * .07,
//                             //             width: size.width * .1,
//                             //             decoration: BoxDecoration(
//                             //                 border: Border.all(
//                             //                     color: Colors.grey),
//                             //                 boxShadow: const [
//                             //                   BoxShadow(
//                             //                       color: Colors.white,
//                             //                       spreadRadius: 1)
//                             //                 ],
//                             //                 borderRadius:
//                             //                     BorderRadius.circular(15)),
//                             //             child: const FaIcon(
//                             //               FontAwesomeIcons.thumbsUp,
//                             //               color: AppColor.primaryColor,
//                             //             )),
//                             //         value: 7),

//                             //     //  Reaction(
//                             //     //     icon: SvgPicture.asset(
//                             //     //       'assets/image/sad.svg',
//                             //     //       height: 35,
//                             //     //     ),
//                             //     //     value: 7),
//                             //     itemScale: 0.1,
//                             //     boxOffset: Offset(90, 170),
//                             //     boxElevation: 0,
//                             //     boxReactionSpacing: 0,
//                             //     boxHorizontalPosition:
//                             //         HorizontalPosition.CENTER,
//                             //     boxRadius: 0,
//                             //     onReactionChanged: (value) {
//                             //       print(value.toString());
//                             //     },
//                             //     reactions: [
//                             //       Reaction(
//                             //           icon: SvgPicture.asset(
//                             //             'assets/image/like.svg',
//                             //             height: 35,
//                             //           ),
//                             //           value: 1),
//                             //       Reaction(
//                             //           icon: SvgPicture.asset(
//                             //             'assets/image/heart.svg',
//                             //             height: 35,
//                             //           ),
//                             //           value: 2),
//                             //       Reaction(
//                             //           icon: SvgPicture.asset(
//                             //             'assets/image/laughing.svg',
//                             //             height: 35,
//                             //           ),
//                             //           value: 3),
//                             //       Reaction(
//                             //           icon: SvgPicture.asset(
//                             //             'assets/image/wow.svg',
//                             //             height: 35,
//                             //           ),
//                             //           value: 4),
//                             //       Reaction(
//                             //           icon: SvgPicture.asset(
//                             //             'assets/image/sad.svg',
//                             //             height: 35,
//                             //           ),
//                             //           value: 5),
//                             //       Reaction(
//                             //           icon: SvgPicture.asset(
//                             //             'assets/image/angry.svg',
//                             //             height: 35,
//                             //           ),
//                             //           value: 6),
//                             //     ],
//                             //   ),
//                             // )
//                             Row(
//                               children: [
//                                 Expanded(
//                                     child: Container(
//                                   child: Row(
//                                     children: [
//                                       SizedBox(
//                                         child: ReactionButton(
//                                           initialReaction: Reaction(
//                                               icon: Container(
//                                                   alignment: Alignment.center,
//                                                   height: size.width * .07,
//                                                   width: size.width * .1,
//                                                   decoration: BoxDecoration(
//                                                       border: Border.all(
//                                                           color: Colors.grey),
//                                                       boxShadow: const [
//                                                         BoxShadow(
//                                                             color: Colors.white,
//                                                             spreadRadius: 1)
//                                                       ],
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15)),
//                                                   child: const FaIcon(
//                                                     FontAwesomeIcons.thumbsUp,
//                                                     color:
//                                                         AppColor.primaryColor,
//                                                   )),
//                                               value: 7),

//                                           //  Reaction(
//                                           //     icon: SvgPicture.asset(
//                                           //       'assets/image/sad.svg',
//                                           //       height: 35,
//                                           //     ),
//                                           //     value: 7),
//                                           itemScale: 0.1,
//                                           boxOffset: Offset(110, 170),
//                                           // boxElevation: 0,
//                                           // boxReactionSpacing: 0,
//                                           // boxHorizontalPosition:
//                                           //     HorizontalPosition.CENTER,
//                                           // boxRadius: 0,
//                                           onReactionChanged: (value) {
//                                             print(value.toString());
//                                           },
//                                           reactions: [
//                                             Reaction(
//                                                 icon: Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(horizontal: 5),
//                                                   child: SvgPicture.asset(
//                                                     'assets/image/like.svg',
//                                                     height: 35,
//                                                   ),
//                                                 ),
//                                                 value: 1),
//                                             Reaction(
//                                                 icon: Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(horizontal: 5),
//                                                   child: SvgPicture.asset(
//                                                     'assets/image/heart.svg',
//                                                     height: 35,
//                                                   ),
//                                                 ),
//                                                 value: 2),
//                                             Reaction(
//                                                 icon: Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(horizontal: 5),
//                                                   child: SvgPicture.asset(
//                                                     'assets/image/laughing.svg',
//                                                     height: 35,
//                                                   ),
//                                                 ),
//                                                 value: 3),
//                                             Reaction(
//                                                 icon: Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(horizontal: 5),
//                                                   child: SvgPicture.asset(
//                                                     'assets/image/wow.svg',
//                                                     height: 35,
//                                                   ),
//                                                 ),
//                                                 value: 4),
//                                             Reaction(
//                                                 icon: Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(horizontal: 5),
//                                                   child: SvgPicture.asset(
//                                                     'assets/image/sad.svg',
//                                                     height: 35,
//                                                   ),
//                                                 ),
//                                                 value: 5),
//                                             Reaction(
//                                                 icon: Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(horizontal: 5),
//                                                   child: SvgPicture.asset(
//                                                     'assets/image/angry.svg',
//                                                     height: 35,
//                                                   ),
//                                                 ),
//                                                 value: 6),
//                                           ],
//                                         ),
//                                       ),
//                                       // Container(
//                                       //     alignment: Alignment.center,
//                                       //     height: size.width * .07,
//                                       //     width: size.width * .1,
//                                       //     decoration: BoxDecoration(
//                                       //         border: Border.all(
//                                       //             color: Colors.grey),
//                                       //         boxShadow: const [
//                                       //           BoxShadow(
//                                       //               color: Colors.white,
//                                       //               spreadRadius: 1)
//                                       //         ],
//                                       //         borderRadius:
//                                       //             BorderRadius.circular(15)),
//                                       //     child: const FaIcon(
//                                       //       FontAwesomeIcons.thumbsUp,
//                                       //       color: AppColor.primaryColor,
//                                       //     )),
//                                       AppConstant.kWidth(
//                                           width: size.width * .03),
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.push(
//                                               context,
//                                               PageTransition(
//                                                   type: PageTransitionType.fade,
//                                                   child: CommentScreen(
//                                                     postId: traderPost.id
//                                                         .toString(),
//                                                     postImages:
//                                                         traderPost.postImages!,
//                                                     profilePic:
//                                                         traderPost.profilePic ??
//                                                             "",
//                                                     description: traderPost
//                                                         .postContent
//                                                         .toString(),
//                                                     replyUrl: Url
//                                                         .postFeedReplyComment,
//                                                     postCommentUrl:
//                                                         Url.postFeedComment,
//                                                     endPoint:
//                                                         'traderpostcomments',
//                                                     traderId: traderPost
//                                                         .traderId
//                                                         .toString(),
//                                                   )));
//                                         },
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
//                                                     BorderRadius.circular(15)),
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
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             );
//     });
//   }
// }
