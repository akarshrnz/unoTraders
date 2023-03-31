import 'dart:math';

import 'package:codecarrots_unotraders/model/Feeds/trader_feed_model.dart';
import 'package:codecarrots_unotraders/model/add_post.dart';
import 'package:codecarrots_unotraders/model/add_review_comment_model.dart';
import 'package:codecarrots_unotraders/model/bazaar_model.dart';
import 'package:codecarrots_unotraders/model/comment/add_comment.dart';
import 'package:codecarrots_unotraders/model/comment/add_comment_reply.dart';
import 'package:codecarrots_unotraders/model/comment/comment_model.dart';
import 'package:codecarrots_unotraders/model/customer_profile.dart';
import 'package:codecarrots_unotraders/model/feed_reaction_model.dart';
import 'package:codecarrots_unotraders/model/offer%20listing/trader_offer_listing.dart';
import 'package:codecarrots_unotraders/model/post_offer_model.dart';
import 'package:codecarrots_unotraders/model/receipt%20model/add_receipt_model.dart';
import 'package:codecarrots_unotraders/model/receipt%20model/receipt_model.dart';
import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/model/update_profile.dart';
import 'package:codecarrots_unotraders/model/view_customer_review_model.dart';
import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';
import 'package:codecarrots_unotraders/services/api_sevices.dart';
import 'package:codecarrots_unotraders/services/helper/failure.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/appointments/change_appoint_status_model.dart';
import '../model/appointments/reshedule_model.dart';

class ProfileProvider with ChangeNotifier {
  int currentIndex = 0;
  bool isLoading = false;
  bool isUpLoading = false;
  bool commentLoading = false;
  bool replyLoading = false;
  bool firstLoading = true;
  String errorMessage = "";
  String fetchingError = "";
  List<ReceiptModel> receiptList = [];
  bool isFeedLoading = false;
  bool commentFetching = false;
  bool isReviewLoading = false;
  String reviewErro = "";
  String commentFetchingError = "";
  CustomerProfileModel? customerProfile;
  TraderProfileModel? traderProfile;
  TraderProfileModel? qrTraderProfile;
  List<ViewCustomerReviewModel> allReviewList = [];
  int? currentFeedReactionIndex;
  List<bool> isFeedReactionOpen = [];
  List<TraderFeedModel> feed = [];
  List<TraderOfferListingModel> offerListing = [];
  List<BazaarModel> marketOrBazaarList = [];
  List<CommentModel> commentList = [];
  List<bool> expandable = [];
  List<TextEditingController> textControllerList = [];
  List<TextEditingController> reviewTextControllerList = [];
  List<TextEditingController> reviewReplyTextControllerList = [];
  bool isProgress = false;
  String qrCodeUserId = "";
  bool qrLoading = false;
  String qrError = "";

  changeTab({required int index}) {
    currentIndex = index;
    notifyListeners();
  }

  //delete below function

  expandComment({required int index}) {
    expandable[index] = !expandable[index];
    notifyListeners();
  }

  dispose() {
    isLoading = false;
    errorMessage = "";
    notifyListeners();
  }

  clear() {
    isUpLoading = false;
    qrCodeUserId = "";
    replyLoading = false;
    commentLoading = false;
    textControllerList = [];
    commentList = [];
    firstLoading = true;
    isLoading = false;
    errorMessage = "";
    customerProfile = null;
    traderProfile = null;
    currentIndex = 0;
    fetchingError = "";
    isFeedLoading = false;
    feed = [];
    errorMessage = "";
    receiptList = [];
    offerListing = [];
    allReviewList = [];
    reviewErro = "";
    marketOrBazaarList = [];
    reviewTextControllerList = [];
    reviewReplyTextControllerList = [];
    expandable = [];
  }

