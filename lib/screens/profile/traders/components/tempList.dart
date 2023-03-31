import 'package:codecarrots_unotraders/model/add_review_comment_model.dart';
import 'package:codecarrots_unotraders/model/view_customer_review_model.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewReviewScreenTemp extends StatefulWidget {
  final String userId;
  final bool isProfileVisit;
  const ViewReviewScreenTemp(
      {super.key, required this.userId, required this.isProfileVisit});

  @override
  State<ViewReviewScreenTemp> createState() => _ViewReviewScreenState();
}

class _ViewReviewScreenState extends State<ViewReviewScreenTemp> {
  late ProfileProvider profileProvider;
  FocusNode replyFocus = FocusNode();
  FocusNode postCommentFocus = FocusNode();
  @override
  void dispose() {
    replyFocus.dispose();
    postCommentFocus.dispose();

    super.dispose();
  }

  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<ProfileProvider>(
        builder: (context, ProfileProvider provider, _) {
      return provider.isReviewLoading
          ? SizedBox(
              width: size.width,
              height: 200,
              child: const Center(child: CircularProgressIndicator()))
          : provider.allReviewList.isEmpty
              ? SizedBox()
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: provider.allReviewList.length,
                  itemBuilder: (context, index) {
                    final mainReview = provider.allReviewList[index];
                    DateTime createdDate =
                        DateTime.parse(mainReview.createdAt ?? "");
                    return Card(
                      child: Column(
                        children: [
                          AppConstant.kheight(height: size.width * .018),
                          Row(
                            children: [
                              AppConstant.kWidth(width: size.width * .018),
                              mainReview.profilePic == null ||
                                      mainReview.profilePic!.isEmpty
                                  ? CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      child: Image.asset(
                                        PngImages.profile,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: AppColor.green,
                                      radius: size.width * .055,
                                      child: CircleAvatar(
                                        radius: size.width * .049,
                                        backgroundImage: NetworkImage(
                                            mainReview.profilePic ?? ""),
                                      ),
                                    ),
                              AppConstant.kWidth(width: size.width * .018),
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
                                            data: mainReview.name ?? '',
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: AppColor.blackColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          AppConstant.kheight(
                                              height: size.width * .005),
                                          TextWidget(
                                            data:
                                                "Posted: ${createdDate.day} ${DateFormat.MMM().format(createdDate)} ${createdDate.year}",
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppConstant.kWidth(width: size.width * .03),
                              Flexible(
                                child: ReadMoreText(
                                  mainReview.review.toString(),
                                  readMoreIconColor: AppColor.blackColor,
                                  numLines: 3,
                                  readMoreAlign: Alignment.centerLeft,
                                  style: TextStyle(fontSize: size.width * .033),
                                  readMoreTextStyle: TextStyle(
                                      fontSize: size.width * .033,
                                      color: Colors.black),
                                  readMoreText: 'Read More',
                                  readLessText: 'Read Less',
                                ),
                              ),
                            ],
                          ),
                          mainReview.comment == null
                              ? SizedBox()
                              : mainReview.comment!.isEmpty
                                  ? SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: mainReview.comment!.length,
                                        itemBuilder: (context, subIndex) {
                                          final subReview =
                                              mainReview.comment![subIndex];
                                          DateTime subDate = DateTime.parse(
                                              subReview.createdAt ?? "");
                                          return subCommentCard(
                                              size,
                                              subReview,
                                              context,
                                              subDate,
                                              subIndex,
                                              mainReview);
                                        },
                                      ),
                                    ),

                          AppConstant.kheight(height: 10),
                          //main text field
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: size.width * .09,
                                width: size.width * .627,
                                child: TextFieldWidget(
                                    controller: provider
                                        .reviewTextControllerList[index],
                                    hintText: "Write Something",
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (p0) {
                                      replyFocus.unfocus();
                                    },
                                    onEditingComplete: () =>
                                        FocusScope.of(context).nextFocus(),
                                    validate: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "This field is required";
                                      } else {
                                        return null;
                                      }
                                    }),
                              ),
                              InkWell(
                                onTap: () async {
                                  replyFocus.unfocus();
                                  FocusScope.of(context).nextFocus();
                                  final _sharedPrefs =
                                      await SharedPreferences.getInstance();
                                  String userType = _sharedPrefs
                                      .getString('userType')
                                      .toString();

                                  final userId =
                                      _sharedPrefs.getString('id').toString();
                                  AddReviewCommentModel add =
                                      AddReviewCommentModel(
                                          comment: provider
                                              .reviewTextControllerList[index]
                                              .text,
                                          reviewId: mainReview.id,
                                          traderId: mainReview.traderId,
                                          userId: int.parse(userId),
                                          userType: userType);
                                  if (provider.reviewTextControllerList[index]
                                      .text.isEmpty) {
                                  } else {
                                    await profileProvider.addMainReview(
                                        traderId:
                                            mainReview.traderId.toString(),
                                        addMainReview: add,
                                        url: Url.addMainReviewComment);
                                  }
                                },
                                child: Container(
                                  width: size.width * .2,
                                  alignment: Alignment.center,
                                  height: size.width * .086,
                                  decoration: const BoxDecoration(
                                      color: AppColor.green),
                                  child: provider
                                              .reviewTextControllerList[index]
                                              .text
                                              .isNotEmpty &&
                                          provider.isUpLoading
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : TextWidget(
                                          data: "Reply",
                                          style: TextStyle(
                                              color: AppColor.whiteColor),
                                        ),
                                ),
                              )
                            ],
                          ),
                          AppConstant.kheight(height: 10)
                        ],
                      ),
                    );
                  },
                );
    });
  }

  Widget subCommentCard(
      Size size,
      Comment subReview,
      BuildContext context,
      DateTime replyCreatedDate,
      int index,
      ViewCustomerReviewModel mainReview) {
    return Column(
      children: [
        Card(
          color: Color(0XFFEEFFEC),
          child: Consumer<ProfileProvider>(
              builder: (context, ProfileProvider provider, _) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .03, vertical: size.width * .02),
              child: Column(
                children: [
                  Row(
                    children: [
                      subReview.profilePic == null ||
                              subReview.profilePic!.isEmpty
                          ? CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.06,
                              child: Image.asset(
                                PngImages.profile,
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: AppColor.green,
                              radius: size.width * .055,
                              child: CircleAvatar(
                                radius: size.width * .049,
                                backgroundImage:
                                    NetworkImage(subReview.profilePic ?? ""),
                              ),
                            ),
                      AppConstant.kWidth(width: size.width * .018),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    data: subReview.name ?? "",
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: AppColor.blackColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  AppConstant.kheight(
                                      height: size.width * .005),
                                  TextWidget(
                                    data:
                                        "Posted: ${replyCreatedDate.day} ${DateFormat.MMM().format(replyCreatedDate)} ${replyCreatedDate.year}",
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: ReadMoreText(
                          subReview.comment.toString(),
                          readMoreIconColor: AppColor.blackColor,
                          numLines: 3,
                          readMoreAlign: Alignment.centerLeft,
                          style: TextStyle(fontSize: size.width * .033),
                          readMoreTextStyle: TextStyle(
                              fontSize: size.width * .033, color: Colors.black),
                          readMoreText: 'Read More',
                          readLessText: 'Read Less',
                        ),
                      ),
                    ],
                  ),
                  subReview.replies == null
                      ? SizedBox()
                      : subReview.replies!.isEmpty
                          ? SizedBox()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: subReview.replies!.length,
                              itemBuilder: (context, sindex) {
                                final subCommentReply =
                                    subReview.replies![sindex];
                                DateTime createdDate = DateTime.parse(
                                    subCommentReply.createdAt ?? "");
                                return sindex > 0 &&
                                        provider.expandable[index] == false
                                    ? null
                                    : subCommentReplyCard(size, subCommentReply,
                                        context, createdDate);
                              },
                            ),
                  subReview.replies == null
                      ? SizedBox()
                      : subReview.replies!.isEmpty
                          ? SizedBox()
                          : subReview.replies!.length > 1
                              ? Consumer<ProfileProvider>(builder:
                                  (context, ProfileProvider provider, _) {
                                  return InkWell(
                                    onTap: () {
                                      profileProvider.expandComment(
                                          index: index);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * .048,
                                          vertical: provider.expandable[index]
                                              ? size.width * .02
                                              : size.width * .02),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: size.width * .05,
                                          width: size.width * .2,
                                          decoration: BoxDecoration(
                                              color: AppColor.green),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.share,
                                                size: size.width * .037,
                                                color: AppColor.whiteColor,
                                              ),
                                              AppConstant.kWidth(
                                                  width: size.width * .009),
                                              TextWidget(
                                                data: provider.expandable[index]
                                                    ? "Hide"
                                                    : "${subReview.replies!.length - 1} Reply",
                                                style: TextStyle(
                                                    color: AppColor.whiteColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                })
                              : SizedBox(),

                  AppConstant.kheight(height: 7),

                  //reply textfield
                  Consumer<ProfileProvider>(
                      builder: (context, ProfileProvider provider, _) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(2),
                            bottomLeft: Radius.circular(2),
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: size.width * .09,
                            width: size.width * .55,
                            child: TextFieldWidget(
                                removeBorder: true,
                                controller: provider
                                    .reviewReplyTextControllerList[index],
                                hintText: "",
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (p0) {
                                  replyFocus.unfocus();
                                },
                                onEditingComplete: () =>
                                    FocusScope.of(context).nextFocus(),
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This field is required";
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          InkWell(
                            onTap: () async {
                              replyFocus.unfocus();
                              FocusScope.of(context).nextFocus();
                              final _sharedPrefs =
                                  await SharedPreferences.getInstance();
                              String userType =
                                  _sharedPrefs.getString('userType').toString();

                              final userId =
                                  _sharedPrefs.getString('id').toString();
                              AddReviewCommentModel add = AddReviewCommentModel(
                                  reviewCommentId: subReview.id,
                                  comment: provider
                                      .reviewReplyTextControllerList[index]
                                      .text,
                                  reviewId: mainReview.id,
                                  traderId: mainReview.traderId,
                                  userId: int.parse(userId),
                                  userType: userType);
                              if (provider.reviewReplyTextControllerList[index]
                                  .text.isEmpty) {
                                print("pressed empty");
                              } else {
                                print("pressed not");
                                await profileProvider.addMainReview(
                                    traderId: mainReview.traderId.toString(),
                                    addMainReview: add,
                                    url: Url.addReplyReviewComment);
                              }
                            },
                            child: Container(
                              width: size.width * .2,
                              alignment: Alignment.center,
                              height: size.width * .09,
                              decoration:
                                  const BoxDecoration(color: AppColor.green),
                              child: provider
                                          .reviewReplyTextControllerList[index]
                                          .text
                                          .isNotEmpty &&
                                      provider.isUpLoading
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : TextWidget(
                                      data: "Reply",
                                      style:
                                          TextStyle(color: AppColor.whiteColor),
                                    ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                  AppConstant.kheight(height: 7),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Card subCommentReplyCard(Size size, Replies subCommentReply,
      BuildContext context, DateTime replyCreatedDate) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * .03, vertical: size.width * .02),
        child: Column(
          children: [
            Row(
              children: [
                subCommentReply.profilePic == null ||
                        subCommentReply.profilePic!.isEmpty
                    ? CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.06,
                        child: Image.asset(
                          PngImages.profile,
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: AppColor.green,
                        radius: size.width * .055,
                        child: CircleAvatar(
                          radius: size.width * .049,
                          backgroundImage:
                              NetworkImage(subCommentReply.profilePic ?? ""),
                        ),
                      ),
                AppConstant.kWidth(width: size.width * .018),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextWidget(
                              data: subCommentReply.name ?? "",
                              maxLines: 1,
                              style: TextStyle(
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AppConstant.kheight(height: size.width * .005),
                            TextWidget(
                              data:
                                  "Posted: ${replyCreatedDate.day} ${DateFormat.MMM().format(replyCreatedDate)} ${replyCreatedDate.year}",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: ReadMoreText(
                    subCommentReply.comment.toString(),
                    readMoreIconColor: AppColor.blackColor,
                    numLines: 3,
                    readMoreAlign: Alignment.centerLeft,
                    style: TextStyle(fontSize: size.width * .033),
                    readMoreTextStyle: TextStyle(
                        fontSize: size.width * .033, color: Colors.black),
                    readMoreText: 'Read More',
                    readLessText: 'Read Less',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
