import 'package:codecarrots_unotraders/model/Trader%20Search/trader_search.dart';
import 'package:codecarrots_unotraders/model/provider_profile_model.dart';
import 'package:codecarrots_unotraders/provider/home_provider.dart';
import 'package:codecarrots_unotraders/screens/Message%20Section/chat_screen.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TraderSearchResultsScreen extends StatefulWidget {
  final TraderSearch traderSearchModel;
  const TraderSearchResultsScreen({
    super.key,
    required this.traderSearchModel,
  });

  @override
  State<TraderSearchResultsScreen> createState() => _TraderSearchPopUpState();
}

class _TraderSearchPopUpState extends State<TraderSearchResultsScreen> {
  ScrollController _scrollController = ScrollController();
  late HomeProvider provider;
  bool isLoading = false;
  int? selectedIndex;

  @override
  void initState() {
    provider = Provider.of<HomeProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.clearTraderSearch();
      provider.searchTrader(traderSearchModel: widget.traderSearchModel);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 300) {
        if (selectedIndex == null) {
          provider.searchTrader(traderSearchModel: widget.traderSearchModel);
        } else {}
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarWidget(appBarTitle: "Search Results"),
      body: Consumer<HomeProvider>(
          builder: (BuildContext context, homeProvider, _) {
        return homeProvider.traderLoading
            ? Center(child: AppConstant.circularProgressIndicator())
            : homeProvider.traderErrorMessage.isNotEmpty
                ? Center(
                    child: TextWidget(
                        data: homeProvider.traderErrorMessage,
                        style: const TextStyle(fontSize: 18)))
                : homeProvider.traderSearchList.isEmpty
                    ? Center(
                        child: TextWidget(
                        data: "No result found",
                        style: const TextStyle(fontSize: 18),
                      ))
                    : Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      height: 36,
                                      width: size.width,
                                      child: ListView.builder(
                                        itemCount:
                                            homeProvider.allCatList.length,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final category =
                                              homeProvider.allCatList[index];
                                          return InkWell(
                                            onTap: () {
                                              if (selectedIndex == index) {
                                                widget.traderSearchModel
                                                    .category = null;
                                                widget.traderSearchModel
                                                    .sortBy = 1;
                                                setState(() {
                                                  selectedIndex = null;
                                                });
                                                provider
                                                    .clearTraderSearchFilter();
                                              } else {
                                                widget.traderSearchModel
                                                    .category = category.id;
                                                widget.traderSearchModel
                                                    .sortBy = 1;
                                                setState(() {
                                                  selectedIndex = index;
                                                });
                                                provider
                                                    .clearTraderSearchFilter();
                                                provider.filterSearchResults(
                                                    traderSearchModel: widget
                                                        .traderSearchModel);
                                              }
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: selectedIndex == index
                                                      ? Colors.green
                                                      : null,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  border: Border.all(
                                                      color: AppColor.green)),
                                              child: TextWidget(
                                                data: category.category ?? "",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: selectedIndex ==
                                                            index
                                                        ? AppColor.whiteColor
                                                        : AppColor.blackColor),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 3.0),
                                child: PopupMenuButton<int>(
                                    icon: Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      height: 36,
                                      decoration: BoxDecoration(
                                          color: AppColor.blackColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: FaIcon(
                                        FontAwesomeIcons.arrowDownShortWide,
                                        size: 17,
                                        color: AppColor.whiteColor,
                                      ),
                                    ),
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuItem<int>>[
                                          PopupMenuItem<int>(
                                              value: 1,
                                              child:
                                                  TextWidget(data: 'Latest')),
                                          PopupMenuItem<int>(
                                              value: 2,
                                              child: TextWidget(data: 'A-Z')),
                                          PopupMenuItem<int>(
                                              value: 3,
                                              child: TextWidget(data: 'Z-A')),
                                        ],
                                    onSelected: (int value) {
                                      print(value.toString());

                                      widget.traderSearchModel.sortBy = value;

                                      provider.clearTraderSearchFilter();
                                      provider.filterSearchResults(
                                          traderSearchModel:
                                              widget.traderSearchModel);
                                    }),
                              ),
                            ],
                          ),
                          Expanded(
                            child:
                                homeProvider.isSorting &&
                                        homeProvider.traderFilterLoading
                                    ? Center(
                                        child: AppConstant
                                            .circularProgressIndicator())
                                    : homeProvider.isSorting &&
                                            homeProvider
                                                .traderFilterErrorMessage
                                                .isNotEmpty
                                        ? Center(
                                            child: TextWidget(
                                                data: homeProvider
                                                    .traderFilterErrorMessage,
                                                style: const TextStyle(
                                                    fontSize: 18)))
                                        : homeProvider.isSorting &&
                                                homeProvider
                                                    .traderSearchFilterList
                                                    .isEmpty
                                            ? Center(
                                                child: TextWidget(
                                                data: "No result found",
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ))
                                            : ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                controller: _scrollController,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: size.width * .01),
                                                shrinkWrap: true,
                                                itemCount: homeProvider
                                                        .traderSearchFilterList
                                                        .isEmpty
                                                    ? homeProvider
                                                        .traderSearchList.length
                                                    : homeProvider
                                                        .traderSearchFilterList
                                                        .length,
                                                itemBuilder: (context, index) {
                                                  ProviderProfileModel data = homeProvider
                                                          .traderSearchFilterList
                                                          .isEmpty
                                                      ? homeProvider
                                                              .traderSearchList[
                                                          index]
                                                      : homeProvider
                                                              .traderSearchFilterList[
                                                          index];
                                                  DateTime date =
                                                      DateTime.parse(
                                                          data.createdAt ?? "");
                                                  return Column(
                                                    children: [
                                                      Card(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .all(size
                                                                              .width *
                                                                          .02),
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius:
                                                                        size.width *
                                                                            .07,
                                                                    backgroundColor:
                                                                        AppColor
                                                                            .green,
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          AppColor
                                                                              .whiteColor,
                                                                      radius:
                                                                          size.width *
                                                                              .06,
                                                                      backgroundImage:
                                                                          NetworkImage(
                                                                        data.profilePic ??
                                                                            "",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: size.width *
                                                                            .03,
                                                                        bottom: size.width *
                                                                            .03),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        title(
                                                                            text: data.name ??
                                                                                "",
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                        Row(
                                                                          children: [
                                                                            title(
                                                                                text: data.rating ?? "",
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.bold,
                                                                                maxLines: 1),
                                                                            AppConstant.kWidth(width: size.width * .01),
                                                                            Expanded(
                                                                                child: Container(
                                                                              child: title(text: "reviews", color: AppColor.green, fontSize: 12, fontWeight: FontWeight.bold),
                                                                            ))
                                                                          ],
                                                                        ),
                                                                        title(
                                                                            text: data.completedWorks ??
                                                                                "",
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            // Padding(
                                                            //   padding: EdgeInsets.symmetric(
                                                            //       horizontal: size.width * .02),
                                                            //   child: title(
                                                            //       text: 'Description missing ',
                                                            //       maxLines: 2,
                                                            //       fontWeight: FontWeight.w500),
                                                            // ),
                                                            SizedBox(
                                                              height:
                                                                  size.width *
                                                                      .01,
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          size.width *
                                                                              .02),
                                                              child:
                                                                  messageCallRow(
                                                                      context,
                                                                      data,
                                                                      size),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  size.width *
                                                                      .02,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      homeProvider
                                                              .traderSearchFilterList
                                                              .isNotEmpty
                                                          ? index == homeProvider.traderSearchFilterList.length - 1 &&
                                                                  homeProvider
                                                                      .isFetching &&
                                                                  homeProvider
                                                                      .filterHasNext &&
                                                                  homeProvider
                                                                      .traderSearchFilterList
                                                                      .isNotEmpty
                                                              ? SizedBox(
                                                                  height: 90,
                                                                  child: AppConstant
                                                                      .circularProgressIndicator())
                                                              : const SizedBox()
                                                          : index ==
                                                                      homeProvider
                                                                              .traderSearchList.length -
                                                                          1 &&
                                                                  homeProvider
                                                                      .isFetching &&
                                                                  homeProvider
                                                                      .hasNext &&
                                                                  homeProvider
                                                                      .traderSearchList
                                                                      .isNotEmpty
                                                              ? SizedBox(
                                                                  height: 90,
                                                                  child: AppConstant
                                                                      .circularProgressIndicator())
                                                              : const SizedBox()
                                                    ],
                                                  );
                                                },
                                              ),
                          )
                        ],
                      );
      }),
    );
  }

  Widget title(
      {required String text,
      required double fontSize,
      required FontWeight fontWeight,
      int? maxLines,
      Color? color}) {
    return TextWidget(
      data: text,
      maxLines: maxLines ?? 2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? AppColor.blackColor),
    );
  }

  Row messageCallRow(
      BuildContext context, ProviderProfileModel data, Size size) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: ChatScreen(
                          profilePic: data.profilePic ?? "",
                          toUserId: data.id ?? 0,
                          toUsertype: "trader",
                          name: data.name ?? "",
                        )));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * .05),
                  color: Colors.green,
                ),
                height: size.width * .08,
                child: TextWidget(
                  data: "Message",
                  style: const TextStyle(color: AppColor.whiteColor),
                ),
              ),
            )),
        SizedBox(
          width: size.width * .02,
        ),
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: () async {
                print("pressed");
                if (data.mobile != null && data.countryCode != null) {
                  if (data.mobile!.isNotEmpty && data.countryCode!.isNotEmpty) {
                    final Uri _phoneNo = Uri.parse(
                        'tel:+${data.countryCode ?? ''}${data.mobile ?? ""}');
                    if (await launchUrl(_phoneNo)) {
                      print(" opened");
                      //dialer opened
                    } else {
                      print("not opened");
                      //dailer is not opened
                    }
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * .05),
                  color: Colors.green,
                ),
                height: size.width * .08,
                child: TextWidget(
                  data: "Call",
                  style: const TextStyle(color: AppColor.whiteColor),
                ),
              ),
            )),
      ],
    );
  }
}
