import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:codecarrots_unotraders/model/diy_help_listing_model.dart';
import 'package:codecarrots_unotraders/model/diy_help_post_reply_model.dart';
import 'package:codecarrots_unotraders/provider/help_provider.dart';
import 'package:codecarrots_unotraders/screens/DIY%20Help/diy_help_popup.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiyHelpScreen extends StatefulWidget {
  const DiyHelpScreen({super.key});

  @override
  State<DiyHelpScreen> createState() => _DiyHelpScreenState();
}

class _DiyHelpScreenState extends State<DiyHelpScreen> {
  late HelpProvider provider;
  TextEditingController postCommentController = TextEditingController();
  TextEditingController sendReplyController = TextEditingController();

  FocusNode replyFocus = FocusNode();
  FocusNode postCommentFocus = FocusNode();
  ScrollController scrollController = ScrollController();
  @override
  void dispose() {
    replyFocus.dispose();
    postCommentFocus.dispose();
    postCommentController.dispose();
    sendReplyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    provider = Provider.of<HelpProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.initialValue();
      provider.getDiyHelp();
    });
    scrollController.addListener(() {
      if (scrollController.position.extentAfter < 300) {
        provider.getDiyHelp();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(
        appBarTitle: "Diy Help",
        trailing: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: AppColor.green,
            child: IconButton(
              icon: Center(
                child: Icon(
                  Icons.add,
                  color: AppColor.whiteColor,
                  size: 15,
                ),
              ),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => const DiyPopUp(),
                );
              },
            ),
          ),
        ),
      ),
      body: Consumer<HelpProvider>(
          builder: (context, HelpProvider helpProvider, _) {
        return helpProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : helpProvider.errorMessage.isNotEmpty
                ? Center(child: TextWidget(data: "Something Went Wrong"))
                : helpProvider.diyHelpListingModel.isEmpty
                    ? Center(child: TextWidget(data: "No Data"))
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              itemCount:
                                  helpProvider.diyHelpListingModel.length,
                              controller: scrollController,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final diyHelpModel =
                                    helpProvider.diyHelpListingModel[index];
                                DateTime? createdAt = diyHelpModel.createdAt ==
                                        null
                                    ? null
                                    : DateTime.parse(diyHelpModel.createdAt!);
                                return Column(
                                  children: [
                                    Card(
                                      elevation: .1,
                                      child: Column(
                                        children: [
                                          headerWidget(
                                              size, diyHelpModel, createdAt),
                                          AppConstant.kheight(
                                              height: size.width * .018),
                                          diyHelpModel.images!.isEmpty
                                              ? SizedBox()
                                              : Container(
                                                  child: CarouselSlider.builder(
                                                      itemCount: diyHelpModel
                                                          .images!.length,
                                                      itemBuilder: (context,
                                                          carIndex, realIndex) {
                                                        return Container(
                                                          margin:
                                                              EdgeInsets.all(5),
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              child:
                                                                  CachedNetworkImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                imageUrl: diyHelpModel
                                                                        .images![
                                                                    carIndex],
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Center(
                                                                        child: const Icon(
                                                                            Icons.error)),
                                                              )),
                                                        );
                                                      },
                                                      options: CarouselOptions(
                                                        padEnds: false,
                                                        scrollPhysics:
                                                            BouncingScrollPhysics(),
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        enableInfiniteScroll:
                                                            false,
                                                        viewportFraction: .6,
                                                        autoPlayAnimationDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                        // viewportFraction: 1,
                                                        height: size.width * .5,

                                                        autoPlay: false,
                                                        reverse: false,
                                                        autoPlayInterval:
                                                            const Duration(
                                                                seconds: 5),
                                                      )),
                                                ),
                                          title(size, diyHelpModel),
                                          description(size, diyHelpModel),
                                          divider(),
                                          diyHelpModel.comments == null ||
                                                  diyHelpModel.comments!.isEmpty
                                              ? SizedBox()
                                              : ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: diyHelpModel
                                                      .comments!.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, subIndex) {
                                                    Comments? mainCommentsList =
                                                        diyHelpModel.comments ==
                                                                    null ||
                                                                diyHelpModel
                                                                    .comments!
                                                                    .isEmpty
                                                            ? null
                                                            : diyHelpModel
                                                                    .comments![
                                                                subIndex];
                                                    DateTime? replyCreatedDate =
                                                        mainCommentsList ==
                                                                    null ||
                                                                mainCommentsList
                                                                        .createdAt ==
                                                                    null
                                                            ? null
                                                            : DateTime.parse(
                                                                mainCommentsList
                                                                    .createdAt!);
                                                    List<Replies> replies =
                                                        mainCommentsList ==
                                                                    null ||
                                                                mainCommentsList
                                                                    .replies!
                                                                    .isEmpty
                                                            ? []
                                                            : mainCommentsList
                                                                .replies!;

                                                    return mainCommentsList ==
                                                            null
                                                        ? SizedBox()
                                                        : subIndex > 0 &&
                                                                diyHelpModel
                                                                        .isExpand ==
                                                                    false
                                                            ? SizedBox()
                                                            : commentCard(
                                                                size,
                                                                mainCommentsList,
                                                                context,
                                                                replyCreatedDate,
                                                                replies,
                                                                index,
                                                                subIndex,
                                                                helpProvider);
                                                  },
                                                ),
                                          diyHelpModel.comments == null ||
                                                  diyHelpModel
                                                      .comments!.isEmpty ||
                                                  diyHelpModel
                                                          .comments!.length <
                                                      2
                                              ? SizedBox()
                                              : InkWell(
                                                  onTap: () {
                                                    provider
                                                        .expandHideMainButton(
                                                            index);
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: diyHelpModel
                                                                .isExpand!
                                                            ? 8
                                                            : 8),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 30,
                                                        width: diyHelpModel
                                                                .isExpand!
                                                            ? 100
                                                            : 170,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: AppColor
                                                                    .green),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            FaIcon(
                                                              FontAwesomeIcons
                                                                  .share,
                                                              size: size.width *
                                                                  .037,
                                                              color: AppColor
                                                                  .whiteColor,
                                                            ),
                                                            AppConstant.kWidth(
                                                                width:
                                                                    size.width *
                                                                        .009),
                                                            TextWidget(
                                                              data: diyHelpModel
                                                                      .isExpand!
                                                                  ? "Hide"
                                                                  : "View All comments",
                                                              //"${diyHelpModel.comments!.length - 1} Reply",
                                                              style: TextStyle(
                                                                  color: AppColor
                                                                      .whiteColor),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          AppConstant.kheight(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: size.width * .09,
                                                  //  width: size.width * .627,
                                                  child: TextFieldWidget(
                                                      controller: helpProvider
                                                              .mainReplyControllerList[
                                                          index],
                                                      hintText:
                                                          "Write Something",
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      onFieldSubmitted: (p0) {
                                                        replyFocus.unfocus();
                                                      },
                                                      onEditingComplete: () =>
                                                          FocusScope.of(context)
                                                              .nextFocus(),
                                                      validate: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return "This field is required";
                                                        } else {
                                                          return null;
                                                        }
                                                      }),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          postCommentFocus);
                                                  final _sharedPrefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  final userType = _sharedPrefs
                                                      .getString('userType')
                                                      .toString();
                                                  final userId = _sharedPrefs
                                                          .getString('id') ??
                                                      "0";

                                                  DiyHelpPostReplyModel
                                                      diyHelpPostReplyModel =
                                                      DiyHelpPostReplyModel(
                                                          diyHelpComment:
                                                              helpProvider
                                                                  .mainReplyControllerList[
                                                                      index]
                                                                  .text,
                                                          diyHelpCommentId: 0,
                                                          diyHelpId:
                                                              diyHelpModel.id,
                                                          userType: userType,
                                                          userId: int.parse(
                                                              userId));
                                                  if (!mounted) return;
                                                  AppConstant.overlayLoaderShow(
                                                      context);
                                                  bool res = await provider
                                                      .addMainReply(
                                                          mainIndex: index,
                                                          diyHelpPostReplyModel:
                                                              diyHelpPostReplyModel);
                                                  if (res == true) {
                                                    helpProvider
                                                        .mainReplyControllerList[
                                                            index]
                                                        .clear();
                                                  }
                                                  if (!mounted) return;
                                                  AppConstant.overlayLoaderHide(
                                                      context);
                                                },
                                                child: Container(
                                                  width: size.width * .2,
                                                  alignment: Alignment.center,
                                                  height: size.width * .086,
                                                  decoration: const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(0),
                                                              bottomLeft: Radius
                                                                  .circular(0),
                                                              topRight: Radius
                                                                  .circular(5),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                      color: AppColor.green),
                                                  child: TextWidget(
                                                    data: "Reply",
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .whiteColor),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          AppConstant.kheight(height: 10)
                                        ],
                                      ),
                                    ),
                                    index ==
                                                helpProvider.diyHelpListingModel
                                                        .length -
                                                    1 &&
                                            helpProvider.isFetching &&
                                            helpProvider.hasNext &&
                                            provider
                                                .diyHelpListingModel.isNotEmpty
                                        ? SizedBox(
                                            height: 90,
                                            child: AppConstant
                                                .circularProgressIndicator())
                                        : SizedBox()
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      );
      }),
    );
  }

  Card commentCard(
      Size size,
      Comments commentModel,
      BuildContext context,
      DateTime? replyCreatedDate,
      List<Replies> replies,
      int mainIndex,
      int subIndex,
      HelpProvider helpProvider) {
    return Card(
      color: Color(0XFFEEFFEC),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * .03, vertical: size.width * .02),
        child: Column(
          children: [
            Row(
              children: [
                commentModel.profilePic == null ||
                        commentModel.profilePic!.isEmpty
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
                              NetworkImage(commentModel.profilePic ?? ""),
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
                              data: commentModel.name ?? "",
                              maxLines: 1,
                              style: TextStyle(
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AppConstant.kheight(height: size.width * .005),
                            TextWidget(
                              data: replyCreatedDate == null
                                  ? "Posted"
                                  : "Posted: ${replyCreatedDate.day} ${DateFormat.MMM().format(replyCreatedDate)} ${replyCreatedDate.year}",
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
                    commentModel.comment.toString(),
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

            // sub comment reply listing

            replies.isEmpty
                ? SizedBox()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: replies.length,
                    itemBuilder: (context, index) {
                      final replyList = replies[index];
                      DateTime? replyCreatedDate = replyList.createdAt == null
                          ? null
                          : DateTime.parse(replyList.createdAt!);
                      return index > 0 && commentModel.isReplyExpand == false
                          ? SizedBox()
                          : Card(
                              // color: Color(0XFFEEFFEC),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * .03,
                                    vertical: size.width * .02),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        replyList.profilePic == null ||
                                                replyList.profilePic!.isEmpty
                                            ? CircleAvatar(
                                                radius: MediaQuery.of(context)
                                                        .size
                                                        .width *
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
                                                      replyList.profilePic ??
                                                          ""),
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
                                                      data:
                                                          replyList.name ?? "",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color:
                                                            AppColor.blackColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    AppConstant.kheight(
                                                        height:
                                                            size.width * .005),
                                                    TextWidget(
                                                      data: replyCreatedDate ==
                                                              null
                                                          ? "Posted"
                                                          : "Posted: ${replyCreatedDate.day} ${DateFormat.MMM().format(replyCreatedDate)} ${replyCreatedDate.year}",
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    AppConstant.kheight(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: ReadMoreText(
                                            replyList.comment.toString(),
                                            readMoreIconColor:
                                                AppColor.blackColor,
                                            numLines: 3,
                                            readMoreAlign: Alignment.centerLeft,
                                            style: TextStyle(
                                                fontSize: size.width * .033),
                                            readMoreTextStyle: TextStyle(
                                                fontSize: size.width * .033,
                                                color: Colors.black),
                                            readMoreText: 'Read More',
                                            readLessText: 'Read Less',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(),

                                    // AppConstant.kheight(height: 5)
                                  ],
                                ),
                              ),
                            );
                    },
                  ),
            commentModel.replies == null ||
                    commentModel.replies!.isEmpty ||
                    commentModel.replies!.length < 2
                ? SizedBox()
                : InkWell(
                    onTap: () {
                      provider.expandHideReplyMainButton(mainIndex, subIndex);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: commentModel.isReplyExpand! ? 8 : 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(color: AppColor.green),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.share,
                                size: size.width * .037,
                                color: AppColor.whiteColor,
                              ),
                              AppConstant.kWidth(width: size.width * .009),
                              TextWidget(
                                data: commentModel.isReplyExpand!
                                    ? "Hide"
                                    : "${replies.length - 1} Reply",
                                style: TextStyle(color: AppColor.whiteColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            AppConstant.kheight(height: 10),
            replies.isEmpty ? SizedBox() : AppConstant.kheight(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      height: size.width * .09,
                      //  width: size.width * .627,
                      child: TextFieldWidget(
                          controller: commentModel.controller,
                          hintText: "Write Something",
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (p0) {
                            replyFocus.unfocus();
                          },
                          onChanged: (value) {
                            print(value);
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
                  ),
                  InkWell(
                    onTap: () async {
                      FocusScope.of(context).requestFocus(postCommentFocus);
                      final _sharedPrefs =
                          await SharedPreferences.getInstance();
                      final userType =
                          _sharedPrefs.getString('userType').toString();
                      final userId = _sharedPrefs.getString('id') ?? "0";
                      print(commentModel.controller!.text);
                      DiyHelpPostReplyModel diyHelpPostReplyModel =
                          DiyHelpPostReplyModel(
                              diyHelpComment: commentModel.controller!.text,
                              diyHelpCommentId: commentModel.id,
                              diyHelpId: commentModel.diyHelpId,
                              userType: userType,
                              userId: int.parse(userId));
                      if (!mounted) return;
                      AppConstant.overlayLoaderShow(context);
                      bool res = await provider.addSubReply(
                          diyHelpPostReplyModel: diyHelpPostReplyModel,
                          mainIndex: mainIndex,
                          subIndex: subIndex);
                      if (res == true) {
                        commentModel.controller!.clear();
                      }
                      if (!mounted) return;
                      AppConstant.overlayLoaderHide(context);
                    },
                    child: Container(
                      width: size.width * .2,
                      alignment: Alignment.center,
                      height: size.width * .086,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          color: AppColor.green),
                      child: TextWidget(
                        data: "Reply",
                        style: TextStyle(color: AppColor.whiteColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
            AppConstant.kheight(height: 5)
          ],
        ),
      ),
    );
  }

  Padding divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Divider(
        thickness: 1,
      ),
    );
  }

  Padding description(Size size, DiyHelpListingModel diyHelpModel) {
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * .02,
        right: size.width * .02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: ReadMoreText(
              diyHelpModel.comment.toString(),
              readMoreIconColor: AppColor.green,
              numLines: 3,
              readMoreAlign: Alignment.centerLeft,
              style: TextStyle(fontSize: 16),
              readMoreTextStyle:
                  TextStyle(fontSize: size.width * .033, color: Colors.green),
              readMoreText: 'Read More',
              readLessText: 'Read Less',
            ),
          ),
        ],
      ),
    );
  }

  Padding title(Size size, DiyHelpListingModel diyHelpModel) {
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * .02,
          right: size.width * .02,
          top: size.width * .02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: ReadMoreText(
              diyHelpModel.title.toString(),
              readMoreIconColor: AppColor.green,
              numLines: 3,
              readMoreAlign: Alignment.centerLeft,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              readMoreTextStyle:
                  TextStyle(fontSize: size.width * .033, color: Colors.green),
              readMoreText: 'Read More',
              readLessText: 'Read Less',
            ),
          ),
        ],
      ),
    );
  }

  Row headerWidget(
      Size size, DiyHelpListingModel diyHelpModel, DateTime? createdAt) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColor.green,
          radius: size.width * .055,
          child: CircleAvatar(
            radius: size.width * .049,
            backgroundImage: NetworkImage(diyHelpModel.profilePic!),
          ),
        ),
        AppConstant.kWidth(width: size.width * .018),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextWidget(
                data: diyHelpModel.name ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * .036),
              ),
              createdAt == null
                  ? SizedBox()
                  : TextWidget(
                      data:
                          "Posted: ${createdAt.day} ${DateFormat.MMM().format(createdAt)} ${createdAt.year}, ${DateFormat('hh:mm a').format(createdAt)}",
                      maxLines: 1,
                    )
            ],
          ),
        )
      ],
    );
  }
}
