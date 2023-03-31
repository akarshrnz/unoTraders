import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:codecarrots_unotraders/model/comment/add_comment.dart';
import 'package:codecarrots_unotraders/model/comment/add_comment_reply.dart';
import 'package:codecarrots_unotraders/model/comment/comment_model.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentScreen extends StatefulWidget {
  final String traderId;
  final String replyUrl;
  final String postCommentUrl;
  final String description;
  final String postId;
  final String profilePic;
  final List<String> postImages;
  final String endPoint;
  const CommentScreen(
      {super.key,
      required this.postId,
      required this.postImages,
      required this.profilePic,
      required this.description,
      required this.replyUrl,
      required this.postCommentUrl,
      required this.endPoint,
      required this.traderId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late ProfileProvider profileProvider;
  TextEditingController postCommentController = TextEditingController();
  TextEditingController sendReplyController = TextEditingController();

  FocusNode replyFocus = FocusNode();
  FocusNode postCommentFocus = FocusNode();

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
    print("id");
    print(widget.postId);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileProvider.getComments(
          postId: widget.postId, endpoint: widget.endPoint);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(appBarTitle: "Comment"),
      body: Consumer<ProfileProvider>(
          builder: (context, ProfileProvider commentProvider, _) {
        return commentProvider.commentFetching
            ? const Center(child: CircularProgressIndicator())
            : commentProvider.commentFetchingError.isNotEmpty
                ? Center(child: TextWidget(data: "Something Went Wrong"))
                : Container(
                    width: size.width,
                    height: size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: ListView(
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Container(
                              width: size.width,
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: CarouselSlider.builder(
                                  itemCount: widget.postImages.length,
                                  itemBuilder: (context, carIndex, realIndex) {
                                    return Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          widget.postImages[carIndex],
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
                                    autoPlayInterval:
                                        const Duration(seconds: 5),
                                  )),
                            ),
                            widget.description.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * .04,
                                        right: size.width * .04,
                                        top: size.width * .04,
                                        bottom: size.width * .04),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: ReadMoreText(
                                            widget.description,
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
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: commentProvider.commentList.length,
                              itemBuilder: (context, index) {
                                CommentModel commentModel =
                                    commentProvider.commentList[index];
                                DateTime createdDate =
                                    DateTime.parse(commentModel.createdAt!);
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * .02,
                                    vertical: size.width * .005,
                                  ),
                                  child: Card(
                                    color: Color(0XFFEEFFEC),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * .03,
                                      ),
                                      child: Column(
                                        children: [
                                          AppConstant.kheight(
                                              height: size.width * .03),
                                          Row(
                                            children: [
                                              commentModel.profilePic == null ||
                                                      commentModel
                                                          .profilePic!.isEmpty
                                                  ? CircleAvatar(
                                                      radius:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.06,
                                                      child: Image.asset(
                                                        PngImages.profile,
                                                      ),
                                                    )
                                                  : CircleAvatar(
                                                      backgroundColor:
                                                          AppColor.green,
                                                      radius: size.width * .055,
                                                      child: CircleAvatar(
                                                        radius:
                                                            size.width * .049,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                commentModel
                                                                        .profilePic ??
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          TextWidget(
                                                            data: commentModel
                                                                    .name ??
                                                                '',
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              color: AppColor
                                                                  .blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          AppConstant.kheight(
                                                              height:
                                                                  size.width *
                                                                      .005),
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
                                          Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: ReadMoreText(
                                                  commentModel.comment
                                                      .toString(),
                                                  readMoreIconColor:
                                                      AppColor.blackColor,
                                                  numLines: 3,
                                                  readMoreAlign:
                                                      Alignment.centerLeft,
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.width * .033),
                                                  readMoreTextStyle: TextStyle(
                                                      fontSize:
                                                          size.width * .033,
                                                      color: Colors.black),
                                                  readMoreText: 'Read More',
                                                  readLessText: 'Read Less',
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(),
                                          ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: commentModel.replies ==
                                                    null
                                                ? 0
                                                : commentModel.replies!.length,
                                            itemBuilder: (context, innerIndex) {
                                              Replies replyModel = commentModel
                                                  .replies![innerIndex];
                                              DateTime replyCreatedDate =
                                                  DateTime.parse(
                                                      replyModel.createdAt!);
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                  left: size.width * .04,
                                                  top: size.width * .005,
                                                ),
                                                child: innerIndex == 0 ||
                                                        commentProvider
                                                                    .expandable[
                                                                index] ==
                                                            true
                                                    ? commentCard(
                                                        size,
                                                        replyModel,
                                                        context,
                                                        replyCreatedDate)
                                                    : SizedBox(),
                                              );
                                            },
                                          ),
                                          InkWell(
                                            onTap: () {
                                              commentProvider.expandComment(
                                                  index: index);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: size.width * .048,
                                                  vertical: commentProvider
                                                          .expandable[index]
                                                      ? size.width * .02
                                                      : 0),
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
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons.share,
                                                        size: size.width * .037,
                                                        color:
                                                            AppColor.whiteColor,
                                                      ),
                                                      AppConstant.kWidth(
                                                          width: size.width *
                                                              .009),
                                                      TextWidget(
                                                        data: commentProvider
                                                                    .expandable[
                                                                index]
                                                            ? "Hide"
                                                            : "${commentModel.replies!.length} Reply",
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
                                          // Padding(
                                          // padding: EdgeInsets.symmetric(
                                          //     horizontal: size.width * .02),
                                          //   child: Align(
                                          //       alignment: Alignment.centerLeft,
                                          //       child: TextWidget(data:"View all Comments")),
                                          // ),
                                          AppConstant.kheight(
                                              height: size.width * .02),

                                          commentProvider.replyLoading &&
                                                  commentProvider
                                                      .textControllerList[index]
                                                      .text
                                                      .isNotEmpty
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: AppColor.green,
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: size.width * .09,
                                                width: size.width * .627,
                                                child: TextFieldWidget(
                                                    controller: commentProvider
                                                            .textControllerList[
                                                        index],
                                                    hintText: "Write Something",
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
                                              InkWell(
                                                onTap: () async {
                                                  final _sharedPrefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  final userType = _sharedPrefs
                                                      .getString('userType')
                                                      .toString();
                                                  final userId = _sharedPrefs
                                                      .getString('id')
                                                      .toString();

                                                  print(commentProvider
                                                      .textControllerList[index]
                                                      .text);
                                                  AddCommentReplyModel reply =
                                                      AddCommentReplyModel(
                                                    postId: commentModel.mainId,
                                                    postComment: commentProvider
                                                        .textControllerList[
                                                            index]
                                                        .text,
                                                    userType: userType,
                                                    traderId:
                                                        commentModel.traderId,
                                                    userId: int.parse(userId),
                                                    postCommentId:
                                                        commentModel.id,
                                                  );
                                                  await profileProvider
                                                      .addCommentReply(
                                                          reply: reply,
                                                          postId: widget.postId,
                                                          postCommentReplyUrl:
                                                              widget.replyUrl,
                                                          endPoints:
                                                              widget.endPoint);
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
                                                  child:
                                                      // commentProvider
                                                      //             .replyLoading &&
                                                      //         commentProvider
                                                      //             .textControllerList[
                                                      //                 index]
                                                      //             .text
                                                      //             .isNotEmpty
                                                      //     ? Padding(
                                                      //         padding:
                                                      //             const EdgeInsets
                                                      //                 .all(5.0),
                                                      //         child: const Center(
                                                      //           child:
                                                      //               CircularProgressIndicator(
                                                      //             strokeWidth: 2,
                                                      //             color: AppColor
                                                      //                 .whiteColor,
                                                      //           ),
                                                      //         ),
                                                      //       )
                                                      //     :
                                                      TextWidget(
                                                    data: "Reply",
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .whiteColor),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          AppConstant.kheight(
                                              height: size.width * .018),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        )),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .04,
                                vertical: size.width * .03),
                            child: TextField(
                              cursorColor: AppColor.blackColor,
                              controller: postCommentController,
                              focusNode: postCommentFocus,
                              decoration: InputDecoration(
                                  hintText: " Write Something",
                                  contentPadding:
                                      EdgeInsets.only(left: 5, right: 5),
                                  suffixIcon: InkWell(
                                    onTap: () async {
                                      postCommentFocus.unfocus();
                                      final _sharedPrefs =
                                          await SharedPreferences.getInstance();
                                      final userType = _sharedPrefs
                                          .getString('userType')
                                          .toString();
                                      final userId = _sharedPrefs
                                          .getString('id')
                                          .toString();
                                      AddCommentModel comment = AddCommentModel(
                                          postComment: postCommentController
                                              .text
                                              .trim()
                                              .toString(),
                                          traderId: int.parse(widget.traderId),
                                          userId: int.parse(userId),
                                          userType: userType,
                                          postId: int.parse(widget.postId));
                                      print(comment.toJson());
                                      await profileProvider
                                          .addComment(
                                              comment: comment,
                                              postId: widget.postId,
                                              postComment:
                                                  widget.postCommentUrl,
                                              endpoints: widget.endPoint)
                                          .then((value) {
                                        postCommentController.clear();
                                        return;
                                      });
                                    },
                                    child: commentProvider.commentLoading
                                        ? Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: CircleAvatar(
                                              backgroundColor: AppColor.green,
                                              child: Icon(
                                                Icons.send,
                                                color: AppColor.whiteColor,
                                              ),
                                            ),
                                          ),
                                  ),
                                  prefixIcon: widget.profilePic.isEmpty
                                      ? null
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(widget.profilePic),
                                          ),
                                        ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
      }),
    );
  }

  Card commentCard(Size size, Replies replyModel, BuildContext context,
      DateTime replyCreatedDate) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * .03, vertical: size.width * .02),
        child: Column(
          children: [
            Row(
              children: [
                replyModel.profilePic == null || replyModel.profilePic!.isEmpty
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
                              NetworkImage(replyModel.profilePic ?? ""),
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
                              data: replyModel.name ?? "",
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
                    replyModel.comment.toString(),
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
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:codecarrots_unotraders/model/comment/add_comment.dart';
// import 'package:codecarrots_unotraders/model/comment/add_comment_reply.dart';
// import 'package:codecarrots_unotraders/model/comment/comment_model.dart';
// import 'package:codecarrots_unotraders/provider/profile_provider.dart';
// import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
// import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
// import 'package:codecarrots_unotraders/utils/color.dart';
// import 'package:codecarrots_unotraders/utils/app_constant.dart';
// import 'package:codecarrots_unotraders/utils/png.dart';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:read_more_text/read_more_text.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CommentScreen extends StatefulWidget {
//   final String traderId;
//   final String replyUrl;
//   final String postCommentUrl;
//   final String description;
//   final String postId;
//   final String profilePic;
//   final List<String> postImages;
//   final String endPoint;
//   const CommentScreen(
//       {super.key,
//       required this.postId,
//       required this.postImages,
//       required this.profilePic,
//       required this.description,
//       required this.replyUrl,
//       required this.postCommentUrl,
//       required this.endPoint,
//       required this.traderId});

//   @override
//   State<CommentScreen> createState() => _CommentScreenState();
// }

// class _CommentScreenState extends State<CommentScreen> {
//   late ProfileProvider profileProvider;
//   TextEditingController postCommentController = TextEditingController();
//   TextEditingController sendReplyController = TextEditingController();

//   FocusNode replyFocus = FocusNode();
//   FocusNode postCommentFocus = FocusNode();

//   @override
//   void dispose() {
//     replyFocus.dispose();
//     postCommentFocus.dispose();
//     postCommentController.dispose();
//     sendReplyController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     print("id");
//     print(widget.postId);
//     profileProvider = Provider.of<ProfileProvider>(context, listen: false);
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       profileProvider.getComments(
//           postId: widget.postId, endpoint: widget.endPoint);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBarWidget(appBarTitle: "Comment"),
//       body: Consumer<ProfileProvider>(
//           builder: (context, ProfileProvider commentProvider, _) {
//         var feedModel;
//         return commentProvider.isFeedLoading
//             ? const Center(child: CircularProgressIndicator())
//             : commentProvider.fetchingError.isNotEmpty
//                 ? const Center(child: TextWidget(data:"Something Went Wrong"))
//                 : Container(
//                     height: MediaQuery.of(context).size.height,
//                     width: MediaQuery.of(context).size.width,
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         bodyScaffold(),
//                         Align(
//                           alignment: Alignment.bottomCenter,
//                           child: SizedBox(
//                               height: 50,
//                               child: TextFormField(
//                                 keyboardType: TextInputType.text,
//                               )),
//                         )
//                       ],
//                     ),
//                   );
//         //  Container(
//         //     height: MediaQuery.of(context).size.height,
//         //     child: Column(
//         //       children: [
//         // Container(
//         //   color: Colors.red,
//         //   height: 800,
//         // ),
//         //         body()
//         //       ],
//         //     ),
//         //   );
//       }),
//     );
//   }

//   Card commentCard(Size size, Replies replyModel, BuildContext context,
//       DateTime replyCreatedDate) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: size.width * .03, vertical: size.width * .02),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 replyModel.profilePic == null || replyModel.profilePic!.isEmpty
//                     ? CircleAvatar(
//                         radius: MediaQuery.of(context).size.width * 0.06,
//                         child: Image.asset(
//                           PngImages.profile,
//                         ),
//                       )
//                     : CircleAvatar(
//                         backgroundColor: AppColor.green,
//                         radius: size.width * .055,
//                         child: CircleAvatar(
//                           radius: size.width * .049,
//                           backgroundImage:
//                               NetworkImage(replyModel.profilePic ?? ""),
//                         ),
//                       ),
//                 AppConstant.kWidth(width: size.width * .018),
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             TextWidget(data:
//                               replyModel.name ?? "",
//                               maxLines: 1,
//                               style: TextStyle(
//                                 color: AppColor.blackColor,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             AppConstant.kheight(height: size.width * .005),
//                             TextWidget(data:
//                               "Posted: ${replyCreatedDate.day} ${DateFormat.MMM().format(replyCreatedDate)} ${replyCreatedDate.year}",
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Flexible(
//                   child: ReadMoreText(
//                     replyModel.comment.toString(),
//                     readMoreIconColor: AppColor.blackColor,
//                     numLines: 3,
//                     readMoreAlign: Alignment.centerLeft,
//                     style: TextStyle(fontSize: size.width * .033),
//                     readMoreTextStyle: TextStyle(
//                         fontSize: size.width * .033, color: Colors.black),
//                     readMoreText: 'Read More',
//                     readLessText: 'Read Less',
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class bodyScaffold extends StatelessWidget {
//   const bodyScaffold({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         child: ListView(
//           shrinkWrap: true,
//           children: [
//             Container(
//               height: 150,
//               color: Colors.red,
//             ),
//             Container(
//               height: 150,
//               color: Colors.green,
//             ),
//             Container(
//               height: 150,
//               color: Colors.red,
//             ),
//             Container(
//               height: 150,
//               color: Colors.red,
//             ),
//             Container(
//               height: 150,
//               color: Colors.yellow,
//             ),
//             Container(
//               height: 150,
//               color: Colors.orange,
//             ),
//             Container(
//               height: 150,
//               color: Colors.orange,
//             ),
//             Container(
//               height: 150,
//               color: Colors.orange,
//             ),
//             Container(
//               height: 150,
//               color: Colors.orange,
//             ),
//             Container(
//               height: 150,
//               color: Colors.red,
//             ),
//           ],
//         ),
//         color: Colors.white,
//         height: MediaQuery.of(context).size.height - 140,
//       ),
//     );
//   }
// }

// class BodyText extends StatelessWidget {
//   const BodyText({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField();
//   }
// }

// class body extends StatelessWidget {
//   const body({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField();
//   }
// }
