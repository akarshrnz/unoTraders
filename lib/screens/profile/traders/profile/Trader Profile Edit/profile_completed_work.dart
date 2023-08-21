import 'dart:io';

import 'package:codecarrots_unotraders/provider/trader_update_profile_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class CompletedWork extends StatefulWidget {
  const CompletedWork({super.key});

  @override
  State<CompletedWork> createState() => _CompletedWorkState();
}

class _CompletedWorkState extends State<CompletedWork> {
  late TraderUpdateProfileProvider provider;
  List<File> imageFile = [];
  final imagePicker = ImagePicker();
  bool isLoading = false;
  List<int> removedImages = [];
  @override
  void initState() {
    provider = Provider.of<TraderUpdateProfileProvider>(context, listen: false);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> openSettings() async {
    if (await Permission.photos.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Permission Permanently Denied'),
            content: const Text(
                'Please open app settings and grant permission to access the gallery.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  openAppSettings();
                },
                child: const Text('Open Settings'),
              ),
            ],
          );
        },
      );
    } else {
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<TraderUpdateProfileProvider>(
          builder: (context, profileProvider, _) {
        return profileProvider.editProfileLoading
            ? Center(child: AppConstant.circularProgressIndicator())
            : profileProvider.editProfileError.isNotEmpty
                ? Center(child: TextWidget(data: "Something Went Wrong"))
                : ListView(
                    children: [
                      AppConstant.kheight(height: 30),
                      TextWidget(
                        data: "Completed Works:",
                        style: const TextStyle(fontSize: 18),
                      ),
                      AppConstant.kheight(height: 10),
                      profileProvider.traderEditProfileExistingData == null
                          ? const SizedBox()
                          : profileProvider.traderEditProfileExistingData!.data!
                                      .providerworks ==
                                  null
                              ? const SizedBox()
                              : profileProvider.traderEditProfileExistingData!
                                      .data!.providerworks!.isEmpty
                                  ? SizedBox()
                                  : SizedBox(
                                      height: 200,
                                      width: size.width,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: profileProvider
                                            .traderEditProfileExistingData!
                                            .data!
                                            .providerworks!
                                            .length,
                                        itemBuilder: (context, index) {
                                          final data = profileProvider
                                              .traderEditProfileExistingData!
                                              .data!
                                              .providerworks![index];
                                          return Stack(
                                            children: [
                                              Card(
                                                child: data.isNetworkImage!
                                                    ? Image.network(
                                                        data.image!,
                                                        height: 200,
                                                        width: 200,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.file(
                                                        data.fileImage!,
                                                        height: 200,
                                                        width: 200,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 1,
                                                child: IconButton(
                                                    onPressed: () {
                                                      provider
                                                          .removeCompletedWorkImages(
                                                              id: index);
                                                      removedImages
                                                          .add(data.id!);
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel_outlined)),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                      profileProvider.traderEditProfileExistingData == null
                          ? const SizedBox()
                          : profileProvider.traderEditProfileExistingData!.data!
                                      .providerworks ==
                                  null
                              ? const SizedBox()
                              : profileProvider.traderEditProfileExistingData!
                                      .data!.providerworks!.isEmpty
                                  ? SizedBox()
                                  : AppConstant.kheight(height: 15),
                      SizedBox(
                        width: 60,
                        child: InkWell(
                            onTap: () async {
                              print("pressed");
                              DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                              AndroidDeviceInfo androidInfo =
                                  await deviceInfo.androidInfo;
                              if (androidInfo.version.sdkInt >= 33) {
                                PermissionStatus status =
                                    await Permission.photos.request();
                                if (status.isGranted) {
                                  final pickImage = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  if (pickImage != null) {
                                    print("not null");
                                    imageFile.add(File(pickImage.path));
                                    provider.addCompletedWorkImages(
                                        fileImage: File(pickImage.path));
                                  }
                                } else if (status.isDenied) {
                                  await Permission.photos.request();
                                } else if (status.isPermanentlyDenied) {
                                  openSettings();
                                }
                              } else {
                                PermissionStatus status =
                                    await Permission.storage.request();
                                if (status.isGranted) {
                                  final pickImage = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  if (pickImage != null) {
                                    print("not null");
                                    imageFile.add(File(pickImage.path));
                                    provider.addCompletedWorkImages(
                                        fileImage: File(pickImage.path));
                                  } else {
                                    print(" null");
                                  }
                                } else if (status.isDenied) {
                                  await Permission.photos.request();
                                } else if (status.isPermanentlyDenied) {
                                  openSettings();
                                }
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 30,
                              child: const Icon(
                                Icons.upload,
                                color: AppColor.green,
                                size: 25,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColor.green, width: 2)),
                            )),
                      ),
                      AppConstant.kheight(height: 15),
                      isLoading
                          ? Center(
                              child: AppConstant.circularProgressIndicator())
                          : DefaultButton(
                              text: "Submit",
                              onPress: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await submitUpdates();

                                setState(() {
                                  isLoading = false;
                                });
                              },
                              radius: size.width * .04),
                      AppConstant.kheight(height: 15)
                    ],
                  );
      }),
    );
  }

  Future<void> submitUpdates() async {
    bool res = await provider.updateTraderProfileCompletedPage(
        removedImages: removedImages, selectedImage: imageFile);
    if (res == true) {
      if (!mounted) return;
      Navigator.pop(context);
    } else {
      if (!mounted) return;
      Navigator.pop(context);
    }
  }
}
