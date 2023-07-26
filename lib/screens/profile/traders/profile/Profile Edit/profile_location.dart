import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/provider/location_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  late FocusNode locationFocus;
  late FocusNode landMarkFocus;
  late FocusNode landMarkTwoFocus;

  late TextEditingController locationController;
  late TextEditingController landMarkController;
  late TextEditingController landMarkControllerTwo;

  @override
  void initState() {
    super.initState();
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    imageProvider = Provider.of<ImagePickProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    initialization();
  }

  initialization() {
    landMarkFocus = FocusNode();
    locationFocus = FocusNode();
    landMarkTwoFocus = FocusNode();
    landMarkController = TextEditingController();
    landMarkControllerTwo = TextEditingController();
    locationController = TextEditingController(
        text: widget.profileModel.location!.isEmpty
            ? ""
            : widget.profileModel.location);
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
    return ListView(
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
          child: Consumer<LocationProvider>(builder: (context, locProvider, _) {
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
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return "This field is required";
                } else {
                  return null;
                }
              }),
        ),
        AppConstant.kheight(height: size.width * .03),
        DefaultButton(
            text: "Submit",
            onPress: () async {
              if (_formKey.currentState!.validate()) {
              } else {}
            },
            radius: size.width * .04),
        AppConstant.kheight(height: size.width * .03)
      ],
    );
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
