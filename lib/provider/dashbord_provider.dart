import 'package:flutter/material.dart';

class DashbordProvider with ChangeNotifier {
  int currentIndex = 0;
  bool isPopUpOpen = false;

  changeScreen({required int index}) {
    currentIndex = index;
  }

  showPopUp() {
    isPopUpOpen = !isPopUpOpen;
    notifyListeners();
  }

  closePopUp() {
    if (isPopUpOpen == true) {
      isPopUpOpen = false;
      notifyListeners();
    }
  }
}
