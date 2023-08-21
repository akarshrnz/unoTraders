import 'package:codecarrots_unotraders/model/profile/trader_update_profile.dart';
import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/provider/location_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/provider/trader_update_profile_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileLocation extends StatefulWidget {
  final TraderProfileModel profileModel;
  final String traderId;
  const ProfileLocation(
      {super.key, required this.profileModel, required this.traderId});

  @override
  State<ProfileLocation> createState() => _ProfileLocationState();
}

class _ProfileLocationState extends State<ProfileLocation> {
  final _formKey = GlobalKey<FormState>();
  late ProfileProvider profileProvider;
  late LocationProvider locationProvider;
  late ImagePickProvider imageProvider;
  late TraderUpdateProfileProvider updateProvider;
  late FocusNode locationFocus;
  late FocusNode landMarkFocus;
  late FocusNode landMarkTwoFocus;

  late TextEditingController locationController;
  late TextEditingController landMarkController;
  late TextEditingController landMarkControllerTwo;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    updateProvider =
        Provider.of<TraderUpdateProfileProvider>(context, listen: false);
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    imageProvider = Provider.of<ImagePickProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    initialization();
  }

  initialization() {
    landMarkFocus = FocusNode();
    locationFocus = FocusNode();
    landMarkTwoFocus = FocusNode();
    landMarkController = TextEditingController(
        text: widget.profileModel.landmark == null ||
                widget.profileModel.landmark!.isEmpty
            ? ""
            : widget.profileModel.landmark);

    locationController = TextEditingController(
        text: widget.profileModel.location == null ||
                widget.profileModel.location!.isEmpty
            ? ""
            : widget.profileModel.location);
    landMarkControllerTwo = TextEditingController(
        text: widget.profileModel.landmarkData == null ||
                widget.profileModel.landmarkData!.isEmpty
            ? ""
            : widget.profileModel.landmarkData);
  }

  @override
  void dispose() {
    landMarkFocus.dispose();
    landMarkTwoFocus.dispose();
    locationFocus.dispose();
    locationController.dispose();
    landMarkController.dispose();
    landMarkControllerTwo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          AppConstant.kheight(height: size.width * .03),
          columnWidget(
            context: context,
            widgetOne: TextWidget(data: "location"),
            widgetTwo: TextFieldWidget(
                focusNode: locationFocus,
                controller: locationController,
                enabled: true,
                hintText: "location",
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (p0) {
                  locationFocus.unfocus();
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    locationProvider.autocompleteSearch(search: value);
                  } else {
                    locationProvider.clearAll();
                  }
                },
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  } else {
                    return null;
                  }
                }),
          ),
          Consumer<LocationProvider>(builder: (context, locProvider, _) {
            return locProvider.predictions.isEmpty ||
                    locationController.text.toString().isEmpty
                ? const SizedBox(
                    height: 0,
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: locProvider.predictions.length,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            locationFocus.unfocus();
                            locationProvider.onSelected(
                                value: locProvider.predictions[index]);
                            locationController.text =
                                locProvider.selected!.description.toString();
                            locationProvider.clearPrediction();
                          },
                          child: ListTile(
                            leading: const Icon(
                              Icons.location_on,
                              color: AppColor.primaryColor,
                            ),
                            title: TextWidget(
                                data: locProvider.predictions[index].description
                                    .toString()),
                          ),
                        ));
          }),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child:
                Consumer<LocationProvider>(builder: (context, locProvider, _) {
              return locProvider.locationError.isNotEmpty
                  ? TextWidget(
                      data: locProvider.locationError,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const SizedBox();
            }),
          ),
          columnWidget(
            context: context,
            widgetOne: TextWidget(data: "LandMark"),
            widgetTwo: TextFieldWidget(
                focusNode: landMarkFocus,
                hintText: "LandMark",
                controller: landMarkController,
                textInputAction: TextInputAction.next,
                enabled: true,
                onFieldSubmitted: (p0) {
                  landMarkFocus.unfocus();
                  FocusScope.of(context).requestFocus(landMarkTwoFocus);
                },
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  } else {
                    return null;
                  }
                }),
          ),
          columnWidget(
            context: context,
            widgetOne: TextWidget(data: "LandMark"),
            widgetTwo: TextFieldWidget(
              focusNode: landMarkTwoFocus,
              hintText: "LandMark",
              controller: landMarkControllerTwo,
              textInputAction: TextInputAction.done,
              enabled: true,
              onFieldSubmitted: (p0) {
                landMarkTwoFocus.unfocus();
              },
              // validate: (value) {
              //   if (value == null || value.isEmpty) {
              //     return "This field is required";
              //   } else {
              //     return null;
              //   }
              // }
            ),
          ),
          AppConstant.kheight(height: size.width * .03),
          isLoading
              ? Center(child: AppConstant.circularProgressIndicator())
              : Consumer<LocationProvider>(builder: (context, locProvider, _) {
                  return DefaultButton(
                      text: "Submit",
                      onPress: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await submitUpdates(
                            locProvider.latitude, locProvider.longitude);

                        setState(() {
                          isLoading = false;
                        });
                      },
                      radius: size.width * .04);
                }),
          AppConstant.kheight(height: size.width * .03)
        ],
      ),
    );
  }

  Future<void> submitUpdates(String latitude, String longitude) async {
    print("satrt>>>>>>>>>");
    if (_formKey.currentState!.validate()) {
      print("satrt>>>>>>>>>");
      final sharedPrefs = await SharedPreferences.getInstance();
      String id = sharedPrefs.getString('id')!;

      print(latitude);
      print(longitude);
      print(locationController.text.toString());
      TraderUpdateProfile edit = TraderUpdateProfile(
          traderId: int.parse(id),
          landLatitude: latitude,
          landLongitude: longitude,
          locLatitude: latitude,
          locLongitude: longitude,
          location: locationController.text.toString(),
          landmark: landMarkController.text.toString(),
          landmarkDesc: landMarkControllerTwo.text);

      print(edit.toJson());
      bool res =
          await updateProvider.updateTraderProfileLocationPage(edit: edit);
      if (res == true) {
        widget.profileModel.landLatitude = latitude;
        widget.profileModel.landLongitude = longitude;
        widget.profileModel.locLatitude = latitude;
        widget.profileModel.locLongitude = longitude;
        widget.profileModel.location = locationController.text.toString();
        widget.profileModel.landmark = landMarkController.text.toString();
        widget.profileModel.landmarkData = landMarkControllerTwo.text;
        profileProvider.updateTraderProfile(widget.profileModel);
      }
    } else {}
  }

  Column columnWidget(
      {required Widget widgetOne,
      required Widget widgetTwo,
      required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppConstant.kheight(height: size.width * .02),
        widgetOne,
        AppConstant.kheight(height: 5),
        widgetTwo,
      ],
    );
  }
}
