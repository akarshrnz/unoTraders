import 'package:carousel_slider/carousel_slider.dart';
import 'package:codecarrots_unotraders/model/banner_model.dart';
import 'package:codecarrots_unotraders/provider/current_user_provider.dart';
import 'package:codecarrots_unotraders/provider/home_provider.dart';
import 'package:codecarrots_unotraders/provider/location_provider.dart';
import 'package:codecarrots_unotraders/screens/Location/select_location_screen.dart';
import 'package:codecarrots_unotraders/screens/homepage/trader_search_popup.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/router_class.dart';
import 'package:codecarrots_unotraders/screens/Notification/notification_screen.dart';
import 'package:codecarrots_unotraders/screens/widgets/drawer/customer_drawer.dart';
import 'package:codecarrots_unotraders/screens/widgets/drawer/trader_drawer.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/view_more.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late HomeProvider homeProvider;
  late LocationProvider locationProvider;
  bool isServices = true;

  @override
  void initState() {
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // locationProvider.requestPermissionAndStoreLocation();
      // locationProvider.assignCurrentLocation();
      homeProvider.getHome();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build home");
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer:
          Consumer<CurrentUserProvider>(builder: (context, userProvider, _) {
        return userProvider.currentUserType!.toLowerCase() == "customer"
            ? const CustomerDrawer()
            : const TraderDrawer();
      }),
      appBar: AppBar(
        backgroundColor: AppColor.secondaryColor,
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openDrawer(),
            child: Image.asset(
              PngImages.menu,
            ),
          ),
        ),
        title: Consumer<LocationProvider>(builder: (context, locProvider, _) {
          return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: MediaQuery.of(context).size.height * 0.043,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: AppColor.whiteBtnColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(PngImages.navigation),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, SelectUserLocationScreen.routeName,
                          arguments: true);
                      // Navigator.push(
                      //     context,
                      //     PageTransition(
                      //         type: PageTransitionType.fade,
                      //         child: const SelectUserLocationScreen()));
                    },
                    child: TextWidget(
                      data: locProvider.currentLocationName.isEmpty
                          ? 'Location'
                          : locProvider.currentLocationName,
                      style: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ),
                ],
              ));
        }),
        actions: [
          // CircleAvatar(
          //   backgroundColor: AppColor.whiteBtnColor,
          //   radius: MediaQuery.of(context).size.width * 0.05,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Image.asset(PngImages.search),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
                onPressed: () async {
                  // TraderSearch traderSearch = TraderSearch(
                  //     distance: 100,
                  //     lat: 11.8440352,
                  //     long: 75.637582,
                  //     userId: 1,
                  //     userType: "customer",
                  //     trade: "a");
                  await showDialog(
                    context: context,
                    builder: (context) => TraderSearchPopUp(),
                  );
                },
                icon: const Icon(Icons.search)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: const NotificationScreen()));
                },
                icon: const Icon(Icons.notifications_active_outlined)),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          homeProvider.clearHome();
          homeProvider.getHome();
        },
        child: Consumer<HomeProvider>(builder: (context, provider, _) {
          return provider.homeLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColor.green,
                ))
              : provider.errorMessage.isNotEmpty
                  ? SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Center(
                          child: TextWidget(
                        data:provider.errorMessage,
                      )),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 15),
                      child: Column(
                        children: [
                          Flexible(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                provider.bannerList == null
                                    ? SizedBox()
                                    : provider.bannerList.isEmpty
                                        ? SizedBox()
                                        : SizedBox(
                                            height: 180,
                                            width: double.infinity,
                                            child: CarouselSlider.builder(
                                                itemCount:
                                                    provider.bannerList.length,
                                                itemBuilder: (context, index,
                                                    realIndex) {
                                                  BannerModel data = provider
                                                      .bannerList[index];
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    // child: ImgFade.fadeImage(url: snapshot.data![index].bannerImage!,width:size.width ),
                                                    child: SvgPicture.network(
                                                      data.bannerImage ?? "",
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                },
                                                options: CarouselOptions(
                                                  autoPlayAnimationDuration:
                                                      const Duration(
                                                          milliseconds: 800),
                                                  viewportFraction: 1,
                                                  height: 180,
                                                  autoPlay: false,
                                                  autoPlayInterval:
                                                      const Duration(
                                                          seconds: 5),
                                                  onPageChanged:
                                                      (index, reason) {
                                                    // setState(() {
                                                    //   activeIndex = index;
                                                    // });
                                                  },
                                                )),
                                          ),
                                AppConstant.kheight(height: 15),
                                SizedBox(
                                  width: size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF87b049),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextWidget(
                                              data: 'Post a \njob',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppColor.whiteColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.033,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.16,
                                                decoration: BoxDecoration(
                                                  color: AppColor.whiteBtnColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: InkWell(
                                                  onTap: () async {
                                                    final sharedPrefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String id = sharedPrefs
                                                        .getString('id')!;
                                                    String userType =
                                                        sharedPrefs.getString(
                                                            'userType')!;
                                                    if (userType ==
                                                        "customer") {
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouterClass.postJob);
                                                    } else {
                                                      AppConstant.toastMsg(
                                                          msg:
                                                              "Please login as a customer to post jobs.!",
                                                          backgroundColor:
                                                              AppColor.red);
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Center(
                                                        child: TextWidget(
                                                      data: 'View More',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.023,
                                                          color: AppColor
                                                              .secondaryColor),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFdbab3c),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextWidget(
                                              data: 'Sell at \nBazaar',
                                              style: TextStyle(
                                                  color: AppColor.whiteColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.033,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.16,
                                                decoration: BoxDecoration(
                                                  color: AppColor.whiteBtnColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        RouterClass
                                                            .bazaarScreen);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Center(
                                                        child: TextWidget(
                                                      data: 'View More',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.023,
                                                          color: AppColor
                                                              .secondaryColor),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF525b88),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextWidget(
                                              data: 'Upgrade \nPlan',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppColor.whiteColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.033,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.16,
                                                decoration: BoxDecoration(
                                                  color: AppColor.whiteBtnColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                      child: TextWidget(
                                                    data: 'View More',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.023,
                                                        color: AppColor
                                                            .secondaryColor),
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFce5979),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextWidget(
                                              data: 'Book an \nAppoint',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppColor.whiteColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.033,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.16,
                                                decoration: BoxDecoration(
                                                  color: AppColor.whiteBtnColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Center(
                                                        child: TextWidget(
                                                      data: 'View More',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.023,
                                                          color: AppColor
                                                              .secondaryColor),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //categories
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextWidget(
                                    data: 'Traders Category',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // homeProvider.parentCategory(
                                          //     parentCategory: "Service");
                                          setState(() {
                                            isServices = !isServices;
                                          });
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          decoration: BoxDecoration(
                                              color: isServices == true
                                                  ? AppColor.secondaryColor
                                                  : AppColor.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              border: Border.all(
                                                color: AppColor.primaryColor,
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: TextWidget(
                                              data: 'Services',
                                              style: TextStyle(
                                                  color: isServices == true
                                                      ? AppColor.whiteColor
                                                      : AppColor.blackColor,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // homeProvider.parentCategory(
                                          //     parentCategory: "Seller");
                                          setState(() {
                                            isServices = !isServices;
                                          });
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          decoration: BoxDecoration(
                                              color: isServices == false
                                                  ? AppColor.secondaryColor
                                                  : AppColor.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              border: Border.all(
                                                color: AppColor.primaryColor,
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: TextWidget(
                                              data: 'Sales',
                                              style: TextStyle(
                                                  color: isServices == false
                                                      ? AppColor.whiteColor
                                                      : AppColor.blackColor,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),

                                isServices == true
                                    ? GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 2 / 1.59,
                                                crossAxisCount: 2),
                                        itemCount: provider.serviceList.length,
                                        itemBuilder: (context, index) {
                                          final itemService =
                                              provider.serviceList[index];
                                          // int cindex = _random.nextInt(colors.length);
                                          // Color tempcol = colors[cindex];
                                          return Card(
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        color: AppColor.green,
                                                        height: 40,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: TextWidget(
                                                            data: itemService
                                                                    .category ??
                                                                "",
                                                            style:
                                                                const TextStyle(
                                                              color: AppColor
                                                                  .whiteColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                itemService.subcategories ==
                                                        null
                                                    ? SizedBox()
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .double_arrow,
                                                                  size: 14,
                                                                  color: AppColor
                                                                      .secondaryColor,
                                                                ),
                                                                AppConstant
                                                                    .kWidth(
                                                                        width:
                                                                            5),
                                                                InkWell(
                                                                    onTap: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          PageTransition(
                                                                              type: PageTransitionType.fade,
                                                                              child: ViewMore(title: provider.serviceList[index].category.toString(), subCategoryList: itemService.subcategories ?? [])));
                                                                    },
                                                                    child: TextWidget(
                                                                        data: itemService.subcategories![0].category ??
                                                                            "")),
                                                              ],
                                                            ),
                                                          ),
                                                          itemService.subcategories!
                                                                      .length >=
                                                                  2
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: Row(
                                                                    children: [
                                                                      const Icon(
                                                                        Icons
                                                                            .double_arrow,
                                                                        size:
                                                                            14,
                                                                        color: AppColor
                                                                            .secondaryColor,
                                                                      ),
                                                                      AppConstant.kWidth(
                                                                          width:
                                                                              5),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.push(
                                                                              context,
                                                                              PageTransition(type: PageTransitionType.fade, child: ViewMore(title: provider.serviceList[index].category.toString(), subCategoryList: itemService.subcategories ?? [])));
                                                                          // Navigator.push(
                                                                          //     context,
                                                                          //     PageTransition(
                                                                          //         type: PageTransitionType.fade,
                                                                          //         child: ListTraders(
                                                                          //             id: allData[1].id.toString(),
                                                                          //             category: allData[1].category!)));
                                                                        },
                                                                        child: TextWidget(
                                                                            data:
                                                                                itemService.subcategories![1].category ?? ""),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : const SizedBox(),
                                                          itemService.subcategories!
                                                                      .length <
                                                                  2
                                                              ? const SizedBox()
                                                              : Consumer<
                                                                      HomeProvider>(
                                                                  builder:
                                                                      (context,
                                                                          provider,
                                                                          _) {
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      print(
                                                                          "pressed");
                                                                      Navigator.push(
                                                                          context,
                                                                          PageTransition(
                                                                              type: PageTransitionType.fade,
                                                                              child: ViewMore(title: provider.serviceList[index].category.toString(), subCategoryList: itemService.subcategories ?? [])));
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        width:
                                                                            100,
                                                                        decoration: BoxDecoration(
                                                                            color: AppColor.whiteBtnColor,
                                                                            borderRadius: BorderRadius.circular(20.0),
                                                                            border: Border.all(
                                                                              color: AppColor.secondaryColor,
                                                                            )),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child: Center(
                                                                              child: TextWidget(
                                                                            data:
                                                                                'View More',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w500),
                                                                          )),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                        ],
                                                      )
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    : GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 2 / 1.59,
                                                crossAxisCount: 2),
                                        itemCount: provider.salesList.length,
                                        itemBuilder: (context, index) {
                                          final itemService =
                                              provider.salesList[index];
                                          // int cindex = _random.nextInt(colors.length);
                                          // Color tempcol = colors[cindex];
                                          return Card(
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        color: AppColor.green,
                                                        height: 40,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: TextWidget(
                                                            data: itemService
                                                                    .category ??
                                                                "",
                                                            style:
                                                                const TextStyle(
                                                              color: AppColor
                                                                  .whiteColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                itemService.subcategories ==
                                                        null
                                                    ? SizedBox()
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .double_arrow,
                                                                  size: 14,
                                                                  color: AppColor
                                                                      .secondaryColor,
                                                                ),
                                                                AppConstant
                                                                    .kWidth(
                                                                        width:
                                                                            5),
                                                                InkWell(
                                                                    onTap: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          PageTransition(
                                                                              type: PageTransitionType.fade,
                                                                              child: ViewMore(title: provider.salesList[index].category.toString(), subCategoryList: itemService.subcategories ?? [])));
                                                                    },
                                                                    child: TextWidget(
                                                                        data: itemService.subcategories![0].category ??
                                                                            "")),
                                                              ],
                                                            ),
                                                          ),
                                                          itemService.subcategories!
                                                                      .length >=
                                                                  2
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: Row(
                                                                    children: [
                                                                      const Icon(
                                                                        Icons
                                                                            .double_arrow,
                                                                        size:
                                                                            14,
                                                                        color: AppColor
                                                                            .secondaryColor,
                                                                      ),
                                                                      AppConstant.kWidth(
                                                                          width:
                                                                              5),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.push(
                                                                              context,
                                                                              PageTransition(type: PageTransitionType.fade, child: ViewMore(title: provider.salesList[index].category.toString(), subCategoryList: itemService.subcategories ?? [])));
                                                                          // Navigator.push(
                                                                          //     context,
                                                                          //     PageTransition(
                                                                          //         type: PageTransitionType.fade,
                                                                          //         child: ListTraders(
                                                                          //             id: allData[1].id.toString(),
                                                                          //             category: allData[1].category!)));
                                                                        },
                                                                        child: TextWidget(
                                                                            data:
                                                                                itemService.subcategories![1].category ?? ""),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : const SizedBox(),
                                                          itemService.subcategories!
                                                                      .length <
                                                                  2
                                                              ? const SizedBox()
                                                              : Consumer<
                                                                      HomeProvider>(
                                                                  builder:
                                                                      (context,
                                                                          provider,
                                                                          _) {
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      print(
                                                                          "pressed");
                                                                      Navigator.push(
                                                                          context,
                                                                          PageTransition(
                                                                              type: PageTransitionType.fade,
                                                                              child: ViewMore(title: provider.salesList[index].category.toString(), subCategoryList: itemService.subcategories ?? [])));
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        width:
                                                                            100,
                                                                        decoration: BoxDecoration(
                                                                            color: AppColor.whiteBtnColor,
                                                                            borderRadius: BorderRadius.circular(20.0),
                                                                            border: Border.all(
                                                                              color: AppColor.secondaryColor,
                                                                            )),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child: Center(
                                                                              child: TextWidget(
                                                                            data:
                                                                                'View More',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w500),
                                                                          )),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                        ],
                                                      )
                                              ],
                                            ),
                                          );
                                        },
                                      )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
        }),
      ),
    );
  }
}
