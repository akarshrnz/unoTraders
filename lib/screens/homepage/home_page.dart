// ignore_for_file: avoid_print

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:codecarrots_unotraders/router_class.dart';
import 'package:codecarrots_unotraders/screens/homepage/components/list_traders.dart';
import 'package:codecarrots_unotraders/screens/homepage/components/view_all_categories.dart';
import 'package:codecarrots_unotraders/screens/widgets/drawer/customer_drawer.dart';

import 'package:codecarrots_unotraders/screens/widgets/drawer/trader_drawer.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:page_transition/page_transition.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:codecarrots_unotraders/model/trader_subcategory.dart';
import 'package:codecarrots_unotraders/model/traders_category_model.dart';
import 'package:codecarrots_unotraders/services/api_sevices.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../services/helper/api_services_url.dart';
import '../../../utils/toast.dart';
import '../../../model/banner_model.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? traderController;
  int activeIndex = 0;
  late Future<List<BannerModel>> bannerList;
  late Future<List<TradersCategoryModel>> traderCategoryList;
  List<TradersCategoryModel> serviceList = [];
  List<TradersCategoryModel> data = [];
  bool isServices = true;
  List<Color> colors = [
    const Color(0XFFF06292),
    const Color.fromARGB(255, 174, 71, 16),
    const Color(0XFF5C6BC0),
    const Color(0XFF7CB342),
    const Color(0XFFFFAB40)
  ];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    traderController = TabController(length: 2, vsync: this);
    super.initState();
    fetchApi();
  }

  fetchApi() async {
    bannerList = ApiServices.getBanner();
    traderCategoryList = ApiServices.getTraderCategory();
    data = await traderCategoryList;
    parentCategory(parentCategory: "Service");
    // await ApiServices.getProfile();
  }

  parentCategory({required String parentCategory}) {
    serviceList = [];
    for (var element in data) {
      if (element.mainCategory == parentCategory) {
        serviceList.add(element);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _random = Random();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade200,
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
        title: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.5,
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
                Text(
                  'Location',
                  style: TextStyle(
                    color: AppColor.secondaryColor,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
              ],
            )),
        actions: [
          CircleAvatar(
            backgroundColor: AppColor.whiteBtnColor,
            radius: MediaQuery.of(context).size.width * 0.05,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(PngImages.search),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(PngImages.profile),
          ),
        ],
      ),
      drawer: ApiServicesUrl.userType == "customer"
          ? const CustomerDrawer()
          : const TraderDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 8, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        color: AppColor.secondaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          'Home',
                          style: TextStyle(
                              color: AppColor.whiteColor,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                    Constant.kWidth(width: 5),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        color: AppColor.whiteBtnColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          'Feeds',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                    Constant.kWidth(width: 5),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        color: AppColor.whiteBtnColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          'Offers',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                    Constant.kWidth(width: 5),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.22,
                      decoration: BoxDecoration(
                        color: AppColor.whiteBtnColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        child: Center(
                            child: Text(
                          'Discounts',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              Constant.kheight(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 8, top: 10),
                child: FutureBuilder<List<BannerModel>>(
                  future: bannerList,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<BannerModel>> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("An error has occured"),
                      );
                    } else if (snapshot.hasData) {
                      return SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: CarouselSlider.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index, realIndex) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                // child: ImgFade.fadeImage(url: snapshot.data![index].bannerImage!,width:size.width ),
                                child: SvgPicture.network(
                                  snapshot.data![index].bannerImage!,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                            options: CarouselOptions(
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              viewportFraction: 1,
                              height: 180,
                              autoPlay: false,
                              autoPlayInterval: const Duration(seconds: 5),
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activeIndex = index;
                                });
                              },
                            )),
                      );
                      // return ListView.builder(
                      //   scrollDirection: Axis.horizontal,
                      //   shrinkWrap: true,
                      //   itemCount: snapshot.data!.length,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      // child: SvgPicture.network(
                      //     snapshot.data![index].bannerImage!),
                      //     );
                      //   },
                      // );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.secondaryColor,
                        ),
                      );
                    }
                  },
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              // SizedBox(
              //   height: size.height * 0.1,
              //   width: size.width,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: 4,
              //     shrinkWrap: true,
              //     // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     //     crossAxisCount: 4),
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         margin: const EdgeInsets.all(5),
              //         height: size.height * 0.1,
              //         decoration: BoxDecoration(
              //           color: const Color(0xFF87b049),
              //           borderRadius: BorderRadius.circular(10.0),
              //         ),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             const Text(
              //               'Post a job',
              //               textAlign: TextAlign.center,
              //               style: TextStyle(
              //                   color: AppColor.whiteColor,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Container(
              //                 height: MediaQuery.of(context).size.height * 0.033,
              //                 width: MediaQuery.of(context).size.width * 0.16,
              //                 decoration: BoxDecoration(
              //                   color: AppColor.whiteBtnColor,
              //                   borderRadius: BorderRadius.circular(20.0),
              //                 ),
              //                 child: Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Center(
              //                       child: Text(
              //                     'View More',
              //                     style: TextStyle(
              //                         fontWeight: FontWeight.w500,
              //                         fontSize:
              //                             MediaQuery.of(context).size.width *
              //                                 0.023,
              //                         color: AppColor.secondaryColor),
              //                   )),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        color: const Color(0xFF87b049),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Post a \njob',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.033,
                              width: MediaQuery.of(context).size.width * 0.16,
                              decoration: BoxDecoration(
                                color: AppColor.whiteBtnColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  if (ApiServicesUrl.userType == "customer") {
                                    Navigator.pushNamed(
                                        context, RouterClass.postJob);
                                  } else {
                                    Constant.toastMsg(
                                        msg:
                                            "Please login as a customer to post jobs.!",
                                        backgroundColor: AppColor.red);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                    'View More',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.023,
                                        color: AppColor.secondaryColor),
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        color: const Color(0xFFdbab3c),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sell at \nBazaar',
                            style: TextStyle(
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.033,
                              width: MediaQuery.of(context).size.width * 0.16,
                              decoration: BoxDecoration(
                                color: AppColor.whiteBtnColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouterClass.bazaarScreen);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                    'View More',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.023,
                                        color: AppColor.secondaryColor),
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        color: const Color(0xFF525b88),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Upgrade \nPlan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.033,
                              width: MediaQuery.of(context).size.width * 0.16,
                              decoration: BoxDecoration(
                                color: AppColor.whiteBtnColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                  'View More',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.023,
                                      color: AppColor.secondaryColor),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        color: const Color(0xFFce5979),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Book an \nAppoint',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.033,
                              width: MediaQuery.of(context).size.width * 0.16,
                              decoration: BoxDecoration(
                                color: AppColor.whiteBtnColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Center(
                                      child: Text(
                                    'View More',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.023,
                                        color: AppColor.secondaryColor),
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

              Padding(
                padding: const EdgeInsets.only(left: 15, right: 8, top: 8),
                child: Text(
                  'Traders Category',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 8, top: 8),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        parentCategory(parentCategory: "Service");
                        setState(() {
                          isServices = !isServices;
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            color: isServices == true
                                ? AppColor.secondaryColor
                                : AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: AppColor.primaryColor,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            'Services',
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
                        parentCategory(parentCategory: "Sales");
                        setState(() {
                          isServices = !isServices;
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            color: isServices == false
                                ? AppColor.secondaryColor
                                : AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: AppColor.primaryColor,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            'Sales',
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
              isServices == true
                  ?
                  //services
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<List<TradersCategoryModel>>(
                        future: traderCategoryList,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<TradersCategoryModel>>
                                snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child:
                                  Center(child: Text("An error has occured")),
                            );
                          } else if (!snapshot.hasData) {
                            return const SizedBox();
                          } else if (snapshot.hasData) {
                            return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 2 / 1.59,
                                      crossAxisCount: 2),
                              itemCount: serviceList.length,
                              itemBuilder: (context, index) {
                                // int cindex = _random.nextInt(colors.length);
                                // Color tempcol = colors[cindex];
                                return Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              color: AppColor.green,
                                              height: 40,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  serviceList[index]
                                                      .category
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: AppColor.whiteColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      FutureBuilder<List<TraderSubCategory>>(
                                          future:
                                              ApiServices.getTraderSubCategory(
                                                  id: serviceList[index].id!),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<
                                                      List<TraderSubCategory>>
                                                  snapshot) {
                                            if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                    snapshot.error.toString()),
                                              );
                                            } else if (snapshot.hasData) {
                                              List<TraderSubCategory> data =
                                                  snapshot.data!;
                                              if (data.isEmpty)
                                                return Center(
                                                    child:
                                                        Text("No Categories"));
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Icon(
                                                          Icons.double_arrow,
                                                          size: 14,
                                                          color: AppColor
                                                              .secondaryColor,
                                                        ),
                                                        Constant.kWidth(
                                                            width: 5),
                                                        InkWell(
                                                            onTap: () {
                                                              print(data[0].id);
                                                              Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                      type: PageTransitionType
                                                                          .fade,
                                                                      child: ListTraders(
                                                                          id: data[0]
                                                                              .id
                                                                              .toString(),
                                                                          category:
                                                                              data[0].category!)));
                                                              // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                              //   return ListTraders(id: data[0].id.toString(), category:data[0].category!);
                                                              // },));
                                                            },
                                                            child: Text(data[0]
                                                                .category!)),
                                                      ],
                                                    ),
                                                  ),
                                                  data.length >= 2
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .double_arrow,
                                                                size: 14,
                                                                color: AppColor
                                                                    .secondaryColor,
                                                              ),
                                                              Constant.kWidth(
                                                                  width: 5),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      PageTransition(
                                                                          type: PageTransitionType
                                                                              .fade,
                                                                          child: ListTraders(
                                                                              id: data[1].id.toString(),
                                                                              category: data[1].category!)));
                                                                  //      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                  //   return ListTraders(id: data[1].id.toString(), category:data[1].category!);
                                                                  // },));
                                                                },
                                                                child: Text(data[
                                                                        1]
                                                                    .category!),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                  data.length < 2
                                                      ? const SizedBox()
                                                      : InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                PageTransition(
                                                                    type: PageTransitionType
                                                                        .fade,
                                                                    child: ViewMoreCategories(
                                                                        title: serviceList[index]
                                                                            .category
                                                                            .toString(),
                                                                        subCategoryList:
                                                                            data)));

                                                            // Navigator.push(
                                                            //     context,
                                                            //     MaterialPageRoute(
                                                            //       builder: (context) => ViewMoreCategories(
                                                            //           title: serviceList[
                                                            //                   index]
                                                            //               .category
                                                            //               .toString(),
                                                            //           subCategoryList:
                                                            //               data),
                                                            //     ));
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              width: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: AppColor
                                                                          .whiteBtnColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20.0),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: AppColor
                                                                            .secondaryColor,
                                                                      )),
                                                              child:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child: Center(
                                                                    child: Text(
                                                                  'View More',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              );
                                            } else {
                                              return const SizedBox();
                                            }
                                          })
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColor.secondaryColor,
                              ),
                            );
                          }
                        },
                      ),
                    )
                  :
                  //sales
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<List<TradersCategoryModel>>(
                        future: traderCategoryList,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<TradersCategoryModel>>
                                snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child:
                                  Center(child: Text("An error has occured")),
                            );
                          } else if (!snapshot.hasData) {
                            return const Center(
                                child: Text("No document exists"));
                          } else if (snapshot.hasData) {
                            return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 2 / 1.59,
                                      crossAxisCount: 2),
                              itemCount: serviceList.length,
                              itemBuilder: (context, index) {
                                // int cindex = _random.nextInt(colors.length);
                                // Color tempcol = colors[cindex];
                                return SizedBox(
                                  child: Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                color: AppColor.green,
                                                height: 40,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    serviceList[index]
                                                        .category
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        FutureBuilder<List<TraderSubCategory>>(
                                            future: ApiServices
                                                .getTraderSubCategory(
                                                    id: serviceList[index].id!),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<
                                                        List<TraderSubCategory>>
                                                    snapshot) {
                                              if (snapshot.hasError) {
                                                return const Center(
                                                  child: Text(
                                                      "An error has occured"),
                                                );
                                              } else if (snapshot.hasData) {
                                                List<TraderSubCategory> data =
                                                    snapshot.data!;
                                                if (data.isEmpty)
                                                  return Center(
                                                      child: Text(
                                                          "No Categories"));
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Icon(
                                                            Icons.double_arrow,
                                                            size: 14,
                                                            color: AppColor
                                                                .secondaryColor,
                                                          ),
                                                          Constant.kWidth(
                                                              width: 5),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                      type: PageTransitionType
                                                                          .fade,
                                                                      child: ListTraders(
                                                                          id: data[0]
                                                                              .id
                                                                              .toString(),
                                                                          category:
                                                                              data[0].category!)));
                                                              //  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                              //   return ListTraders(id: data[0].id.toString(), category:data[0].category!);
                                                              // },));
                                                            },
                                                            child: Text(data[0]
                                                                .category!),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    data.length >= 2
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .double_arrow,
                                                                  size: 14,
                                                                  color: AppColor
                                                                      .secondaryColor,
                                                                ),
                                                                Constant.kWidth(
                                                                    width: 5),
                                                                InkWell(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        PageTransition(
                                                                            type:
                                                                                PageTransitionType.fade,
                                                                            child: ListTraders(id: data[1].id.toString(), category: data[1].category!)));
                                                                    //        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                    //   return ListTraders(id: data[1].id.toString(), category:data[1].category!);
                                                                    // },));
                                                                  },
                                                                  child: Text(data[
                                                                          1]
                                                                      .category!),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                    data.length < 2
                                                        ? const SizedBox()
                                                        : InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                      type: PageTransitionType
                                                                          .fade,
                                                                      child: ViewMoreCategories(
                                                                          title: serviceList[index]
                                                                              .category
                                                                              .toString(),
                                                                          subCategoryList:
                                                                              data)));
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                width: 100,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: AppColor
                                                                            .whiteBtnColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                20.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              AppColor.secondaryColor,
                                                                        )),
                                                                child:
                                                                    const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    'View More',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  )),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                );
                                              } else {
                                                return const SizedBox();
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColor.secondaryColor,
                              ),
                            );
                          }
                        },
                      ),
                    ),
              // DefaultTabController(
              //   length: 2,
              //   child: Container(
              //     height: 55,
              //     padding: const EdgeInsets.all(8.0),
              //     child: Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           Flexible(
              //             child: TabBar(
              //               controller: traderController,
              //               labelPadding:
              //                   const EdgeInsets.only(right: 5, left: 5),
              //               indicatorSize: TabBarIndicatorSize.label,
              //               indicatorWeight: 1,
              //               labelColor: Colors.white,
              //               unselectedLabelColor: Colors.black,
              //               indicator: BoxDecoration(
              //                 color: AppColor.secondaryColor,
              //                 borderRadius: BorderRadius.circular(20.0),
              //               ),
              //               indicatorColor: Colors.transparent,
              //               isScrollable: true,
              //               tabs: [
              //                 Tab(
              //                   child: Container(
              //                       alignment: Alignment.center,
              //                       decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.circular(20),
              //                           border: Border.all(
              //                             color: AppColor.primaryColor,
              //                           )),
              //                       width: 100,
              //                       child: const Text("Services")),
              //                 ),
              //                 Tab(
              //                   child: Container(
              //                       decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.circular(20),
              //                           border: Border.all(
              //                             color: AppColor.primaryColor,
              //                           )),
              //                       alignment: Alignment.center,
              //                       width: 100,
              //                       child: const Text(
              //                         "Sales",
              //                       )),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ]),
              //   ),
              // ),

              // Container(
              //   height: 500,
              //   child: Column(
              //     children: [
              //       Expanded(
              //         child:
              //             TabBarView(controller: traderController, children: [
              //           //services
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: FutureBuilder<List<TradersCategoryModel>>(
              //               future: traderCategoryList,
              //               builder: (BuildContext context,
              //                   AsyncSnapshot<List<TradersCategoryModel>>
              //                       snapshot) {
              //                 if (snapshot.hasError) {
              //                   return const Center(
              //                     child: Center(
              //                         child: Text("An error has occured")),
              //                   );
              //                 } else if (!snapshot.hasData) {
              //                   return const SizedBox();
              //                 } else if (snapshot.hasData) {
              //                   return GridView.builder(
              //                     physics: const NeverScrollableScrollPhysics(),
              //                     shrinkWrap: true,
              //                     gridDelegate:
              //                         const SliverGridDelegateWithFixedCrossAxisCount(
              //                             crossAxisCount: 2),
              //                     itemCount: serviceList.length,
              //                     itemBuilder: (context, index) {
              //                       return SizedBox(
              //                         child: Card(
              //                           child: Column(
              //                             crossAxisAlignment:
              //                                 CrossAxisAlignment.start,
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.start,
              //                             children: [
              //                               Row(
              //                                 children: [
              //                                   Constant.kWidth(width: 10),
              //                                   Expanded(
              //                                     child: Container(
              //                                       alignment:
              //                                           Alignment.centerLeft,
              //                                       color: Colors.green,
              //                                       height: 40,
              //                                       child: Padding(
              //                                         padding:
              //                                             const EdgeInsets.all(
              //                                                 10),
              //                                         child: Text(
              //                                           serviceList[index]
              //                                               .category
              //                                               .toString(),
              //                                           style: const TextStyle(
              //                                             color: AppColor
              //                                                 .whiteColor,
              //                                           ),
              //                                         ),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                               FutureBuilder<
              //                                       List<TraderSubCategory>>(
              //                                   future: ApiServices
              //                                       .getTraderSubCategory(
              //                                           id: serviceList[index]
              //                                               .id!),
              //                                   builder: (BuildContext context,
              //                                       AsyncSnapshot<
              //                                               List<
              //                                                   TraderSubCategory>>
              //                                           snapshot) {
              //                                     if (snapshot.hasError) {
              //                                       return const Center(
              //                                         child: Text(
              //                                             "An error has occured"),
              //                                       );
              //                                     } else if (snapshot.hasData) {
              //                                       return Column(
              //                                         crossAxisAlignment:
              //                                             CrossAxisAlignment
              //                                                 .start,
              //                                         mainAxisAlignment:
              //                                             MainAxisAlignment
              //                                                 .start,
              //                                         children: [
              //                                           const ListTile(
              //                                             leading: Icon(
              //                                               Icons.double_arrow,
              //                                               size: 14,
              //                                               color: AppColor
              //                                                   .secondaryColor,
              //                                             ),Constant.kWidth(width:5),
              //                                           ),
              //                                           const ListTile(
              //                                             leading: Icon(
              //                                               Icons.double_arrow,
              //                                               size: 14,
              //                                               color: AppColor
              //                                                   .secondaryColor,
              //                                             ),
              //                                           ),
              //                                           Padding(
              //                                             padding:
              //                                                 const EdgeInsets
              //                                                     .all(8.0),
              //                                             child: Container(
              //                                               alignment: Alignment
              //                                                   .centerLeft,
              //                                               width: 100,
              //                                               decoration:
              //                                                   BoxDecoration(
              //                                                       color: AppColor
              //                                                           .whiteBtnColor,
              //                                                       borderRadius:
              //                                                           BorderRadius.circular(
              //                                                               20.0),
              //                                                       border:
              //                                                           Border
              //                                                               .all(
              //                                                         color: AppColor
              //                                                             .secondaryColor,
              //                                                       )),
              //                                               child:
              //                                                   const Padding(
              //                                                 padding:
              //                                                     EdgeInsets
              //                                                         .all(8.0),
              //                                                 child: Center(
              //                                                     child: Text(
              //                                                   'View More',
              //                                                   style: TextStyle(
              //                                                       fontWeight:
              //                                                           FontWeight
              //                                                               .w500),
              //                                                 )),
              //                                               ),
              //                                             ),
              //                                           ),
              //                                         ],
              //                                       );
              //                                     } else {
              //                                       return const SizedBox();
              //                                     }
              //                                   })
              //                             ],
              //                           ),
              //                         ),
              //                       );
              //                     },
              //                   );
              //                 } else {
              //                   return const Center(
              //                     child: CircularProgressIndicator(
              //                       color: AppColor.secondaryColor,
              //                     ),
              //                   );
              //                 }
              //               },
              //             ),
              //           ),

              //           //sales
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: FutureBuilder<List<TradersCategoryModel>>(
              //               future: traderCategoryList,
              //               builder: (BuildContext context,
              //                   AsyncSnapshot<List<TradersCategoryModel>>
              //                       snapshot) {
              //                 if (snapshot.hasError) {
              //                   return const Center(
              //                     child: Center(
              //                         child: Text("An error has occured")),
              //                   );
              //                 } else if (!snapshot.hasData) {
              //                   return const SizedBox();
              //                 } else if (snapshot.hasData) {
              //                   return GridView.builder(
              //                     physics: const NeverScrollableScrollPhysics(),
              //                     shrinkWrap: true,
              //                     gridDelegate:
              //                         const SliverGridDelegateWithFixedCrossAxisCount(
              //                             crossAxisCount: 2),
              //                     itemCount: serviceList.length,
              //                     itemBuilder: (context, index) {
              //                       return SizedBox(
              //                         child: Card(
              //                           child: Column(
              //                             crossAxisAlignment:
              //                                 CrossAxisAlignment.start,
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.start,
              //                             children: [
              //                               Row(
              //                                 children: [
              //                                   Constant.kWidth(width: 10),
              //                                   Expanded(
              //                                     child: Container(
              //                                       alignment:
              //                                           Alignment.centerLeft,
              //                                       color: Colors.green,
              //                                       height: 40,
              //                                       child: Padding(
              //                                         padding:
              //                                             const EdgeInsets.all(
              //                                                 10),
              //                                         child: Text(
              //                                           serviceList[index]
              //                                               .category
              //                                               .toString(),
              //                                           style: const TextStyle(
              //                                             color: AppColor
              //                                                 .whiteColor,
              //                                           ),
              //                                         ),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                               FutureBuilder<
              //                                       List<TraderSubCategory>>(
              //                                   future: ApiServices
              //                                       .getTraderSubCategory(
              //                                           id: serviceList[index]
              //                                               .id!),
              //                                   builder: (BuildContext context,
              //                                       AsyncSnapshot<
              //                                               List<
              //                                                   TraderSubCategory>>
              //                                           snapshot) {
              //                                     if (snapshot.hasError) {
              //                                       return const Center(
              //                                         child: Text(
              //                                             "An error has occured"),
              //                                       );
              //                                     } else if (snapshot.hasData) {
              // List<TraderSubCategory>
              //     data = snapshot.data!;
              //                                       return Column(
              //                                         crossAxisAlignment:
              //                                             CrossAxisAlignment
              //                                                 .start,
              //                                         mainAxisAlignment:
              //                                             MainAxisAlignment
              //                                                 .start,
              //                                         children: [
              //                                           ListTile(
              //                                             leading: const Icon(
              //                                               Icons.double_arrow,
              //                                               size: 14,
              //                                               color: AppColor
              //                                                   .secondaryColor,
              //                                             ),
              //                                             title: Text(data[0]
              //                                                 .category
              //                                                 .toString()),
              //                                           ),
              //                                           const ListTile(
              //                                             leading: Icon(
              //                                               Icons.double_arrow,
              //                                               size: 14,
              //                                               color: AppColor
              //                                                   .secondaryColor,
              //                                             ),
              //                                           ),
              //                                           Padding(
              //                                             padding:
              //                                                 const EdgeInsets
              //                                                     .all(8.0),
              //                                             child: Container(
              //                                               alignment: Alignment
              //                                                   .centerLeft,
              //                                               width: 100,
              //                                               decoration:
              //                                                   BoxDecoration(
              //                                                       color: AppColor
              //                                                           .whiteBtnColor,
              //                                                       borderRadius:
              //                                                           BorderRadius.circular(
              //                                                               20.0),
              //                                                       border:
              //                                                           Border
              //                                                               .all(
              //                                                         color: AppColor
              //                                                             .secondaryColor,
              //                                                       )),
              //                                               child:
              //                                                   const Padding(
              //                                                 padding:
              //                                                     EdgeInsets
              //                                                         .all(8.0),
              //                                                 child: Center(
              //                                                     child: Text(
              //                                                   'View More',
              //                                                   style: TextStyle(
              //                                                       fontWeight:
              //                                                           FontWeight
              //                                                               .w500),
              //                                                 )),
              //                                               ),
              //                                             ),
              //                                           ),
              //                                         ],
              //                                       );
              //                                     } else {
              //                                       return const SizedBox();
              //                                     }
              //                                   })
              //                             ],
              //                           ),
              //                         ),
              //                       );
              //                     },
              //                   );
              //                 } else {
              //                   return const Center(
              //                     child: CircularProgressIndicator(
              //                       color: AppColor.secondaryColor,
              //                     ),
              //                   );
              //                 }
              //               },
              //             ),
              //           ),
              //         ]),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15, right: 8, top: 8),
              //   child: Row(
              //     children: [
              //       Container(
              //         height: MediaQuery.of(context).size.height * 0.04,
              //         width: MediaQuery.of(context).size.width * 0.2,
              //         decoration: BoxDecoration(
              //           color: AppColor.secondaryColor,
              //           borderRadius: BorderRadius.circular(20.0),
              //         ),
              //         child: const Padding(
              //           padding: EdgeInsets.all(8.0),
              //           child: Center(
              //               child: Text(
              //             'Services',
              //             style: TextStyle(
              //                 color: AppColor.whiteColor,
              //                 fontWeight: FontWeight.w500),
              //           )),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Container(
              //           height: MediaQuery.of(context).size.height * 0.04,
              //           width: MediaQuery.of(context).size.width * 0.2,
              //           decoration: BoxDecoration(
              //             color: AppColor.whiteBtnColor,
              //             borderRadius: BorderRadius.circular(20.0),
              //           ),
              //           child: const Padding(
              //             padding: EdgeInsets.all(8.0),
              //             child: Center(
              //                 child: Text(
              //               'Sales',
              //               style: TextStyle(fontWeight: FontWeight.w500),
              //             )),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              //slaes and services

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: FutureBuilder<List<TradersCategoryModel>>(
              //     future: traderCategoryList,
              //     builder: (BuildContext context,
              //         AsyncSnapshot<List<TradersCategoryModel>> snapshot) {
              //       if (snapshot.hasError) {
              //         return const Center(
              //           child: Center(child: Text("An error has occured")),
              //         );
              //       } else if (!snapshot.hasData) {
              //         return const SizedBox();
              //       } else if (snapshot.hasData) {
              //         return GridView.builder(
              //           physics: const NeverScrollableScrollPhysics(),
              //           shrinkWrap: true,
              //           gridDelegate:
              //               const SliverGridDelegateWithFixedCrossAxisCount(
              //                   crossAxisCount: 2),
              //           itemCount: serviceList.length,
              //           itemBuilder: (context, index) {
              //             return SizedBox(
              //               child: Card(
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     Row(
              //                       children: [
              //                         Constant.kWidth(width: 10),
              //                         Expanded(
              //                           child: Container(
              //                             alignment: Alignment.centerLeft,
              //                             color: Colors.green,
              //                             height: 40,
              //                             child: Padding(
              //                               padding: const EdgeInsets.all(10),
              //                               child: Text(
              //                                 serviceList[index]
              //                                     .category
              //                                     .toString(),
              //                                 style: const TextStyle(
              //                                   color: AppColor.whiteColor,
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                     FutureBuilder<List<TraderSubCategory>>(
              //                         future: ApiServices.getTraderSubCategory(
              //                             id: serviceList[index].id!),
              //                         builder: (BuildContext context,
              //                             AsyncSnapshot<List<TraderSubCategory>>
              //                                 snapshot) {
              //                           if (snapshot.hasError) {
              //                             return const Center(
              //                               child: Text("An error has occured"),
              //                             );
              //                           } else if (snapshot.hasData) {
              //                             return Column(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.start,
              //                               children: [
              //                                 const ListTile(
              //                                   leading: Icon(
              //                                     Icons.double_arrow,
              //                                     size: 14,
              //                                     color:
              //                                         AppColor.secondaryColor,
              //                                   ),
              //                                 ),
              //                                 const ListTile(
              //                                   leading: Icon(
              //                                     Icons.double_arrow,
              //                                     size: 14,
              //                                     color:
              //                                         AppColor.secondaryColor,
              //                                   ),
              //                                 ),
              //                                 Padding(
              //                                   padding:
              //                                       const EdgeInsets.all(8.0),
              //                                   child: Container(
              //                                     alignment:
              //                                         Alignment.centerLeft,
              //                                     width: 100,
              //                                     decoration: BoxDecoration(
              //                                         color: AppColor
              //                                             .whiteBtnColor,
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 20.0),
              //                                         border: Border.all(
              //                                           color: AppColor
              //                                               .secondaryColor,
              //                                         )),
              //                                     child: const Padding(
              //                                       padding:
              //                                           EdgeInsets.all(8.0),
              //                                       child: Center(
              //                                           child: Text(
              //                                         'View More',
              //                                         style: TextStyle(
              //                                             fontWeight:
              //                                                 FontWeight.w500),
              //                                       )),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ],
              //                             );
              //                           } else {
              //                             return const SizedBox();
              //                           }
              //                         })
              //                   ],
              //                 ),
              //               ),
              //             );
              //           },
              //         );
              //       } else {
              //         return const Center(
              //           child: CircularProgressIndicator(
              //             color: AppColor.secondaryColor,
              //           ),
              //         );
              //       }
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: FutureBuilder<List<TradersCategoryModel>>(
              //       future: traderCategoryList,
              //       builder: (BuildContext context, snapshot) {
              //         return GridView.builder(
              //           physics: const NeverScrollableScrollPhysics(),
              //           shrinkWrap: true,
              //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //               crossAxisCount: 2),
              //           itemCount: 5,
              //           itemBuilder: (context, index) {
              //             return Card(
              //               child: Column(
              //                 children: [
              //                   Container(color: Colors.red,
              //                     height: 30,)
              //                 ],
              //               ),
              //             );
              //           },
              //         );
              //       }),
              // ),
              // FutureBuilder<TradersCategoryModel>(
              //   future: traderCatApi,
              //   builder: (BuildContext context,
              //       AsyncSnapshot<TradersCategoryModel> snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting ||
              //         snapshot.connectionState == ConnectionState.none) {
              //       return CircularProgressIndicator(
              //         color: AppColor.secondaryColor,
              //       );
              //     } else if (snapshot.hasData) {
              //       if (snapshot.data!.data.isNotEmpty) {
              //         return GridView.builder(
              //           physics: ScrollPhysics(),
              //           shrinkWrap: true,
              //           itemCount: snapshot.data!.data.length,
              //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 2,
              //           ),
              //           itemBuilder: (BuildContext context, int index) {
              //             return Row(
              //               children: [
              //                 Expanded(
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(5.0),
              //                     child: Column(
              //                       children: [
              //                         Container(
              //                           height:
              //                               MediaQuery.of(context).size.height *
              //                                   0.05,
              //                           width:
              //                               MediaQuery.of(context).size.width *
              //                                   0.5,
              //                           decoration: const BoxDecoration(
              //                             color: Colors.green,
              //                             borderRadius: BorderRadius.only(
              //                               topLeft: Radius.circular(10.0),
              //                               topRight: Radius.circular(10.0),
              //                             ),
              //                           ),
              //                           child: Padding(
              //                             padding: EdgeInsets.all(8.0),
              //                             child: Text(
              //                               snapshot.data!.data
              //                                   .elementAt(index)
              //                                   .category!,
              //                               style: TextStyle(
              //                                   color: AppColor.whiteColor,
              //                                   fontWeight: FontWeight.bold),
              //                             ),
              //                           ),
              //                         ),
              //                         Container(
              //                           height:
              //                               MediaQuery.of(context).size.height *
              //                                   0.15,
              //                           width:
              //                               MediaQuery.of(context).size.width *
              //                                   0.5,
              //                           decoration: const BoxDecoration(
              //                             color: AppColor.whiteBtnColor,
              //                             borderRadius: BorderRadius.only(
              //                               bottomLeft: Radius.circular(10.0),
              //                               bottomRight: Radius.circular(10.0),
              //                             ),
              //                           ),
              //                           child: Column(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               ListView.builder(
              //                                 shrinkWrap: true,
              //                                 itemCount: snapshot.data!.data
              //                                     .elementAt(index)
              //                                     .subcategories
              //                                     ?.length,
              //                                 itemBuilder:
              //                                     (BuildContext context,
              //                                         int catIndex) {
              //                                   return Row(
              //                                     children: [
              //                                       Icon(
              //                                         Icons.double_arrow,
              //                                         color: AppColor
              //                                             .secondaryColor,
              //                                         size:
              //                                             MediaQuery.of(context)
              //                                                     .size
              //                                                     .width *
              //                                                 0.05,
              //                                       ),
              //                                       Expanded(
              //                                         child: Text(
              //                                           snapshot.data!.data
              //                                               .elementAt(index)
              //                                               .subcategories!
              //                                               .elementAt(catIndex)
              //                                               .category!,
              //                                           overflow:
              //                                               TextOverflow.fade,
              //                                         ),
              //                                       )
              //                                     ],
              //                                   );
              //                                 },
              //                               ),
              //                               Padding(
              //                                 padding:
              //                                     const EdgeInsets.all(8.0),
              //                                 child: Container(
              //                                   width: MediaQuery.of(context)
              //                                           .size
              //                                           .width *
              //                                       0.3,
              //                                   decoration: BoxDecoration(
              //                                       color:
              //                                           AppColor.whiteBtnColor,
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               20.0),
              //                                       border: Border.all(
              //                                         color: AppColor
              //                                             .secondaryColor,
              //                                       )),
              //                                   child: const Padding(
              //                                     padding: EdgeInsets.all(8.0),
              //                                     child: Center(
              //                                         child: Text(
              //                                       'View More',
              //                                       style: TextStyle(
              //                                           fontWeight:
              //                                               FontWeight.w500),
              //                                     )),
              //                                   ),
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             );
              //           },
              //         );
              //       } else {
              //         return Text('No Data');
              //       }
              //     } else {
              //       return Text('No Data');
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<BannerModel> fetchBanner() async {
  //   // LoadingDialog.show(context);
  // var response = await http.get(
  //   Uri.parse(ApiService.banners),
  //   headers: Header.header,
  // );
  //   // ignore: avoid_print
  //   print(response.body);
  //   final result = jsonDecode(response.body);
  //   // LoadingDialog.hide(context);
  //   if (result['status'] == 200) {
  //     setState(() {});
  //     ToastMsg.toastMsg(result['message']);
  //     return BannerModel.fromJson(result);
  //   } else {
  //     ToastMsg.toastMsg(result['message']);
  //     return BannerModel.fromJson(result);
  //   }
  // }

  // Future<TradersCategoryModel> fetchTraderCat() async {
  //   // LoadingDialog.show(context);
  //   var response = await http.get(
  //     Uri.parse(ApiService.categories),
  //     headers: Header.header,
  //   );
  //   final result = jsonDecode(response.body);
  //   // LoadingDialog.hide(context);
  //   if (result['status'] == 200) {
  //     // ignore: avoid_print
  //   print(response.body);
  //     setState(() {});
  //     ToastMsg.toastMsg(result['message']);
  //     return TradersCategoryModel.fromJson(result);
  //   } else {
  //     ToastMsg.toastMsg(result['message']);
  //     return TradersCategoryModel.fromJson(result);
  //   }
  // }
}