  Future<void> getCustomerProfile({required String userId}) async {
    isLoading = true;
    errorMessage = "";
    feed = [];
    // offerListing = [];
    marketOrBazaarList = [];
    notifyListeners();

    try {
      customerProfile = await ProfileServices.getCustomerProfile(id: userId);
      // feed = await ProfileServices.getFeeds();
      // offerListing = await ProfileServices.getOfferList();
      // // marketOrBazaarList = await ApiServices.getBazaarproducts();
      // // ignore: avoid_print
      // print(customerProfile!.name);
      // print(feed.length.toString());
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;

    notifyListeners();
  }

  Future<void> refreshCustomerProfile({required String userId}) async {
    try {
      final data = await ProfileServices.getCustomerProfile(id: userId);
      customerProfile = data;
    } catch (e) {}
    notifyListeners();
  }

  Future<void> getFeeds(
      {required String userType, required String userId}) async {
    fetchingError = '';
    if (feed.isNotEmpty) return;
    print("after return");
    isFeedLoading = true;
    fetchingError = '';
    await getTraderFeeds(userType: userType, userId: userId);

    // try {
    //   await getTraderFeeds();
    // } catch (e) {
    //   fetchingError = e.toString();
    //   feed = [];
    // }
    isFeedLoading = false;

    notifyListeners();
  }

  Future<void> getTraderFeeds(
      {required String userType, required String userId}) async {
    try {
      List<TraderFeedModel> jsonData =
          await ProfileServices.getTraderFeeds(id: userId, userType: userType);
      feed = [];
      isFeedReactionOpen = [];
      currentFeedReactionIndex = null;
      feed = jsonData;
      if (feed.isNotEmpty) {
        isFeedReactionOpen = List.generate(feed.length, (index) => false);
      }

      print('feed length ${feed.length.toString()}');
    } catch (e) {
      fetchingError = e.toString();
      feed = [];
    }
    notifyListeners();
  }

//reaction
  changeFeedReactionByIndex(int index) {
    print(index);
    currentFeedReactionIndex = index;
    feed[index].isReactionOpened = !feed[index].isReactionOpened!;
    // isFeedReactionOpen[index] = !isFeedReactionOpen[index];

    notifyListeners();
  }

  closeAllFeedReaction() {
    currentFeedReactionIndex = null;
    feed.forEach((element) {
      element.isReactionOpened = false;
    });
    notifyListeners();
  }

//call reaction api
  Future<void> postReaction(
      {required int postId,
      required String reactionEmoji,
      required int index}) async {
    feed[index].isReactionOpened = !feed[index].isReactionOpened!;
    currentFeedReactionIndex = null;
    notifyListeners();
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;
    String userType = sharedPrefs.getString('userType')!;
    FeedReactionModel reaction = FeedReactionModel(
        dataReaction: reactionEmoji,
        traderPostId: postId,
        userId: int.parse(id),
        userType: userType);

    try {
      bool res = await ProfileServices.postFeedReaction(reaction: reaction);

      print('completed}');
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

//review
  Future<void> getReview({required String traderId}) async {
    fetchingError = '';
    if (allReviewList.isNotEmpty) return;
    print("after return");
    isReviewLoading = true;
    expandable = [];
    allReviewList = [];
    reviewTextControllerList = [];
    reviewReplyTextControllerList = [];
    fetchingError = '';
    notifyListeners();
    await getAllReviews(traderId: traderId);

    isReviewLoading = false;

    notifyListeners();
  }

  Future<void> getAllReviews({required String traderId}) async {
    try {
      final data =
          await ProfileServices.getTraderAllReviews(traderId: traderId);
      allReviewList = [];
      allReviewList = data;
      reviewTextControllerList = List.generate(
          allReviewList.length, (index) => TextEditingController());
      allReviewList.forEach((element) {
        element.comment!.forEach((comment) {
          comment.isExapand = false;
        });
      });
      // reviewReplyTextControllerList = List.generate(
      //     allReviewList.length, (index) => TextEditingController());
      // expandable = List.generate(allReviewList.length, (index) => false);

      print('allReviewList length ${allReviewList.length.toString()}');
    } catch (e) {
      fetchingError = e.toString();
      allReviewList = [];
    }
    notifyListeners();
  }
  //expand or hide

  expandHide({required int mainIndex, required int commentId}) {
    allReviewList[mainIndex].comment!.forEach((element) {
      if (element.id == commentId) {
        element.isExapand = !element.isExapand!;
      }
    });
    notifyListeners();
  } //add review by customer in textfield by visiting trader profile

  Future<void> addMainReview(
      {required String traderId,
      required AddReviewCommentModel addMainReview,
      required String url}) async {
    isUpLoading = true;
    notifyListeners();
    print("main start>>>>>>...");
    try {
      bool res = await ProfileServices.addMainReview(
          addMainReview: addMainReview, url: url);
      if (res == true) {
        print("main review adde...");
        final data =
            await ProfileServices.getTraderAllReviews(traderId: traderId);
        print("fetched all list...");
        allReviewList = [];
        allReviewList = data;
        reviewTextControllerList = [];
        reviewReplyTextControllerList = [];
        expandable = [];
        reviewTextControllerList = List.generate(
            allReviewList.length, (index) => TextEditingController());
        allReviewList.forEach((element) {
          element.comment!.forEach((comment) {
            comment.isExapand = false;
          });
        });
        // reviewReplyTextControllerList = List.generate(
        //     allReviewList.length, (index) => TextEditingController());
        // expandable = List.generate(allReviewList.length, (index) => false);
      }
      print("completed...");

      print('allReviewList length ${allReviewList.length.toString()}');
    } catch (e) {
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
    }
    isUpLoading = false;

    notifyListeners();
  }

  Future<void> getOffers(
      {required String userType, required String userId}) async {
    fetchingError = '';
    if (offerListing.isNotEmpty) return;

    isFeedLoading = true;
    fetchingError = '';
    await getTraderOffers(userType: userType, userId: userId);
    isFeedLoading = false;
    notifyListeners();
  }

  Future<void> getTraderOffers(
      {required String userType, required String userId}) async {
    try {
      final offerData =
          await ProfileServices.getTraderOffer(id: userId, userType: userType);
      offerListing.clear();
      offerListing = offerData;
    } catch (e) {
      fetchingError = e.toString();
      offerListing = [];
    }
    notifyListeners();
  }

  Future<void> getMarketOrBazaar(
      {required BazaarProvider bazaarProvider}) async {
    fetchingError = '';
    if (firstLoading == false) return;
    print("bazaar provider");
    isFeedLoading = true;
    try {
      await bazaarProvider.fetchBazaarProducts();
    } catch (e) {
      fetchingError = e.toString();
    }
    firstLoading = false;
    isFeedLoading = false;
    notifyListeners();
  }

  Future<void> getComments(
      {required String postId, required String endpoint}) async {
    expandable = [];
    commentFetching = true;
    commentFetchingError = '';
    notifyListeners();

    try {
      commentList =
          await ProfileServices.getComments(postId: postId, endPoint: endpoint);
      expandable = List.generate(commentList.length, (index) => false);
      textControllerList =
          List.generate(commentList.length, (index) => TextEditingController());
    } catch (e) {
      print(e.toString());
      commentFetchingError = e.toString();
    }
    commentFetching = false;

    notifyListeners();
  }

  Future<void> addComment(
      {required AddCommentModel comment,
      required String postId,
      required String endpoints,
      required String postComment}) async {
    commentLoading = true;
    notifyListeners();
    try {
      await ProfileServices.addComment(comment: comment, url: postComment);
      final updatedComment = await ProfileServices.getComments(
          postId: postId, endPoint: endpoints);
      commentList = [];
      commentList = updatedComment;
      expandable = List.generate(updatedComment.length, (index) => false);
      textControllerList = List.generate(
          updatedComment.length, (index) => TextEditingController());
      // ignore: avoid_print
    } catch (e) {
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
    }
    commentLoading = false;

    notifyListeners();
  }

  Future<void> addCommentReply(
      {required AddCommentReplyModel reply,
      required String postId,
      required String endPoints,
      required String postCommentReplyUrl}) async {
    replyLoading = true;
    notifyListeners();
    print(reply.toJson());
    try {
      await ProfileServices.addCommentReply(
          reply: reply, postCommentReplyUrl: postCommentReplyUrl);
      final updatedComment = await ProfileServices.getComments(
          postId: postId, endPoint: endPoints);
      commentList = [];
      commentList = updatedComment;
      expandable = List.generate(updatedComment.length, (index) => false);
      textControllerList = List.generate(
          updatedComment.length, (index) => TextEditingController());
      // ignore: avoid_print
    } catch (e) {
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
    }
    replyLoading = false;

    notifyListeners();
  }

  Future<bool> updateProfile(
      {required UpdateProfileModel updateProfile,
      required BuildContext context}) async {
    try {
      isUpLoading = true;
      notifyListeners();
      await ProfileServices.updateProfile(
          updateProfile: updateProfile, context: context);
      // ignore: avoid_print
      AppConstant.toastMsg(
          msg: "Profile Updated successfully", backgroundColor: AppColor.green);
      isUpLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
      isUpLoading = false;
      notifyListeners();
      return false;
    }
    ;
  }

  //traderprofile
  Future<void> getTraderProfile(
      {String? customerId, String? customerType}) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;

    try {
      traderProfile = await ProfileServices.getTraderProfile(
          id: id, customerId: customerId, customerType: customerType);
      // ignore: avoid_print
      print(traderProfile!.name);
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;

    notifyListeners();
  }

  //url profile visit
  Future<void> getTraderProfileById(
      {String? customerId, String? customerType, required String id}) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      traderProfile = await ProfileServices.getTraderProfile(
          id: id, customerId: customerId, customerType: customerType);
      // ignore: avoid_print
      print(traderProfile!.name);
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;

    notifyListeners();
  }

  //qr code screen
  Future<void> getQrCodeTraderProfileScreen(
      {String? customerId, String? customerType}) async {
    qrLoading = true;
    qrError = "";
    qrTraderProfile = null;
    notifyListeners();
    final sharedPrefs = await SharedPreferences.getInstance();
    String id = sharedPrefs.getString('id')!;

    try {
      qrTraderProfile = await ProfileServices.getTraderProfile(
          id: id, customerId: customerId, customerType: customerType);
      // ignore: avoid_print
      print(traderProfile!.name);
    } catch (e) {
      qrError = e.toString();
    }
    qrLoading = false;

    notifyListeners();
  }

  //add post
  Future<bool> addPost({
    required AddPostModel addPost,
    required String endPoints,
  }) async {
    print("start");
    try {
      await ProfileServices.addPost(addPost: addPost, endPoints: endPoints);
      // ignore: avoid_print
      AppConstant.toastMsg(
          msg: "Post Added Successfully", backgroundColor: AppColor.green);
      return true;
    } catch (e) {
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);

      return false;
    }
  }

  Future<bool> addUpdatePost(
      {required AddPostModel addPost,
      required String endPoints,
      required int postId}) async {
    try {
      await ProfileServices.updatePost(
          addPost: addPost, endPoints: endPoints, postId: postId);
      // ignore: avoid_print
      AppConstant.toastMsg(
          msg: "Post Updated Successfully", backgroundColor: AppColor.green);
      return true;
    } catch (e) {
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);

      return false;
    }
  }

