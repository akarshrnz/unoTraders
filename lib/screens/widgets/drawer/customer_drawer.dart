import 'package:cached_network_image/cached_network_image.dart';
import 'package:codecarrots_unotraders/provider/current_user_provider.dart';
import 'package:codecarrots_unotraders/screens/DIY%20Help/diy_help_screen.dart';
import 'package:codecarrots_unotraders/screens/auth/reset_password.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/job_clarification_request.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/router_class.dart';
import 'package:codecarrots_unotraders/screens/Profile/blocked_trader_screen.dart';
import 'package:codecarrots_unotraders/screens/receipt/receipt_screen.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/png.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codecarrots_unotraders/screens/Message%20Section/message_listing_screen.dart';

class CustomerDrawer extends StatelessWidget {
  const CustomerDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      elevation: 0.5,
      child: SafeArea(
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
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                    ),
                                  )
                                : user.currentUserProfilePic!.isEmpty
                                    ? CircleAvatar(
                                        backgroundColor: AppColor.primaryColor,
                                        radius: 30,
                                        child: Image.asset(
                                          PngImages.profile,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 32,
                                        backgroundColor: AppColor.green,
                                        child: CircleAvatar(
                                            backgroundColor:
                                                AppColor.whiteColor,
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
                    ))),
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
            // ExpansionTile(
            //   title: TextWidget(data:
            //     "Jobs",
            //     style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            //   ),
            //   children: [
            //     drawerTile(
            //       image: Image.asset(PngImages.drawerJob),
            //       text: "Posted Jobs",
            //       onPressed: () {
            //         Navigator.pushNamed(context, RouterClass.liveJob);
            //       },
            //     ),
            //     const SizedBox(height: 10),
            //     drawerTile(
            //       image: Image.asset(PngImages.drawerJob),
            //       text: "Drafted Jobs",
            //       onPressed: () {
            //         Navigator.pushNamed(context, RouterClass.savedJob);
            //       },
            //     ),
            //     const SizedBox(height: 10),
            //     drawerTile(
            //       image: Image.asset(PngImages.drawerJob),
            //       text: "Unpublished Jobs",
            //       onPressed: () {
            //         Navigator.pushNamed(context, RouterClass.unPublishedJob);
            //       },
            //     ),
            //     const SizedBox(height: 10),
            //     drawerTile(
            //       image: Image.asset(PngImages.drawerJob),
            //       text: "Completed Jobs",
            //       onPressed: () {
            //         Navigator.pushNamed(
            //             context, RouterClass.customerCompletedJob);
            //       },
            //     ),
            //     const SizedBox(height: 10),
            //     drawerTile(
            //       image: Image.asset(PngImages.drawerJob),
            //       text: "Accepted Jobs",
            //       onPressed: () {
            //         Navigator.pushNamed(context, RouterClass.customerAcceptedJob);
            //       },
            //     ),
            //     const SizedBox(height: 10),
            //     drawerTile(
            //       image: Image.asset(PngImages.drawerJob),
            //       text: "Rejected Jobs",
            //       onPressed: () {
            //         Navigator.pushNamed(context, RouterClass.customerRejectedJob);
            //       },
            //     ),
            //     const SizedBox(height: 10),
            //     drawerTile(
            //       image: Image.asset(PngImages.drawerJob),
            //       text: "Ongoing Jobs",
            //       onPressed: () {
            //         Navigator.pushNamed(context, RouterClass.customerOngoingJob);
            //       },
            //     ),
            //     const SizedBox(height: 10),
            //     drawerTile(
            //       image: Image.asset(PngImages.drawerJob),
            //       text: "Seeking quote",
            //       onPressed: () {
            //         Navigator.pushNamed(context, RouterClass.seekQuteJob);
            //       },
            //     ),
            //     const SizedBox(height: 10),
            //     drawerTile(
            //       image: Image.asset(PngImages.drawerJob),
            //       text: "Job Quote Request",
            //       onPressed: () {
            //         Navigator.of(context).push(MaterialPageRoute(
            //             builder: (context) => const TraderJob()));
            //       },
            //     ),
            //     const SizedBox(height: 15),
            //   ],
            // ),
            drawerTile(
              image: PngImages.drawerJob,
              text: "Posted Jobs",
              onPressed: () {
                Navigator.pushNamed(context, RouterClass.liveJob);
              },
            ),
            const SizedBox(height: 10),
            drawerTile(
              image: PngImages.drawerJob,
              text: "Drafted Jobs",
              onPressed: () {
                Navigator.pushNamed(context, RouterClass.savedJob);
              },
            ),
            const SizedBox(height: 10),
            drawerTile(
              image: PngImages.drawerJob,
              text: "Unpublished Jobs",
              onPressed: () {
                Navigator.pushNamed(context, RouterClass.unPublishedJob);
              },
            ),
            const SizedBox(height: 10),
            drawerTile(
              image: PngImages.drawerJob,
              text: "Completed Jobs",
              onPressed: () {
                Navigator.pushNamed(context, RouterClass.customerCompletedJob);
              },
            ),
            const SizedBox(height: 10),
            drawerTile(
              image: PngImages.drawerJob,
              text: "Accepted Jobs",
              onPressed: () {
                Navigator.pushNamed(context, RouterClass.customerAcceptedJob);
              },
            ),
            const SizedBox(height: 10),
            drawerTile(
              image: PngImages.drawerJob,
              text: "Rejected Jobs",
              onPressed: () {
                Navigator.pushNamed(context, RouterClass.customerRejectedJob);
              },
            ),
            const SizedBox(height: 10),
            drawerTile(
              image: PngImages.drawerJob,
              text: "Ongoing Jobs",
              onPressed: () {
                Navigator.pushNamed(context, RouterClass.customerOngoingJob);
              },
            ),
            const SizedBox(height: 10),
            drawerTile(
              image: PngImages.drawerJob,
              text: "Seeking quote",
              onPressed: () {
                Navigator.pushNamed(context, RouterClass.seekQuteJob);
              },
            ),
            const SizedBox(height: 10),
            drawerTile(
              image: PngImages.drawerJob,
              text: "Clarification Request",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const JobClarificationRequest()));
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
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => const Bazaar()));
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

                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => const Message()));
              },
            ),
            // const SizedBox(height: 10),
            // drawerTile(
            //   image: Image.asset(PngImages.drawerProfileInsight),
            //   text: "Profile Insights",
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         PageTransition(
            //             type: PageTransitionType.fade,
            //             child: ProfileInsights()));
            //   },
            // ),
            const SizedBox(height: 10),
            drawerTile(
              image: PngImages.drawerBlocked,
              text: "Trader Blocked",
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: TraderBlockedScreen()));
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
              onPressed: () {
                // Navigator.push(
                //     context,
                //     PageTransition(
                //         type: PageTransitionType.fade,
                //         child: CustomerReviewScreen(
                //           jobId: "22",
                //           traderId: "33",
                //         )));
              },
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
                            // await Hive.deleteBoxFromDisk('location-box');
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

                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
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
  //  SizedBox(
  //   height: 30,
  //   child: ListTile(
  //       leading: image,
  //       title: TextWidget(
  //           data: text!,
  //           style: TextStyle(
  //               fontFamily: "Roboto",
  //               color: Colors.grey.shade600,
  //               fontSize: 16.0)),
  //       onTap: onPressed),
  // );
}
