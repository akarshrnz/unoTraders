import 'package:codecarrots_unotraders/main.dart';
import 'package:codecarrots_unotraders/screens/category_screen.dart';
import 'package:codecarrots_unotraders/screens/homepage/home_page.dart';
import 'package:codecarrots_unotraders/screens/job/customer%20job%20screen/quote_result.dart';
import 'package:codecarrots_unotraders/screens/job/job%20status/customer%20job%20view/review/customer_review.dart';
import 'package:codecarrots_unotraders/screens/middle_screen.dart';
import 'package:codecarrots_unotraders/screens/profile/traders/trader_profile_visit.dart';
import 'package:codecarrots_unotraders/screens/wishlist/wishlist_screen.dart';
import 'package:codecarrots_unotraders/services/helper/api_services_url.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/bazaar_screen.dart';

import 'package:codecarrots_unotraders/screens/job/customer%20job%20screen/post_job.dart';
import 'package:codecarrots_unotraders/screens/profile/traders/body.dart';
import 'package:flutter/material.dart';

import '../profile/customer/customer_profile.dart';
import '../profile/traders/trader_profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;

  final tabs = [
    const HomePage(),
    //const QuoteResults(jobId: '60',),
    CategoryScreen(),
    // TraderProfileVisit(),
    // TraderProfile(),
    // MiddleScreen(),
    CustomerReviewScreen(),
    const WishList(),
    ApiServicesUrl.userType == "customer"
        ? const CustomerProfile()
        : const TraderProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print("user id");
    // ignore: avoid_print
    print(sp!.getString('id'));
    print("usertype");
    print(sp!.getString('userType'));
    print(sp!.getString('userName'));
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: AppColor.whiteBtnColor,
        selectedItemColor: AppColor.secondaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 10,
        selectedFontSize: 10,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              PngImages.bottomHomeFilled,
              width: 20,
            ),
            label: 'HOME',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              PngImages.bottomCatNotFilled,
              width: 20,
            ),
            label: 'Category',
            tooltip: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              PngImages.bottomMenuFilled,
              width: 40,
            ),
            label: '',
            tooltip: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              PngImages.bottomFavNotFilled,
              width: 20,
            ),
            label: 'Favourite',
            tooltip: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              PngImages.bottomProfileNotFilled,
              width: 20,
            ),
            label: 'Profile',
            tooltip: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: tabs.elementAt(currentIndex),
    );
  }
}