  //post an offer
  Future<bool> postAnOffer({required PostOfferModel offerModel}) async {
    try {
      await ProfileServices.postoffer(postOffer: offerModel);
      return true;
      // ignore: avoid_print
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateOffer({required PostOfferModel offerModel}) async {
    try {
      await ProfileServices.updateoffer(postOffer: offerModel);
      // ignore: avoid_print
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> getReceiptList() async {
    receiptList = [];
    qrLoading = true;
    qrError = "";
    notifyListeners();
    try {
      receiptList = await ProfileServices.getReceiptList();
    } catch (e) {
      receiptList = [];
      qrError = e.toString();
    }
    qrLoading = false;
    notifyListeners();
  }

  Future<void> removeReceipt(
      {required String receiptId, required int index}) async {
    qrLoading = true;
    notifyListeners();
    try {
      final res = await ProfileServices.removeReceipt(receiptId: receiptId);
      if (res == true) {
        print("Remove receipt");
        receiptList.removeAt(index);
        // List<ReceiptModel> temp = receiptList;
        // for (int i = 0; i < temp.length; i++) {
        //   if (temp[i].id == receiptId) {
        //     receiptList.removeAt(i);
        //   }
        // }
      }
    } catch (e) {
      AppConstant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
    }
    qrLoading = false;
    notifyListeners();
  }

  Future<bool> addReceipt(
      {required AddReceiptModel receipt, bool? fromHome}) async {
    try {
      final res = await ProfileServices.addReceipt(receipt: receipt);
      if (res == true && fromHome == null) {
        print("not null");
        final data = await ProfileServices.getReceiptList();
        if (data.isNotEmpty) {
          receiptList = [];
          receiptList = data;
          notifyListeners();
        }
        print("success");
      }
      return true;
    } catch (e) {
      AppConstant.toastMsg(
          backgroundColor: AppColor.red, msg: "Something Went Wrong");
      print(e.toString());
      return false;
    }
  }

  Future<void> traderFollowUnfollow(
      {required int traderId, String? customerId, String? customerType}) async {
    print("before follow");
    if (isProgress == true) return;
    print("after follow");
    isProgress = true;
    notifyListeners();
    try {
      await ProfileServices.traderFollowUnfollow(traderId: traderId);
      final data = await ProfileServices.getTraderProfile(
          id: traderId.toString(),
          customerId: customerId,
          customerType: customerType);
      traderProfile = data;
    } catch (e) {
      AppConstant.toastMsg(backgroundColor: AppColor.red, msg: e.toString());
      print(e.toString());
    }
    isProgress = false;
    notifyListeners();
  }

  clearProgressIndicator() {
    isProgress = false;
    notifyListeners();
  }

  Future<void> changeAppointmentSchedule({
    required RescheduleModel appointments,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      await ProfileServices.rescheduleCancelAppointment(
        appointments: appointments,
      );
    } catch (e) {
      AppConstant.toastMsg(backgroundColor: AppColor.red, msg: e.toString());
      print(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> changeAppointmentStatus({
    required ChangeAppointmentStatusModel status,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      bool res =
          await ProfileServices.changeAppointmentStatus(changeStatus: status);
      if (res == true) {
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> traderFavouriteUnfavourite(
      {required int traderId, String? customerId, String? customerType}) async {
    print("before follow");
    if (isProgress == true) return;
    print("after follow");
    isProgress = true;
    notifyListeners();
    try {
      await ProfileServices.traderFavouriteUnfavourite(traderId: traderId);
      final data = await ProfileServices.getTraderProfile(
          id: traderId.toString(),
          customerId: customerId,
          customerType: customerType);
      traderProfile = data;
    } catch (e) {
      AppConstant.toastMsg(backgroundColor: AppColor.red, msg: e.toString());
      print(e.toString());
    }
    isProgress = false;
    notifyListeners();
  }

  Future<void> refreshTraderProfile(
      {required int traderId, String? customerId, String? customerType}) async {
    try {
      final data = await ProfileServices.getTraderProfile(
          id: traderId.toString(),
          customerId: customerId,
          customerType: customerType);
      traderProfile = data;
    } catch (e) {}
    notifyListeners();
  }

  Future<TraderProfileModel> getProfileByQrCode(
      {required String userName}) async {
    qrLoading = true;
    qrError = "";
    feed = [];
    qrCodeUserId = "";
    notifyListeners();

    try {
      TraderProfileModel profileModelData =
          await ProfileServices.getTraderProfileByUserName(userName: userName);
      traderProfile = profileModelData;
      qrCodeUserId =
          profileModelData.id == null ? "" : profileModelData.id.toString();
      qrLoading = false;
      notifyListeners();
      if (profileModelData.id != null) {
        getFeeds(userType: 'trader', userId: profileModelData.id.toString());
      } else {}
      return profileModelData;
    } catch (e) {
      qrError = e.toString();
      qrLoading = false;
      notifyListeners();

      throw Failure(e.toString());
    }
  }
}
