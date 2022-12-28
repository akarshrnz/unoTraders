import 'package:codecarrots_unotraders/model/trader_profile_model.dart';
import 'package:codecarrots_unotraders/router_class.dart';
import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:codecarrots_unotraders/main.dart';
import 'package:codecarrots_unotraders/screens/auth/login.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/components/body.dart';
import 'package:codecarrots_unotraders/screens/job/trader_job.dart';
import 'package:codecarrots_unotraders/screens/ui/message/body.dart';
import 'package:codecarrots_unotraders/screens/ui/receipt/body.dart';
import 'package:codecarrots_unotraders/screens/profile/traders/body.dart';
import 'package:flutter/material.dart';

import '../../../services/helper/api_services_url.dart';

class TraderDrawer extends StatefulWidget {
  const TraderDrawer({Key? key}) : super(key: key);

  @override
  State<TraderDrawer> createState() => _TraderDrawerState();
}

class _TraderDrawerState extends State<TraderDrawer> {
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
                          children: const [
                            Text(
                              'akg',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            Text('akg@mailinator.com'),
                          ],
                        )
                      ],
                    ),
                  ))),
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
          //             child: Text("Something went wrong"),
          //           );
          //         } else if (snapshot.hasData) {
          //           return drawerheaderProfile(
          //               context: context,
          //               size: size,
          //               profileModel: snapshot.data!);
          //         } else {
          //           const Center(child: Text("Document does not exist"));
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
          drawerTile(
            image: Image.asset(PngImages.drawerCat),
            text: "Traders Category",
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Traders()));
            },
          ),
          const SizedBox(height: 20),
          drawerTile(
            image: Image.asset(PngImages.drawerUpdateProfile),
            text: "Update Profile",
            onPressed: () {},
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerJob),
            text: "Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.allJob);
            },
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerJob),
            text: "Completed Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.completedJob);
            },
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerJob),
            text: "Accepted Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.acceptedJob);
            },
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerJob),
            text: "Rejected Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.rejectedJob);
            },
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerJob),
            text: "Ongoing Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.ongoingJob);
            },
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerJob),
            text: "Job Quote Request",
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TraderJob()));
            },
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerAppointment),
            text: "Appointments",
            onPressed: () {},
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerBazaar),
            text: "Bazaar",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.bazaarScreen);
            },
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerReceipt),
            text: "Receipts",
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Receipt()));
            },
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerMessage),
            text: "Messages",
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Message()));
            },
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerProfileInsight),
            text: "Profile Insights",
            onPressed: () {},
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerBlocked),
            text: "Customers Blocked",
            onPressed: () {},
          ),
          const SizedBox(height: 20),
          drawerTile(
            image: Image.asset(PngImages.drawerCondition),
            text: "Terms & Conditions",
            onPressed: () {},
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerCondition),
            text: "Privacy Policy",
            onPressed: () {},
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerAbout),
            text: "About Us",
            onPressed: () {},
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerSupport),
            text: "Support",
            onPressed: () {},
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerLogout),
            text: "Logout",
            onPressed: () async {
              await sp!.clear();
              setState(() {});

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
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
                      Text(
                        profileModel.name ?? "",
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(profileModel.email ?? ""),
                    ],
                  )
                ],
              ),
            )));
  }
}

Widget drawerTile({String? text, Function()? onPressed, Image? image}) {
  return SizedBox(
    height: 30,
    child: ListTile(
        leading: image,
        title: Text(text!,
            style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.grey.shade600,
                fontSize: 16.0)),
        onTap: onPressed),
  );
}
