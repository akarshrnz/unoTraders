import 'package:codecarrots_unotraders/main.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUserProvider with ChangeNotifier {
  SharedPreferences? sharedPreferance;
  String? currentUserId;
  String? currentUserName;
  String? currentUserType;
  String? currentUserPhone;
  String? currentUserEmail;
  String? currentUserProfilePic;

  initializeSharedPreference() async {
    sharedPreferance = await SharedPreferences.getInstance();
    if (sharedPreferance != null) {
      currentUserId = sharedPreferance!.getString('id')!;
      currentUserName = sharedPreferance!.getString('userName')!;
      currentUserType = sharedPreferance!.getString('userType')!;
      currentUserPhone = sharedPreferance!.getString('mobile')!;
      currentUserEmail = sharedPreferance!.getString('email')!;
      currentUserProfilePic = sharedPreferance!.getString('profilePic')!;
    }
    print("current user id $currentUserId");
    print("current user type $currentUserType");
    print("current user name $currentUserName");
    print("current user phone $currentUserPhone");
    print("current user profile pic $currentUserProfilePic");

    print("Api service url");
    print(Url.id);
    print(Url.userType);
    print("Api service url end");
    print(sp!.getString('userType'));
    print(sp!.getString('id'));

    notifyListeners();
  }

  UpdateProfilePicName(
      {required String profilePic, required String name}) async {
    //   if (userType != null && userId != null) {
    //     if (userType!.toLowerCase() == 'customer') {}
    //   } else {}
  }
}
