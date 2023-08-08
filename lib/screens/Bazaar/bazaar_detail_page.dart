import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:codecarrots_unotraders/model/add_wishlist_model.dart';
import 'package:codecarrots_unotraders/model/bazaar_detail_post_model.dart';
import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/circular_progress.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BazaarDetailScreen extends StatefulWidget {
  final BazaarDetailPostModel postBody;
  const BazaarDetailScreen({super.key, required this.postBody});

  @override
  State<BazaarDetailScreen> createState() => _BazaarDetailScreenState();
}

class _BazaarDetailScreenState extends State<BazaarDetailScreen> {
  late BazaarProvider bazaarProvider;
  void initState() {
    super.initState();

    bazaarProvider = Provider.of<BazaarProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bazaarProvider.bazaarDetail(postBody: widget.postBody);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(
        appBarTitle: "Bazaar",
      ),
      body: Consumer<BazaarProvider>(builder: (context, provider, _) {
        return provider.detailLoading
            ? Center(child: AppConstant.circularProgressIndicator())
            : provider.bazaarDetailError.isNotEmpty
                ? Center(child: TextWidget(data: "Something Went Wrong"))
                : provider.bazaarDetailsGetModel == null
                    ? Center(child: TextWidget(data: "No Data"))
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          children: [
                            Flexible(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  provider.bazaarDetailsGetModel!
                                              .bazaarimages ==
                                          null
                                      ? SizedBox()
                                      : CarouselSlider.builder(
                                          itemCount: provider
                                              .bazaarDetailsGetModel!
                                              .bazaarimages!
                                              .length,
                                          itemBuilder:
                                              (context, index, realIndex) {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                width: size.width,
                                                fit: BoxFit.cover,
                                                imageUrl: provider
                                                    .bazaarDetailsGetModel!
                                                    .bazaarimages![index],
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            );

                                            // ImgFade.fadeImage(
                                            //     width: size.width,
                                            // url: bazaarModel
                                            //     .bazaarimages![index]);
                                          },
                                          options: CarouselOptions(
                                            scrollPhysics: provider
                                                        .bazaarDetailsGetModel!
                                                        .bazaarimages!
                                                        .length ==
                                                    1
                                                ? const NeverScrollableScrollPhysics()
                                                : null,
                                            autoPlayAnimationDuration:
                                                const Duration(
                                                    milliseconds: 800),
                                            viewportFraction: 1,
                                            height: size.height * .4,
                                            autoPlay: provider
                                                        .bazaarDetailsGetModel!
                                                        .bazaarimages!
                                                        .length ==
                                                    1
                                                ? false
                                                : true,
                                            autoPlayInterval:
                                                const Duration(seconds: 5),
                                          )),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * .02,
                                        top: size.width * .02),
                                    child: textWidget(
                                        text: provider.bazaarDetailsGetModel!
                                                .product ??
                                            "",
                                        fontSize: size.width * .04,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: size.width * .02,
                                    ),
                                    child: textWidget(
                                        text:
                                            "Posted by :${provider.bazaarDetailsGetModel!.addedBy ?? ""}",
                                        fontSize: size.width * .04,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * .02,
                                        bottom: size.width * .02),
                                    child: textWidget(
                                        text: provider.bazaarDetailsGetModel!
                                                .description ??
                                            "",
                                        fontSize: size.width * .04,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: size.width * .02,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: size.width * .07,
                                          width: size.width * .47,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      size.width * .05),
                                              border: Border.all(
                                                  color: AppColor.green,
                                                  width: 1.5)),
                                          child: TextWidget(
                                            data:
                                                "Posted: ${DateTime.parse(provider.bazaarDetailsGetModel!.createdAt ?? "").day} ${DateFormat.MMM().format(DateTime.parse(provider.bazaarDetailsGetModel!.createdAt ?? ""))} ${DateTime.parse(provider.bazaarDetailsGetModel!.createdAt ?? "").year}, ${DateFormat('hh:mm a').format(DateTime.parse(provider.bazaarDetailsGetModel!.createdAt ?? ""))}",
                                          ),
                                        ),
                                        AppConstant.kWidth(
                                            width: size.width * .02),
                                        Container(
                                          alignment: Alignment.center,
                                          height: size.width * .07,
                                          width: size.width * .2,
                                          decoration: BoxDecoration(
                                              color: AppColor.green,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      size.width * .05),
                                              border: Border.all(
                                                  color: AppColor.green,
                                                  width: 1.5)),
                                          child: TextWidget(
                                              data: "Share",
                                              style: TextStyle(
                                                color: AppColor.whiteColor,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                  AppConstant.kheight(height: size.width * .02),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * .03,
                                        top: size.width * .02,
                                        bottom: size.width * .02),
                                    child: textWidget(
                                        text: "Related Products",
                                        fontSize: size.width * .04,
                                        fontWeight: FontWeight.w500),
                                  ),

                                  // ListView.builder(                 physics:
                                  //                 const BouncingScrollPhysics(),
                                  //             scrollDirection: Axis.horizontal,
                                  //   itemBuilder: (context, index) {
                                  //     return Card();
                                  //   },
                                  // )
                                  provider.bazaarDetailsGetModel!
                                              .relatedProducts ==
                                          null
                                      ? SizedBox()
                                      : provider.bazaarDetailsGetModel!
                                              .relatedProducts!.isEmpty
                                          ? SizedBox()
                                          : Container(
                                              padding: EdgeInsets.all(
                                                  size.width * .01),
                                              width: size.width,
                                              height: size.height * .44,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: provider
                                                    .bazaarDetailsGetModel!
                                                    .relatedProducts!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  final data = provider
                                                      .bazaarDetailsGetModel!
                                                      .relatedProducts![index];
                                                  DateTime date =
                                                      DateTime.parse(
                                                          data.createdAt ?? "");

                                                  return InkWell(
                                                    onTap: () async {
                                                      final sharedPrefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      String id = sharedPrefs
                                                          .getString('id')!;
                                                      String userType =
                                                          sharedPrefs.getString(
                                                              'userType')!;
                                                      BazaarDetailPostModel
                                                          postBody =
                                                          BazaarDetailPostModel(
                                                              productId:
                                                                  data.id,
                                                              userId:
                                                                  int.parse(id),
                                                              userType:
                                                                  userType);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  BazaarDetailScreen(
                                                                    postBody:
                                                                        postBody,
                                                                  )));
                                                      // Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             BazaarDetail(
                                                      //                 bazaarModel:
                                                      //                     data)));
                                                    },
                                                    child: Card(
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      shadowColor: Colors.grey,
                                                      elevation: 1,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: size.width *
                                                                  .03,
                                                            ),
                                                            child: textWidget(
                                                                text:
                                                                    data.product ??
                                                                        "",
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                left:
                                                                    size.width *
                                                                        .03,
                                                                bottom:
                                                                    size.width *
                                                                        .03,
                                                                top:
                                                                    size.width *
                                                                        .01),
                                                            child: textWidget(
                                                                text:
                                                                    "Posted: ${date.day} ${DateFormat.MMM().format(date)} ${date.year}, ${DateFormat('hh:mm a').format(date)}",
                                                                color: AppColor
                                                                    .green,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              left: size.width *
                                                                  .016,
                                                            ),
                                                            child: data.bazaarimages ==
                                                                    null
                                                                ? Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .broken_image,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                      TextWidget(
                                                                          data:
                                                                              "No image")
                                                                    ],
                                                                  )
                                                                : data.bazaarimages!
                                                                        .isEmpty
                                                                    ? Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.broken_image,
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                          TextWidget(
                                                                              data: "No image")
                                                                        ],
                                                                      )
                                                                    : ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                7),
                                                                        child: ImgFade.fadeImage(
                                                                            height: size.height *
                                                                                .3,
                                                                            width: size.width *
                                                                                .5,
                                                                            url:
                                                                                data.bazaarimages![0])),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: size.width *
                                                                  .03,
                                                            ),
                                                            child:
                                                                ElevatedButton
                                                                    .icon(
                                                              onPressed:
                                                                  () async {
                                                                AppConstant
                                                                    .overlayLoaderShow(
                                                                        context);
                                                                final sharedPrefs =
                                                                    await SharedPreferences
                                                                        .getInstance();
                                                                String id =
                                                                    sharedPrefs
                                                                        .getString(
                                                                            'id')!;
                                                                String
                                                                    userType =
                                                                    sharedPrefs
                                                                        .getString(
                                                                            'userType')!;
                                                                print(
                                                                    "shortlisted pressed");
                                                                AddWishListModel
                                                                    wishlist =
                                                                    AddWishListModel(
                                                                        productId:
                                                                            data
                                                                                .id,
                                                                        userId: int.parse(
                                                                            id),
                                                                        userType:
                                                                            userType);
                                                                if (data.wishlist ==
                                                                    1) {
                                                                  //remove short list
                                                                  await bazaarProvider
                                                                      .removeWishlistFromDetails(
                                                                          wishlist:
                                                                              wishlist,
                                                                          postBody: widget
                                                                              .postBody)
                                                                      .then(
                                                                          (value) {
                                                                    AppConstant.toastMsg(
                                                                        msg:
                                                                            "Product Removed from Wishlist",
                                                                        backgroundColor:
                                                                            AppColor.green);

                                                                    return;
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    AppConstant.toastMsg(
                                                                        msg:
                                                                            "Something Went Wrong",
                                                                        backgroundColor:
                                                                            AppColor.red);
                                                                    return;
                                                                  });
                                                                } else {
                                                                  //add short list
                                                                  await bazaarProvider
                                                                      .addWishlistFromDetails(
                                                                          wishlist:
                                                                              wishlist,
                                                                          postBody: widget
                                                                              .postBody)
                                                                      .then(
                                                                          (value) {
                                                                    AppConstant.toastMsg(
                                                                        msg:
                                                                            "Product Added to Wishlist",
                                                                        backgroundColor:
                                                                            AppColor.green);

                                                                    return;
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    AppConstant.toastMsg(
                                                                        msg:
                                                                            "Something Went Wrong",
                                                                        backgroundColor:
                                                                            AppColor.red);
                                                                    return;
                                                                  });
                                                                }
                                                                AppConstant
                                                                    .overlayLoaderHide(
                                                                        context);
                                                              },
                                                              icon: const Icon(
                                                                Icons.check_box,
                                                                size: 15,
                                                              ),
                                                              label: data.wishlist ==
                                                                      1
                                                                  ? TextWidget(
                                                                      data:
                                                                          "Shortlisted")
                                                                  : TextWidget(
                                                                      data:
                                                                          "Shortlist"),
                                                              style: ElevatedButton.styleFrom(
                                                                  backgroundColor: data
                                                                              .wishlist ==
                                                                          1
                                                                      ? AppColor
                                                                          .blackColor
                                                                      : AppColor
                                                                          .green,
                                                                  minimumSize: Size(
                                                                      size.width *
                                                                          .44,
                                                                      size.width *
                                                                          .06),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20))),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
      }),
    );
  }

  Widget textWidget(
      {required String text,
      required double fontSize,
      required FontWeight fontWeight,
      Color? color}) {
    return TextWidget(
      data: text,
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? AppColor.blackColor,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }
}
