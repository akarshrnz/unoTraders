import 'package:codecarrots_unotraders/model/profile%20insights/profile_insights_model.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

import 'customer_contracted.dart';
import 'profile_visits.dart';
import 'search_apperance_screen.dart';

class ProfileInsights extends StatelessWidget {
  const ProfileInsights({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(appBarTitle: "Profile Insights"),
      body: FutureBuilder<ProfileInsightsModel>(
          future: ProfileServices.getProfileInsightts(),
          builder: (context, AsyncSnapshot<ProfileInsightsModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              if (snapshot.hasData) {
                ProfileInsightsModel? data = snapshot.data;
                return bodySection(context, size, data);
              } else {
                return Center(child: AppConstant.circularProgressIndicator());
              }
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: TextWidget(data: "Something went wrong"),
                );
              } else if (snapshot.hasData) {
                ProfileInsightsModel? data = snapshot.data;
                return bodySection(context, size, data);
              } else {
                return Center(
                  child: TextWidget(data: "No Data"),
                );
              }
            }

            return Center(child: AppConstant.circularProgressIndicator());
          }),
    );
  }

  Widget bodySection(
      BuildContext context, Size size, ProfileInsightsModel? dataModel) {
    return dataModel == null
        ? SizedBox()
        : Column(
            children: [
              AppConstant.kheight(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: ProfileVisitScreen()));
                },
                child: bodyCard(
                    count: dataModel.profileVisits == null
                        ? ""
                        : dataModel.profileVisits.toString(),
                    icon: FontAwesomeIcons.user,
                    color: Color(0XFF54C899),
                    size: size,
                    text: "Profile Visits"),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: SearchAppearanceScreen()));
                },
                child: bodyCard(
                    count: dataModel.searchHistory == null
                        ? ""
                        : dataModel.searchHistory.toString(),
                    icon: FontAwesomeIcons.noteSticky,
                    color: Color(0XFFFD8E94),
                    size: size,
                    text: "Search Appearance"),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: CustomerContractedScreen()));
                },
                child: bodyCard(
                    count: dataModel.contacted == null
                        ? ""
                        : dataModel.contacted.toString(),
                    color: Color(0XFFF6904E),
                    size: size,
                    icon: FontAwesomeIcons.message,
                    text: "Customer contracted Visits"),
              ),
            ],
          );
  }

  Container bodyCard({
    required Size size,
    required Color color,
    required String text,
    required String count,
    required IconData icon,
  }) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: size.width * .04, vertical: size.width * .01),
      width: size.width,
      height: size.width * .5,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white60,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: FaIcon(
                icon,
                color: color,
              ),
            ),
          ),
          AppConstant.kheight(height: 5),
          TextWidget(
            data: count,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
          ),
          AppConstant.kheight(height: 5),
          TextWidget(
            data: text,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ],
      ),
    );
  }
}
