import 'dart:io';

import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/provider/location_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/profile/Profile%20Edit/profile_document.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/profile/Profile%20Edit/profile_location.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/profile/Profile%20Edit/profile_service.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_profile.dart';

class TraderProfileEdit extends StatefulWidget {
  final TraderProfileModel profileModel;
  final String traderId;
  const TraderProfileEdit(
      {super.key, required this.profileModel, required this.traderId});

  @override
  State<TraderProfileEdit> createState() => _TraderProfileEditState();
}

class _TraderProfileEditState extends State<TraderProfileEdit> {
  late ProfileProvider profileProvider;
  late LocationProvider locationProvider;
  late ImagePickProvider imageProvider;
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    imageProvider = Provider.of<ImagePickProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      imageProvider.initialValues();
      locationProvider.initializeLocation();
      locationProvider.clearData();
      locationProvider.assignLocation(
          lat: widget.profileModel.locLongitude!,
          long: widget.profileModel.locLongitude!);
    });
  }

  List<String> titles = [
    "Profile",
    "Location",
    "Document",
    "Services",
  ];

  Widget screen(int index) {
    if (index == 0) {
      return EditTraderProfile(
        profileModel: widget.profileModel,
        traderId: widget.traderId,
      );
    } else if (index == 1) {
      return ProfileLocation(
        profileModel: widget.profileModel,
        traderId: widget.traderId,
      );
    } else if (index == 2) {
      return ProfileDocument();
    } else {
      return ProfileService();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(appBarTitle: "Edit Profile"),
      body: Column(
        children: [
          AppConstant.kheight(height: 7),
          header(size),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: screen(selectedIndex),
            ),
          )
        ],
      ),
    );
  }

  Container header(Size size) {
    return Container(
      width: size.width,
      height: 50,
      // color: Colors.red,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 140,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.green),
                      borderRadius: BorderRadius.circular(20),
                      color: selectedIndex == index
                          ? AppColor.green
                          : AppColor.whiteColor),
                  child: Text(
                    titles[index],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: selectedIndex == index
                            ? AppColor.whiteColor
                            : AppColor.textColor),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
