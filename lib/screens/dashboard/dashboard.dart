import 'dart:io';

import 'package:blurry/blurry.dart';
import 'package:codecarrots_unotraders/main.dart';
import 'package:codecarrots_unotraders/provider/current_user_provider.dart';
import 'package:codecarrots_unotraders/provider/dashbord_provider.dart';
import 'package:codecarrots_unotraders/screens/category%20screen/category_screen.dart';
import 'package:codecarrots_unotraders/screens/homepage/hom.dart';
import 'package:codecarrots_unotraders/screens/homepage/home_page.dart';
import 'package:codecarrots_unotraders/screens/homepage/new_home.dart';
import 'package:codecarrots_unotraders/screens/job/customer%20job%20screen/customer_seek_quote_result.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/review/customer_review.dart';
import 'package:codecarrots_unotraders/screens/middele_screen.dart';

import 'package:codecarrots_unotraders/screens/Profile/traders/trader_profile_visit.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/trader_qrcode_screen.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/url_profile_visit.dart';
import 'package:codecarrots_unotraders/screens/receipt/receipt_popup.dart';
import 'package:codecarrots_unotraders/screens/wishlist/wishlist_screen.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/bazaar_screen.dart';

import 'package:codecarrots_unotraders/screens/job/customer%20job%20screen/post_job.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/body.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:ndialog/ndialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../category screen/new_category_screen.dart';
import '../Profile/customer/customer_profile.dart';
import '../Profile/traders/profile/trader_profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late CurrentUserProvider currentUserProvider;
  int currentIndex = 0;

  final tabs = [
    NewHomePage(),
    //const QuoteResults(jobId: '60',),
    NewCategoryScreen(),
    // TraderProfileVisit(),
    // TraderProfile(),
    MiddleScreen(),
    //CustomerReviewScreen(),
    const WishList(),
    sp!.getString('userType') == "customer"
        ? const CustomerProfile()
        : const TraderProfile(),
  ];

  scanRes({required String res}) {
    print(res.split('/'));
    List cb = res.split('/');
    String userId = cb.last;
    print(userId);
    if (res.isNotEmpty) {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: UrlTraderProfileVisit(
                userName: userId.trim().toString(),
              )));
    }
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print("3333333333333333333333333333333333");
      print(barcodeScanRes);

      if (barcodeScanRes.isNotEmpty && barcodeScanRes.contains('http')) {
        scanRes(res: barcodeScanRes);
      }
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    // });
  }

  // void _shareNetworkImage(String url) async {

  //   Directory tempDir = await getTemporaryDirectory();
  //   final path = '${tempDir.path}/test.jpeg';

  //   await Dio().download(url, path);

  //   Share.shareFiles([path]);

  // }

  @override
  void initState() {
    currentUserProvider =
        Provider.of<CurrentUserProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      currentUserProvider.initializeSharedPreference();
      call();
    });
    super.initState();
  }

  call() {
    final dat = Provider.of<CurrentUserProvider>(context, listen: false);
    print("provider");
    print(dat.currentUserId);
    print(dat.currentUserType);
    print(dat.currentUserEmail);
    print("services");
    print(Url.id);
    print(Url.userType);
  }

  @override
  Widget build(BuildContext context) {
    print("dashbord buid");
    final provider = Provider.of<DashbordProvider>(context, listen: false);
    String? usertype = sp!.getString('userType');
    // print("normal");
    // // ignore: avoid_print
    // print("user id");
    // // ignore: avoid_print
    // print(sp!.getString('id'));
    // print("usertype");
    // print(sp!.getString('userType'));
    // print(sp!.getString('userName'));
    return Scaffold(
      backgroundColor: null,
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: FloatingActionButton(
          backgroundColor: Colors.green[500],
          child: Icon(Icons.grid_view_outlined),
          //     Image.asset(
          //   PngImages.bottomMenuFilled,
          // ),
          onPressed: () {
            // provider.showPopUp();
            if (usertype == "customer") {
              print("customer section");
              NDialog(
                dialogStyle: DialogStyle(titleDivider: true),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          onTap: () async {
                            await scanQR();
                          },
                          minLeadingWidth: 3,
                          leading: const Icon(
                            Icons.qr_code_scanner,
                            color: AppColor.green,
                          ),
                          title: Text("Scan Qr code"),
                        ),
                        // Divider(),
                        // ListTile(
                        //   onTap: () {},
                        //   minLeadingWidth: 3,
                        //   leading: const Icon(
                        //     Icons.thumb_up_off_alt,
                        //     color: AppColor.green,
                        //   ),
                        //   title: Text("Review a trader"),
                        // ),
                        Divider(),
                        ListTile(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) =>
                                  const ReceiptPopUp(fromHome: true),
                            );
                          },
                          minLeadingWidth: 3,
                          leading: const Icon(
                            Icons.receipt,
                            color: AppColor.green,
                          ),
                          title: Text("Receipts"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                  // TextButton(
                  //     child: Text("Okay"),
                  //     onPressed: () => Navigator.pop(context)),
                  // TextButton(
                  //     child: Text("Close"),
                  //     onPressed: () => Navigator.pop(context)),
                ],
              ).show(context);
            } else {
              print("trader section");
              NDialog(
                dialogStyle: DialogStyle(titleDivider: true),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        usertype!.toLowerCase != "customer"
                            ? SizedBox()
                            : ListTile(
                                onTap: () async {
                                  await scanQR();
                                },
                                minLeadingWidth: 3,
                                leading: const Icon(
                                  Icons.qr_code_scanner,
                                  color: AppColor.green,
                                ),
                                title: Text("Scan Qr code"),
                              ),
                        usertype.toLowerCase != "customer"
                            ? SizedBox()
                            : Divider(),
                        usertype.toLowerCase != "customer"
                            ? SizedBox()
                            : ListTile(
                                onTap: () {},
                                minLeadingWidth: 3,
                                leading: const Icon(
                                  Icons.thumb_up_off_alt,
                                  color: AppColor.green,
                                ),
                                title: Text("Review a trader"),
                              ),
                        usertype.toLowerCase != "customer"
                            ? SizedBox()
                            : Divider(),
                        // ListTile(
                        //   onTap: () {},
                        //   minLeadingWidth: 3,
                        //   leading: const Icon(
                        //     Icons.document_scanner,
                        //     color: AppColor.green,
                        //   ),
                        //   title: Text("QR code"),
                        // ),
                        // Divider(),
                        usertype.toLowerCase == "customer"
                            ? SizedBox()
                            : ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: TraderQrCode()));
                                },
                                minLeadingWidth: 3,
                                leading: const Icon(
                                  Icons.share,
                                  color: AppColor.green,
                                ),
                                title: Text("Share profile"),
                              ),
                        usertype.toLowerCase == "customer"
                            ? SizedBox()
                            : Divider(),
                        ListTile(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) =>
                                  const ReceiptPopUp(fromHome: true),
                            );
                          },
                          minLeadingWidth: 3,
                          leading: const Icon(
                            Icons.receipt,
                            color: AppColor.green,
                          ),
                          title: Text("Receipts"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                  // TextButton(
                  //     child: Text("Okay"),
                  //     onPressed: () => Navigator.pop(context)),
                  // TextButton(
                  //     child: Text("Close"),
                  //     onPressed: () => Navigator.pop(context)),
                ],
              ).show(context);
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: AppColor.whiteBtnColor,
        selectedItemColor: AppColor.secondaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 10,
        selectedFontSize: 10,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              PngImages.bottomHomeFilled,
              width: 20,
            ),
            label: 'HOME',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              PngImages.bottomCatNotFilled,
              width: 20,
            ),
            label: 'Category',
            tooltip: 'Category',
          ),
          BottomNavigationBarItem(
            icon: const SizedBox(),
            //  Image.asset(
            //   PngImages.bottomMenuFilled,
            //   width: 40,
            // ),
            label: '',
            // tooltip: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              PngImages.bottomFavNotFilled,
              width: 20,
            ),
            label: 'Favourite',
            tooltip: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              PngImages.bottomProfileNotFilled,
              width: 20,
            ),
            label: 'Profile',
            tooltip: 'Profile',
          ),
        ],
        onTap: (index) {
          print(index.toString());
          if (index == 2) {
          } else {
            currentIndex = index;

            setState(() {});
          }
        },
      ),
      body: tabs.elementAt(currentIndex),

      //  Consumer<DashbordProvider>(builder: (context, dashprovider, _) {
      //   return Stack(fit: StackFit.expand, children: [
      //     GestureDetector(
      //         onTap: () {
      //           provider.closePopUp();
      //         },
      //         child: tabs.elementAt(currentIndex)),
      //     dashprovider.isPopUpOpen == true
      //         ? Positioned(
      //             bottom: 45,
      //             left: 50,
      //             right: 50,
      //             child: ClipPath(
      //               clipper: ClipperStack(),
      //               child: Container(
      //                 color: Colors.black,
      //                 height: 300,
      //                 child: Container(
      //                   height: 250,
      //                   width: 100,
      //                   decoration: BoxDecoration(
      //                     color: Colors.green,
      //                   ),
      //                   child: Padding(
      //                     padding: const EdgeInsets.symmetric(
      //                         horizontal: 25, vertical: 30),
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         ListTile(
      //                           minLeadingWidth: 3,
      //                           leading: Icon(
      //                             Icons.qr_code_scanner,
      //                           ),
      //                           title: Text("Scan Qr code"),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           )
      //         : const SizedBox(),
      //   ]);
      // }),
    );
  }
}
