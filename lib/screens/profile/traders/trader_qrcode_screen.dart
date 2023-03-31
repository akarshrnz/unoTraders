import 'dart:io';
import 'dart:math';

import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart' as plus;

class TraderQrCode extends StatefulWidget {
  const TraderQrCode({super.key});

  @override
  State<TraderQrCode> createState() => _TraderQrCodeState();
}

class _TraderQrCodeState extends State<TraderQrCode> {
  String url = "https://demo.unotraders.com/trader/profile/";

  late ProfileProvider profileProvider;

  @override
  void initState() {
    super.initState();

    profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileProvider.getQrCodeTraderProfileScreen();
    });
  }

  Future<File?> networkImageToFile(String? imageUrl) async {
    if (imageUrl == null) {
      return null;
    } else {
      var rng = Random();
// get temporary directory of device.
      Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
      String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
      File file = File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
// call http.get method and pass imageUrl into it to get response.
      http.Response response = await http.get(Uri.parse(url));
// write bodyBytes received in response to file.
      await file.writeAsBytes(response.bodyBytes);

      print(file);
      return file;

// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBarWidget(appBarTitle: "My Profile"),
      body: Consumer<ProfileProvider>(
          builder: (context, ProfileProvider provider, _) {
        return provider.qrLoading
            ? Center(child: AppConstant.circularProgressIndicator())
            : provider.qrError.isNotEmpty
                ? Center(
                    child: TextWidget(data: "Something Went Wrong"),
                  )
                : provider.qrTraderProfile == null
                    ? SizedBox()
                    : Container(
                        width: size.width,
                        height: size.height,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppConstant.kheight(height: size.width * .1),
                              provider.qrTraderProfile!.profilePic!.isNotEmpty
                                  ? Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          backgroundColor: AppColor.whiteColor,
                                          child: CircleAvatar(
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.138,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  AppColor.whiteColor,
                                              radius: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.134,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    AppColor.whiteColor,
                                                radius: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.12,
                                                backgroundImage: NetworkImage(
                                                  provider.qrTraderProfile!
                                                      .profilePic!,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: -2,
                                          right: -2,
                                          child: Icon(
                                            Icons.verified,
                                            color: AppColor.green,
                                          ),
                                        )
                                      ],
                                    )
                                  : CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      child: Image.asset(
                                        PngImages.profile,
                                      ),
                                    ),
                              AppConstant.kheight(height: size.width * .04),
                              TextWidget(
                                data: provider.qrTraderProfile!.name ?? "",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              TextWidget(
                                  data:
                                      "ID: ${provider.qrTraderProfile!.name ?? ""}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700])),
                              AppConstant.kheight(height: size.width * .04),
                              SizedBox(
                                  height: 300,
                                  width: 250,
                                  child: SvgPicture.network(
                                      provider.qrTraderProfile!.qrcode!)),
                              Center(
                                child: CircleAvatar(
                                  backgroundColor: AppColor.whiteColor,
                                  radius:
                                      MediaQuery.of(context).size.width * 0.23,
                                  child: Image.asset(
                                    PngImages.logo,
                                  ),
                                ),
                              ),
                              Divider(),
                              InkWell(
                                onTap: () {
                                  print(provider.qrTraderProfile!.profilePic!);
                                  String shareurl =
                                      "$url${provider.qrTraderProfile!.username}";
                                  Share.share('Visit Uno Traders at $shareurl');

                                  // _shareNetworkImage(
                                  //     provider.qrTraderProfile!.profilePic!);
                                },
                                child: Container(
                                  height: size.width * .15,
                                  width: size.width * .7,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(40)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: AppColor.whiteColor,
                                        child: IconButton(
                                            onPressed: () {
                                              // String faceBook =
                                              //     "https://www.facebook.com/sharer.php?u=$shareurl";
                                              // _launchUrl(Uri.parse(faceBook));
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.shareNodes,
                                              color: Colors.black,
                                            )),
                                      ),
                                      AppConstant.kWidth(
                                          width: size.width * .02),
                                      TextWidget(
                                        data: "Share Profile",
                                        style: TextStyle(
                                            color: AppColor.whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                      // Constant.kWidth(width: size.width * .04),
                                      // CircleAvatar(
                                      //   backgroundColor: AppColor.whiteColor,
                                      //   radius: 20,
                                      //   child: IconButton(
                                      //       onPressed: () {
                                      //         // String shareurl =
                                      //         //     "$url${provider.qrTraderProfile!.username}";
                                      //         // String linkdin =
                                      //         //     "https://www.linkedin.com/shareArticle?url=$shareurl";
                                      //         // _launchUrl(Uri.parse(linkdin));
                                      //       },
                                      //       icon: FaIcon(
                                      //         FontAwesomeIcons.linkedin,
                                      //         color: Color(0XFF0A66C2),
                                      //       )),
                                      // ),
                                      // Constant.kWidth(width: size.width * .04),
                                      // CircleAvatar(
                                      //   backgroundColor: AppColor.whiteColor,
                                      //   radius: 20,
                                      //   child: IconButton(
                                      //       onPressed: () {
                                      //         // String shareurl =
                                      //         //     "$url${provider.qrTraderProfile!.username}";
                                      //         // String faceBook =
                                      //         //     "https://www.facebook.com/sharer.php?u=$shareurl";
                                      //         // _launchUrl(Uri.parse(faceBook));
                                      //       },
                                      //       icon: FaIcon(
                                      //         FontAwesomeIcons.instagram,
                                      //         color: Color(0XFFE1306C),
                                      //       )),
                                      // ),
                                      // Constant.kWidth(width: size.width * .04),
                                      // CircleAvatar(
                                      //   backgroundColor: AppColor.whiteColor,
                                      //   radius: 20,
                                      //   child: IconButton(
                                      //       onPressed: () async {
                                      //         // String shareurl =
                                      //         //     "$url${provider.qrTraderProfile!.username}";
                                      //         // String whatsapp =
                                      //         //     "https://api.whatsapp.com/send?text=$shareurl";
                                      //         // _launchUrl(Uri.parse(whatsapp));
                                      //       },
                                      //       icon: FaIcon(
                                      //         FontAwesomeIcons.whatsapp,
                                      //         color: Colors.green,
                                      //       )),
                                      // )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
      }),
    );
  }

  // Future<void> _launchUrl(Uri url) async {
  //   if (!await launchUrl(url)) {
  //     throw Exception('Could not launch $url');
  //   }
  // }
}
