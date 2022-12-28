import 'package:codecarrots_unotraders/router_class.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:codecarrots_unotraders/main.dart';
import 'package:codecarrots_unotraders/screens/auth/login.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/components/body.dart';
import 'package:codecarrots_unotraders/screens/job/trader_job.dart';
import 'package:codecarrots_unotraders/screens/ui/message/body.dart';
import 'package:codecarrots_unotraders/screens/ui/receipt/body.dart';
import 'package:codecarrots_unotraders/screens/profile/traders/body.dart';
import 'package:flutter/material.dart';

class CustomerDrawer extends StatefulWidget {
  const CustomerDrawer({Key? key}) : super(key: key);

  @override
  State<CustomerDrawer> createState() => _CustomerDrawerState();
}

class _CustomerDrawerState extends State<CustomerDrawer> {
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
                              'David William',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            Text('david@gmail.com'),
                          ],
                        )
                      ],
                    ),
                  ))),
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
            text: "Posted Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.liveJob);
            },
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerJob),
            text: "Drafted Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.savedJob);
            },
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerJob),
            text: "Unpublished Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.unPublishedJob);
            },
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerJob),
            text: "Completed Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.customerCompletedJob);
            },
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerJob),
            text: "Accepted Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.customerAcceptedJob);
            },
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerJob),
            text: "Rejected Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.customerRejectedJob);
            },
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerJob),
            text: "Ongoing Jobs",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.customerOngoingJob);
            },
          ),
          drawerTile(
            image: Image.asset(PngImages.drawerJob),
            text: "Seeking quote",
            onPressed: () {
              Navigator.pushNamed(context, RouterClass.seekQuteJob);
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
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => const Bazaar()));
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

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      ),
    );
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
