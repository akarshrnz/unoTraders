import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/provider/location_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';

import 'package:codecarrots_unotraders/provider/trader_update_profile_provider.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/profile/Trader%20Profile%20Edit/profile_completed_work.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/profile/Trader%20Profile%20Edit/profile_document.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/profile/Trader%20Profile%20Edit/profile_location.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/profile/Trader%20Profile%20Edit/profile_service.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';

import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';

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
  late TraderUpdateProfileProvider updateProfileProvider;
  late LocationProvider locationProvider;
  late ImagePickProvider imageProvider;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    imageProvider = Provider.of<ImagePickProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    updateProfileProvider =
        Provider.of<TraderUpdateProfileProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      imageProvider.initialValues();
      locationProvider.initializeLocation();
      locationProvider.clearData();
      updateProfileProvider.clearAll();
      updateProfileProvider.getAllTraderCategory();
      updateProfileProvider.traderEditProfileCurrentData();
      if (widget.profileModel.landLatitude != null &&
          widget.profileModel.locLongitude != null &&
          widget.profileModel.landLatitude!.isNotEmpty &&
          widget.profileModel.locLongitude!.isNotEmpty) {
        locationProvider.assignLocation(
            lat: widget.profileModel.landLatitude!,
            long: widget.profileModel.locLongitude!);
      }
    });
  }

  List<String> titles = [
    "Profile",
    "Location",
    "Document",
    "Services",
    "Completed",
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
      return const ProfileDocument();
    } else if (index == 3) {
      return const ProfileService();
    } else {
      return const CompletedWork();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(appBarTitle: "Edit Profile"),
      body: Consumer<TraderUpdateProfileProvider>(
          builder: (context, updateProvider, _) {
        return updateProvider.editProfileLoading
            ? Center(child: AppConstant.circularProgressIndicator())
            : updateProvider.editProfileError.isNotEmpty
                ? Center(child: TextWidget(data: "Something Went Wrong"))
                : Column(
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
                  );
      }),
    );
  }

  Container header(Size size) {
    return Container(
      width: size.width,
      height: 50,
      // color: Colors.red,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  padding: const EdgeInsets.all(10),
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
