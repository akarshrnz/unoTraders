import 'package:cached_network_image/cached_network_image.dart';
import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/provider/current_user_provider.dart';
import 'package:codecarrots_unotraders/screens/DIY%20Help/diy_help_screen.dart';
import 'package:codecarrots_unotraders/screens/auth/reset_password.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/trader%20job%20type/trader_job_quote_requests.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/router_class.dart';
import 'package:codecarrots_unotraders/screens/Profile/customer_blocked_screen.dart';
import 'package:codecarrots_unotraders/screens/Profile%20insights/profile_insights_screen.dart';

import 'package:codecarrots_unotraders/screens/receipt/receipt_screen.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/png.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codecarrots_unotraders/screens/Message%20Section/message_listing_screen.dart';

class TraderDrawer extends StatelessWidget {
  const TraderDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      elevation: 0.5,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
              height: size.height * 0.15,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(bottom: BorderSide(color: Colors.transparent))),
              child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: DrawerHeader(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Consumer<CurrentUserProvider>(
                        builder: (context, user, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          user.currentUserProfilePic == null
                              ? CircleAvatar(
                                  backgroundColor: AppColor.primaryColor,
                                  radius: 30,
                                  child: Image.asset(
                                    PngImages.profile,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 32,
                                  backgroundColor: AppColor.green,
                                  child: CircleAvatar(
                                      backgroundColor: AppColor.whiteColor,
                                      radius: 27,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              user.currentUserProfilePic ??
                                                  "")),
                                ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                data: user.currentUserName ?? "",
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                              TextWidget(data: user.currentUserEmail ?? ""),
                            ],
                          )
                        ],
                      );
                    }),
                  )

                  //  DrawerHeader(
                  //   decoration: const BoxDecoration(color: Colors.white),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       CircleAvatar(
                  //         backgroundColor: AppColor.primaryColor,
                  //         radius: 30,
                  //         child: Image.asset(
                  //           PngImages.profile,
                  //           width: MediaQuery.of(context).size.width * 0.1,
                  //         ),
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: const [
                  //           TextWidget(data:
                  //             'akg',
                  //             style: TextStyle(fontWeight: FontWeight.w900),
                  //           ),
                  //           TextWidget(data:'akg@mailinator.com'),
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // )
                  )),
          // FutureBuilder<TraderProfileModel>(
          //     future: ProfileServices.getTrderProfile(id: ApiServicesUrl.id),
          //     // ApiServicesUrl.id
          //     builder: (context, AsyncSnapshot<TraderProfileModel> snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         if (snapshot.hasData) {
          //           return drawerheaderProfile(
          //               context: context,
          //               size: size,
          //               profileModel: snapshot.data!);
          //         } else {
          //           return Center(
          //               child: SizedBox(
          //             height: size.width * .03,
          //           ));
          //         }
          //       } else if (snapshot.connectionState == ConnectionState.done) {
          //         if (snapshot.hasError) {
          //           return const Center(
          //             child: TextWidget(data:"Something went wrong"),
          //           );
          //         } else if (snapshot.hasData) {
          //           return drawerheaderProfile(
          //               context: context,
          //               size: size,
          //               profileModel: snapshot.data!);
          //         } else {
          //           const Center(child: TextWidget(data:"Document does not exist"));
          //         }
          //       } else {
          //         return Center(
          //             child: SizedBox(
          //           height: size.width * .03,
          //         ));
          //       }
          //       return Center(
          //           child: SizedBox(
          //         height: size.width * .03,
          //       ));
          //       // return drawerheaderProfile(size, context);
          //     }),
          // drawerTile(
          //   image: Image.asset(PngImages.drawerCat),
          //   text: "Traders Category",
          //   onPressed: () {
          //     Navigator.of(context).push(
          //         MaterialPageRoute(builder: (context) => const Traders()));
          //   },
          // ),
          // const SizedBox(height: 20),
          // drawerTile(
          //   image: Image.asset(PngImages.drawerUpdateProfile),
          //   text: "Update Profile",
          //   onPressed: () {},
          // ),
          drawerTile(
            image: PngImages.drawerJob,
            text: "Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.allJob);
            },
          ),
          const SizedBox(height: 10),
          drawerTile(
            image: PngImages.drawerJob,
            text: "Completed Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.completedJob);
            },
          ),
          const SizedBox(height: 10),
          drawerTile(
            image: PngImages.drawerJob,
            text: "Accepted Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.acceptedJob);
            },
          ),
          const SizedBox(height: 10),
          drawerTile(
            image: PngImages.drawerJob,
            text: "Rejected Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.rejectedJob);
            },
          ),
          const SizedBox(height: 10),
          drawerTile(
            image: PngImages.drawerJob,
            text: "Ongoing Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.ongoingJob);
            },
          ),
          const SizedBox(height: 10),
          drawerTile(
            image: PngImages.drawerJob,
            text: "Job Quote Request",
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: TraderJobQuoteRequests()));
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => const TraderJob()));
            },
          ),
          const SizedBox(height: 10),
          drawerTile(
            image: PngImages.drawerAppointment,
            text: "Appointments",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.appointments);
            },
          ),
          const SizedBox(height: 10),
          drawerTile(
            image: PngImages.drawerBazaar,
            text: "Bazaar",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.bazaarScreen);
            },
          ),
          const SizedBox(height: 10),
          drawerTile(
            image: PngImages.drawerReceipt,
            text: "Receipts",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ReceiptScreen()));
            },
          ),
          const SizedBox(height: 10),
          drawerTile(
            image: PngImages.drawerMessage,
            text: "Messages",
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: MessageScreen()));
            },
          ),
          const SizedBox(height: 10),
          drawerTile(
            image: PngImages.drawerProfileInsight,
            text: "Profile Insights",
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: ProfileInsights()));
            },
          ),
          const SizedBox(height: 10),
          drawerTile(
            image: PngImages.drawerBlocked,
            text: "Customers Blocked",
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: CustomerBlockedScreen()));
            },
          ),
          const SizedBox(height: 10),

          drawerTile(
            image: PngImages.drawerBazaar,
            text: "Reset Password",
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: ResetPasswordScreen()));
            },
          ),
          const SizedBox(height: 10),

          drawerTile(
            image: PngImages.drawerCondition,
            text: "Terms & Conditions",
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          drawerTile(
            image: PngImages.drawerCondition,
            text: "Privacy Policy",
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          drawerTile(
            image: PngImages.drawerAbout,
            text: "About Us",
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          drawerTile(
            image: PngImages.drawerSupport,
            text: "DIY Help",
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: DiyHelpScreen()));
            },
          ),
          const SizedBox(height: 10),
          drawerTile(
            image: PngImages.drawerLogout,
            text: "Logout",
            onPressed: () async {
              final sharePref = await SharedPreferences.getInstance();
              Navigator.pop(context);
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: TextWidget(data: "Log out"),
                    content: TextWidget(data: "Are you sure to Log out ?"),
                    actions: [
                      CupertinoDialogAction(
                        child: TextWidget(data: "No"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: TextWidget(
                          data: "Yes",
                          style: TextStyle(color: AppColor.red),
                        ),
                        onPressed: () async {
                          await sharePref.clear();
                          //  await Hive.deleteBoxFromDisk('location-box');
                          print(sharePref.get('id'));
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              'login', (route) => false);
                        },
                      ),
                    ],
                  );
                },
              );
              // await sp!.clear();
              // setState(() {});

              // Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      ),
    );
  }

  Container drawerheaderProfile(
      {required Size size,
      required BuildContext context,
      required,
      required TraderProfileModel profileModel}) {
    return Container(
        height: size.height * 0.15,
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.transparent))),
        child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.primaryColor,
                    radius: 30,
                    child: Image.asset(
                      PngImages.profile,
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        data: profileModel.name ?? "",
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                      TextWidget(data: profileModel.email ?? ""),
                    ],
                  )
                ],
              ),
            )));
  }
}

Widget drawerTile(
    {String? text, Function()? onPressed, required String image}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: 30,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              image,
              alignment: Alignment.centerLeft,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          TextWidget(
              data: text!,
              style: TextStyle(
                  fontFamily: "Roboto", color: Colors.black54, fontSize: 16.0))
        ],
      ),
    ),
  );

  // ElevatedButton.icon(
  //     style: ElevatedButton.styleFrom(),
  //     onPressed: onPressed,
  // icon: Align(
  //   alignment: Alignment.centerLeft,
  //   child: Image.asset(
  //     PngImages.drawerSupport,
  //     alignment: Alignment.centerLeft,
  //   ),
  // ),
  //     label: Text(text ?? ""));

  // Theme(
  //   data: ThemeData(
  //     splashColor: Colors.white,
  //     highlightColor: Colors.transparent,
  //   ),
  //   child: Container(
  //     alignment: Alignment.center,
  //     height: 30,
  //     child: ListTile(
  //         leading: image,
  // title: TextWidget(
  //     data: text!,
  //     style: TextStyle(
  //         fontFamily: "Roboto",
  //         color: Colors.grey.shade600,
  //         fontSize: 16.0)),
  //         onTap: onPressed),
  //   ),
  // );
}
