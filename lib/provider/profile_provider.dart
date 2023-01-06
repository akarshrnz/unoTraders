import 'package:codecarrots_unotraders/model/Feeds/trader_feed_model.dart';
import 'package:codecarrots_unotraders/model/add_post.dart';
import 'package:codecarrots_unotraders/model/bazaar_model.dart';
import 'package:codecarrots_unotraders/model/customer_profile.dart';
import 'package:codecarrots_unotraders/model/offer%20listing/trader_offer_listing.dart';
import 'package:codecarrots_unotraders/model/post_offer_model.dart';
import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/model/update_profile.dart';
import 'package:codecarrots_unotraders/services/api_sevices.dart';
import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier {
  bool isLoading = false;
  String errorMessage = "";
  CustomerProfileModel? customerProfile;
  TraderProfileModel? traderProfile;
  List<TraderFeedModel> feed = [];
  List<TraderOfferListingModel> offerListing = [];
  List<BazaarModel> marketOrBazaarList = [];

  Future<void> getCustomerProfile({required String userId}) async {
    isLoading = true;
    feed = [];
    offerListing = [];
    marketOrBazaarList = [];
    notifyListeners();

    try {
      customerProfile = await ProfileServices.getCustomerProfile(id: userId);
      feed = await ProfileServices.getFeeds();
      offerListing = await ProfileServices.getOfferList();
      // marketOrBazaarList = await ApiServices.getBazaarproducts();
      // ignore: avoid_print
      print(customerProfile!.name);
      print(feed.length.toString());
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;

    notifyListeners();
  }

  Future<void> updateProfile(
      {required UpdateProfileModel updateProfile}) async {
    try {
      isLoading = true;
      notifyListeners();
      await ProfileServices.updateProfile(updateProfile: updateProfile);
      // ignore: avoid_print
      Constant.toastMsg(
          msg: "Profile Updated successfully", backgroundColor: AppColor.green);
    } catch (e) {
      print(e.toString());
      errorMessage = e.toString();
      Constant.toastMsg(
          msg: "Something Went Wrong", backgroundColor: AppColor.red);
    }
    isLoading = false;
    notifyListeners();
  }

  //traderprofile
  Future<void> getTraderProfile({required String userId}) async {
    isLoading = true;

    try {
      traderProfile = await ProfileServices.getTraderProfile(id: userId);
      // ignore: avoid_print
      print(traderProfile!.name);
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;

    notifyListeners();
  }

  //add post
  Future<void> addPost({required AddPostModel addPost}) async {
    try {
      await ProfileServices.addPost(addPost: addPost);
      // ignore: avoid_print

    } catch (e) {
      throw e.toString();
    }
  }

  //post an offer
  Future<void> postAnOffer({required PostOfferModel offerModel}) async {
    try {
      await ProfileServices.postoffer(postOffer: offerModel);
      // ignore: avoid_print

    } catch (e) {
      throw e.toString();
    }
  }

  clear() {
    isLoading = false;
    errorMessage = "";
    customerProfile = null;
    traderProfile = null;
  }
}
