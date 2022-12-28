import 'package:codecarrots_unotraders/model/add_post.dart';
import 'package:codecarrots_unotraders/model/customer_profile.dart';
import 'package:codecarrots_unotraders/model/post_offer_model.dart';
import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/model/update_profile.dart';
import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier {
  bool isLoading = false;
  String errorMessage = "";
  CustomerProfileModel? customerProfile;
  TraderProfileModel? traderProfile;

  Future<void> getCustomerProfile({required String userId}) async {
    isLoading = true;

    try {
      customerProfile = await ProfileServices.getCustomerProfile(id: userId);
      // ignore: avoid_print
      print(customerProfile!.name);
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;

    notifyListeners();
  }

  Future<void> updateProfile(
      {required UpdateProfileModel updateProfile}) async {
    try {
      await ProfileServices.updateProfile(updareProfile: updateProfile);
      // ignore: avoid_print

    } catch (e) {
      errorMessage = e.toString();
    }
  }

  //traderprofile
  Future<void> getTraderProfile({required String userId}) async {
    isLoading = true;

    try {
      traderProfile = await ProfileServices.getTrderProfile(id: userId);
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
