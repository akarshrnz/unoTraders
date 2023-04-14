import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
import 'package:codecarrots_unotraders/model/get_accept_reject_model.dart';
import 'package:codecarrots_unotraders/model/job_more_details_model.dart';
import 'package:codecarrots_unotraders/model/reply_job_more_details_model.dart';
import 'package:codecarrots_unotraders/provider/trader_job_info_provider.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/trader%20job%20type/quote_request_popup.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:codecarrots_unotraders/utils/png.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TraderJobMoreDetail extends StatefulWidget {
  final String jobId;
  final bool isAlljobs;
  const TraderJobMoreDetail(
      {super.key, required this.isAlljobs, required this.jobId});

  @override
  State<TraderJobMoreDetail> createState() => _TraderJobMoreDetailState();
}

class _TraderJobMoreDetailState extends State<TraderJobMoreDetail> {
  late TraderInfoProvider infoProvider;
  TextEditingController replyController = TextEditingController();
  TextEditingController tempController = TextEditingController();
  FocusNode tempFocusNode = FocusNode();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    infoProvider = Provider.of<TraderInfoProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      infoProvider.clearGetJobMoreDetails();
      // infoProvider.getTraderJobInformation(
      //     jobId: widget.jobDetails.jobId.toString());
      infoProvider.getJobMoreDetails(jobId: widget.jobId);
    });
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 300) {
        infoProvider.getJobMoreDetails(jobId: widget.jobId);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    replyController.dispose();
    tempController.dispose();
    tempFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("update trader More details >>>>");
    print("job id ${widget.jobId}");

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: AppColor.whiteColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              PngImages.arrowBack,
              width: MediaQuery.of(context).size.width * 0.06,
            )),
        centerTitle: true,
        title: TextWidget(
          data: 'Job',
          style: TextStyle(color: AppColor.blackColor),
        ),
      ),
      body: Consumer<TraderInfoProvider>(builder: (context, provider, _) {
        return provider.traderMoreLoading && provider.jobDetailsModel == null
            ? SizedBox(
                width: size.width,
                height: size.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Padding(
                padding: EdgeInsets.all(size.width * .03),
                child: provider.jobDetailsModel == null
                    ? SizedBox()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView(
                              controller: _scrollController,
                              children: [
                                provider.jobDetailsModel!.jobimages == null
                                    ? SizedBox()
                                    : SizedBox(
                                        height: size.height * .2,
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              AppConstant.kWidth(width: 10),
                                          shrinkWrap: true,
                                          itemCount: provider.jobDetailsModel!
                                              .jobimages!.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) =>
                                              ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: provider.jobDetailsModel!
                                                    .jobimages!.isEmpty
                                                ? ImgFade.errorImage(
                                                    width: size.width * .6,
                                                    height: size.height * .1)
                                                : ImgFade.fadeImage(
                                                    height: size.height * .1,
                                                    width: size.width * .6,
                                                    url: provider
                                                        .jobDetailsModel!
                                                        .jobimages![index]),
                                          ),
                                        ),
                                      ),
                                AppConstant.kheight(height: size.width * .02),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.width * .02),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: size.width * .57,
                                            child: TextWidget(
                                              data: provider
                                                  .jobDetailsModel!.title
                                                  .toString(),
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  color: AppColor.blackColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          AppConstant.kheight(
                                              height: size.width * .02),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: size.height * .04,
                                                decoration: BoxDecoration(
                                                  color: Colors.orangeAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Center(
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left:
                                                                      size.width *
                                                                          .02),
                                                          child: Image.asset(
                                                              PngImages.dollar),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left: size.width *
                                                                  .01,
                                                              right:
                                                                  size.width *
                                                                      .02),
                                                          child: TextWidget(
                                                            data: provider
                                                                .jobDetailsModel!
                                                                .budget
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color: AppColor
                                                                  .whiteColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              AppConstant.kWidth(
                                                  width: size.width * .01),
                                              const Icon(
                                                Icons.alarm,
                                                color: AppColor.primaryColor,
                                              ),
                                              TextWidget(
                                                data:
                                                    "Posted:  ${DateTime.parse(provider.jobDetailsModel!.createdAt!).day} ${DateFormat.MMM().format(DateTime.parse(provider.jobDetailsModel!.createdAt!))} ${DateTime.parse(provider.jobDetailsModel!.createdAt!).year}",
                                                style: TextStyle(
                                                  color:
                                                      AppColor.secondaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: size.width * 0.028,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                AppConstant.kheight(height: size.width * .02),
                                // widget.isAlljobs == false
                                //     ? const SizedBox()
                                //     :
                                SizedBox(
                                  width: size.width,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (context) =>
                                                QuoteRequestPopUp(
                                              callMessage: true,
                                              jobTitle: provider
                                                      .jobDetailsModel!.title ??
                                                  "",
                                              userid: provider
                                                  .jobDetailsModel!.userId
                                                  .toString(),
                                              jobId: provider
                                                  .jobDetailsModel!.id
                                                  .toString(),
                                              isRequestMoreDetails: true,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: size.width * .4,
                                          padding:
                                              EdgeInsets.all(size.width * .02),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: AppColor.green,
                                          ),
                                          child: TextWidget(
                                            data: "Request More details",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * .03,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (context) =>
                                                QuoteRequestPopUp(
                                              callMessage: true,
                                              jobTitle: provider
                                                      .jobDetailsModel!.title ??
                                                  "",
                                              userid: provider
                                                  .jobDetailsModel!.userId
                                                  .toString(),
                                              jobId: provider
                                                  .jobDetailsModel!.id
                                                  .toString(),
                                            ),
                                          );
                                          // await showDialog(
                                          //   context: context,
                                          //   builder: (context) => QuoteRequestPopUp(
                                          //     jobDetails: widget.jobDetails,
                                          //   ),
                                          // );
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: size.width * .3,
                                          padding:
                                              EdgeInsets.all(size.width * .02),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: AppColor.green,
                                          ),
                                          child: TextWidget(
                                            data: "Quote Job",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                AppConstant.kheight(height: size.width * .02),
                                provider.traderJobInfo.isEmpty
                                    ? const SizedBox()
                                    : TextWidget(
                                        data: "Job Quote Requests",
                                        style: TextStyle(
                                            color: AppColor.blackColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                AppConstant.kheight(height: size.width * .02),
                                provider.quoteList.isEmpty
                                    ? SizedBox()
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: provider.quoteList.length,
                                        itemBuilder: (context, index) {
                                          Quotes quote =
                                              provider.quoteList[index];
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade300)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                titleTrader(
                                                  size: size,
                                                  titleOne: "Trader",
                                                  titleTwo: quote.name ?? "",
                                                ),
                                                titleTrader(
                                                  size: size,
                                                  titleOne: "Quote Price",
                                                  titleTwo:
                                                      quote.quotedPrice ?? "",
                                                ),
                                                titleTrader(
                                                  size: size,
                                                  titleOne: "Quote Reason",
                                                  titleTwo:
                                                      quote.quoteReason ?? "",
                                                ),
                                                titleTrader(
                                                  size: size,
                                                  titleOne: "Status",
                                                  titleTwo: quote.status ?? "",
                                                ),
                                                quote.details == null
                                                    ? SizedBox()
                                                    : quote.details!.isEmpty
                                                        ? SizedBox()
                                                        : Divider(),
                                                quote.details == null
                                                    ? SizedBox()
                                                    : quote.details!.isEmpty
                                                        ? SizedBox()
                                                        : AppConstant.kheight(
                                                            height: size.width *
                                                                .01),
                                                quote.details == null
                                                    ? SizedBox()
                                                    : quote.details!.isEmpty
                                                        ? SizedBox()
                                                        : TextWidget(
                                                            data:
                                                                "Communication Details",
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                AppConstant.kheight(
                                                    height: size.width * .02),
                                                quote.details == null
                                                    ? SizedBox()
                                                    : quote.details!.isEmpty
                                                        ? SizedBox()
                                                        : Card(
                                                            elevation: .5,
                                                            color: Color(
                                                                0XFFEEFFEC),
                                                            child: Column(
                                                              children: [
                                                                ListView
                                                                    .separated(
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  separatorBuilder: (context,
                                                                          index) =>
                                                                      AppConstant.kheight(
                                                                          height:
                                                                              1),
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount: quote
                                                                      .details!
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          subIndex) {
                                                                    final details =
                                                                        quote.details![
                                                                            subIndex];
                                                                    DateTime
                                                                        createdDate =
                                                                        DateTime.parse(
                                                                            details.createdAt!);
                                                                    return subIndex >=
                                                                                2 &&
                                                                            quote.isExpanded ==
                                                                                false
                                                                        ? SizedBox()
                                                                        : Container(
                                                                            margin: subIndex == 0
                                                                                ? EdgeInsets.all(1)
                                                                                : EdgeInsets.only(left: 20, right: 10, bottom: 7),
                                                                            child:
                                                                                Card(
                                                                              color: subIndex == 0 ? Color(0XFFEEFFEC) : null,
                                                                              elevation: 0,
                                                                              child: Column(
                                                                                children: [
                                                                                  AppConstant.kheight(height: size.width * .02),
                                                                                  Row(
                                                                                    children: [
                                                                                      AppConstant.kWidth(width: size.width * .02),
                                                                                      details.profilePic == null
                                                                                          ? CircleAvatar(
                                                                                              radius: MediaQuery.of(context).size.width * 0.06,
                                                                                              child: Image.asset(
                                                                                                PngImages.profile,
                                                                                              ),
                                                                                            )
                                                                                          : CircleAvatar(
                                                                                              backgroundColor: AppColor.green,
                                                                                              radius: size.width * .055,
                                                                                              child: CircleAvatar(
                                                                                                backgroundColor: AppColor.whiteColor,
                                                                                                radius: size.width * .049,
                                                                                                backgroundImage: NetworkImage(details.profilePic ?? ""),
                                                                                              ),
                                                                                            ),
                                                                                      AppConstant.kWidth(width: size.width * .018),
                                                                                      Expanded(
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Expanded(
                                                                                              child: Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                                children: [
                                                                                                  TextWidget(
                                                                                                    data: details.name ?? "",
                                                                                                    maxLines: 1,
                                                                                                    style: TextStyle(
                                                                                                      color: AppColor.blackColor,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                    ),
                                                                                                  ),
                                                                                                  AppConstant.kheight(height: size.width * .005),
                                                                                                  TextWidget(
                                                                                                    data: "Posted: ${createdDate.day} ${DateFormat.MMM().format(createdDate)} ${createdDate.year}",
                                                                                                    style: TextStyle(color: Colors.black54),
                                                                                                  ),
                                                                                                  AppConstant.kheight(height: size.width * .006),
                                                                                                  Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Flexible(
                                                                                                        child: ReadMoreText(
                                                                                                          details.details.toString(),
                                                                                                          readMoreIconColor: AppColor.blackColor,
                                                                                                          numLines: 3,
                                                                                                          readMoreAlign: Alignment.centerLeft,
                                                                                                          style: TextStyle(fontSize: size.width * .033),
                                                                                                          readMoreTextStyle: TextStyle(fontSize: size.width * .033, color: Colors.black),
                                                                                                          readMoreText: 'Read More',
                                                                                                          readLessText: 'Read Less',
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  AppConstant.kheight(height: size.width * .02),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                  },
                                                                ),
                                                                quote.details!
                                                                            .length <=
                                                                        2
                                                                    ? SizedBox()
                                                                    : InkWell(
                                                                        onTap:
                                                                            () {
                                                                          infoProvider
                                                                              .viewAllReply(index);
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: size.width * .048,
                                                                              vertical: quote.isExpanded! ? size.width * .02 : 0),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Container(
                                                                              alignment: Alignment.center,
                                                                              height: size.width * .05,
                                                                              width: size.width * .2,
                                                                              decoration: BoxDecoration(color: AppColor.green),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  FaIcon(
                                                                                    FontAwesomeIcons.share,
                                                                                    size: size.width * .037,
                                                                                    color: AppColor.whiteColor,
                                                                                  ),
                                                                                  AppConstant.kWidth(width: size.width * .009),
                                                                                  TextWidget(
                                                                                    data: quote.isExpanded! ? "Hide" : "view all",
                                                                                    style: TextStyle(color: AppColor.whiteColor),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                AppConstant.kheight(
                                                                    height: size
                                                                            .width *
                                                                        .02),

                                                                //textfield
                                                                quote.details ==
                                                                        null
                                                                    ? SizedBox()
                                                                    : quote.details!
                                                                            .isEmpty
                                                                        ? SizedBox()
                                                                        : Container(
                                                                            height:
                                                                                size.width * .086,
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                                            margin:
                                                                                EdgeInsetsDirectional.symmetric(horizontal: 10),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Expanded(
                                                                                    child: TextField(
                                                                                  controller: provider.replyControllerList[index],
                                                                                  decoration: InputDecoration(hintText: "Write Something", filled: true, fillColor: Colors.white, border: InputBorder.none),
                                                                                )),
                                                                                InkWell(
                                                                                  onTap: () async {
                                                                                    AppConstant.overlayLoaderShow(context);
                                                                                    FocusScope.of(context).requestFocus(tempFocusNode);

                                                                                    final _sharedPrefs = await SharedPreferences.getInstance();
                                                                                    final userType = _sharedPrefs.getString('userType').toString();
                                                                                    final userId = _sharedPrefs.getString('id').toString();
                                                                                    ReplyMoreDetailsModel reply = ReplyMoreDetailsModel(
                                                                                        jobId: provider.jobDetailsModel!.id,
                                                                                        userType: userType,
                                                                                        userId: int.parse(userId),
                                                                                        jobQuoteId: quote.id,
                                                                                        jobQuoteDetailsId: quote.details!.isEmpty
                                                                                            ? 0
                                                                                            : quote.details!.length == 1
                                                                                                ? 0
                                                                                                : quote.details![0].id,
                                                                                        quoteDetails: provider.replyControllerList[index].text);
                                                                                    await infoProvider.postJobMoreDetailsReplyComment(
                                                                                      index: index,
                                                                                      reply: reply,
                                                                                    );

                                                                                    AppConstant.overlayLoaderHide(context);
                                                                                  },
                                                                                  child: Container(
                                                                                    height: size.width * .086,
                                                                                    width: size.width * .14,
                                                                                    alignment: Alignment.center,
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)), color: AppColor.green),
                                                                                    child: TextWidget(
                                                                                      data: "Reply",
                                                                                      style: TextStyle(color: AppColor.whiteColor),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    AppConstant
                                                                        .kWidth(
                                                                            width:
                                                                                5),
                                                                  ],
                                                                ),
                                                                AppConstant.kheight(
                                                                    height: size
                                                                            .width *
                                                                        .02),
                                                              ],
                                                            ),
                                                          )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                provider.isFetching &&
                                        provider.hasNext &&
                                        provider.quoteList.isNotEmpty
                                    ? SizedBox(
                                        height: 90,
                                        child: AppConstant
                                            .circularProgressIndicator())
                                    : SizedBox()
                              ],
                            ),
                          ),
                        ],
                      ),
              );
      }),
    );
  }

  ListView bodyWidget(TraderInfoProvider provider, Size size) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: provider.traderJobInfo.length,
      itemBuilder: (context, index) {
        final data = provider.traderJobInfo[index];

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleTrader(
                size: size,
                titleOne: "Trader",
                titleTwo: data.name ?? "",
              ),
              titleTrader(
                size: size,
                titleOne: "Quote Price",
                titleTwo: data.quotedPrice ?? "",
              ),
              titleTrader(
                size: size,
                titleOne: "Quote Reason",
                titleTwo: data.quoteReason ?? "",
              ),
              titleTrader(
                size: size,
                titleOne: "Status",
                titleTwo: data.status ?? "",
              ),
              Divider(),
              TextWidget(
                data: "Communication Details",
                maxLines: 1,
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
                overflow: TextOverflow.ellipsis,
              ),
              Card(
                color: Color(0XFFEEFFEC),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .03,
                  ),
                  child: Column(
                    children: [
                      AppConstant.kheight(height: size.width * .03),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.06,
                            child: Image.asset(
                              PngImages.profile,
                            ),
                          ),
                          AppConstant.kWidth(width: size.width * .018),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        data: 'name',
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: AppColor.blackColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      AppConstant.kheight(
                                          height: size.width * .005),
                                      TextWidget(
                                        data: "Posted: 223333",
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: ReadMoreText(
                              "texr expand",
                              readMoreIconColor: AppColor.blackColor,
                              numLines: 3,
                              readMoreAlign: Alignment.centerLeft,
                              style: TextStyle(fontSize: size.width * .033),
                              readMoreTextStyle: TextStyle(
                                  fontSize: size.width * .033,
                                  color: Colors.black),
                              readMoreText: 'Read More',
                              readLessText: 'Read Less',
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, innerIndex) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: size.width * .04,
                              top: size.width * .005,
                            ),
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * .03,
                                    vertical: size.width * .02),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.06,
                                          child: Image.asset(
                                            PngImages.profile,
                                          ),
                                        ),
                                        AppConstant.kWidth(
                                            width: size.width * .018),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    TextWidget(
                                                      data: "sddsd",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color:
                                                            AppColor.blackColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    AppConstant.kheight(
                                                        height:
                                                            size.width * .005),
                                                    TextWidget(
                                                      data: "Posted: ",
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: ReadMoreText(
                                            "hghghgh",
                                            readMoreIconColor:
                                                AppColor.blackColor,
                                            numLines: 3,
                                            readMoreAlign: Alignment.centerLeft,
                                            style: TextStyle(
                                                fontSize: size.width * .033),
                                            readMoreTextStyle: TextStyle(
                                                fontSize: size.width * .033,
                                                color: Colors.black),
                                            readMoreText: 'Read More',
                                            readLessText: 'Read Less',
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     // commentProvider.expandComment(
                      //     //     index: index);
                      //   },
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(
                      //         horizontal: size.width * .048,
                      //         vertical: commentProvider
                      //                 .expandable[index]
                      //             ? size.width * .02
                      //             : 0),
                      //     child: Align(
                      //       alignment: Alignment.centerLeft,
                      //       child: Container(
                      //         alignment: Alignment.center,
                      //         height: size.width * .05,
                      //         width: size.width * .2,
                      //         decoration: BoxDecoration(
                      //             color: AppColor.green),
                      //         child: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment
                      //                   .center,
                      //           children: [
                      //             FaIcon(
                      //               FontAwesomeIcons.share,
                      //               size: size.width * .037,
                      //               color:
                      //                   AppColor.whiteColor,
                      //             ),
                      //             AppConstant.kWidth(
                      //                 width: size.width *
                      //                     .009),
                      //             TextWidget(
                      //               data: commentProvider
                      //                           .expandable[
                      //                       index]
                      //                   ? "Hide"
                      //                   : "${commentModel.replies!.length} Reply",
                      //               style: TextStyle(
                      //                   color: AppColor
                      //                       .whiteColor),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // AppConstant.kheight(
                      //     height: size.width * .02),

                      // commentProvider.replyLoading &&
                      //         commentProvider
                      //             .textControllerList[index]
                      //             .text
                      //             .isNotEmpty
                      //     ? Padding(
                      //         padding:
                      //             const EdgeInsets.all(5.0),
                      //         child: const Center(
                      //           child:
                      //               CircularProgressIndicator(
                      //             color: AppColor.green,
                      //           ),
                      //         ),
                      //       )
                      //     : SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: size.width * .09,
                            width: size.width * .627,
                            child: TextFieldWidget(
                                // controller: commentProvider
                                //         .textControllerList[
                                //     index],
                                hintText: "Write Something",
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (p0) {
                                  // replyFocus.unfocus();
                                },
                                onEditingComplete: () =>
                                    FocusScope.of(context).nextFocus(),
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This field is required";
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          InkWell(
                            onTap: () async {
                              final _sharedPrefs =
                                  await SharedPreferences.getInstance();
                              final userType =
                                  _sharedPrefs.getString('userType').toString();
                              final userId =
                                  _sharedPrefs.getString('id').toString();
                            },
                            child: Container(
                              width: size.width * .14,
                              alignment: Alignment.center,
                              height: size.width * .086,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                  color: AppColor.green),
                              child: TextWidget(
                                data: "Reply",
                                style: TextStyle(color: AppColor.whiteColor),
                              ),
                            ),
                          )
                        ],
                      ),
                      AppConstant.kheight(height: size.width * .018),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget titleTrader({
    required Size size,
    required String titleOne,
    required String titleTwo,
  }) {
    return Container(
      padding: EdgeInsets.only(
        // left: size.width * .04,
        right: size.width * .01,
        top: size.width * .02,
      ),
      child: Row(
        children: [
          Flexible(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(size.width * .01),
                      alignment: Alignment.centerLeft,
                      width: size.width * .23,
                      child: TextWidget(
                        data: titleOne,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    AppConstant.kWidth(width: size.width * .01),
                    TextWidget(
                      data: ":",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    AppConstant.kWidth(width: size.width * .028),
                    Expanded(
                        child: Container(
                      child: TextWidget(
                        data: titleTwo,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
