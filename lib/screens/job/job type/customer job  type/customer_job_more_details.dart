import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
import 'package:codecarrots_unotraders/model/reply_job_more_details_model.dart';
import 'package:codecarrots_unotraders/provider/customer_job_actions_provider.dart';
import 'package:codecarrots_unotraders/provider/trader_job_info_provider.dart';
import 'package:codecarrots_unotraders/screens/Message%20Section/chat_screen.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:codecarrots_unotraders/utils/png.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerJobMoreDetails extends StatefulWidget {
  final String jobId;

  const CustomerJobMoreDetails({super.key, required this.jobId});

  @override
  State<CustomerJobMoreDetails> createState() => _CustomerJobMoreDetailsState();
}

class _CustomerJobMoreDetailsState extends State<CustomerJobMoreDetails> {
  TextEditingController replyController = TextEditingController();
  TextEditingController tempController = TextEditingController();
  FocusNode tempFocusNode = FocusNode();
  late CustomerJobActionProvider customerActionProvider;
  late TraderInfoProvider infoProvider;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    infoProvider = Provider.of<TraderInfoProvider>(context, listen: false);
    customerActionProvider =
        Provider.of<CustomerJobActionProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // customerActionProvider.clearAll();
      // customerActionProvider.fetchTraderQuoteReq(jobId: widget.jobId);
      //get job details
      infoProvider.clearGetJobMoreDetails();
      infoProvider.getJobMoreDetails(jobId: widget.jobId);
    });
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
    print(widget.jobId);
    print("Updated job more details>>>>");
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
        return Padding(
          padding: EdgeInsets.all(size.width * .03),
          child: provider.traderMoreLoading && provider.jobDetailsModel == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : provider.traderMoreErrorMessage.isNotEmpty
                  ? Center(
                      child: TextWidget(data: provider.traderMoreErrorMessage),
                    )
                  : provider.jobDetailsModel == null
                      ? SizedBox()
                      : Column(
                          children: [
                            Flexible(
                                child: ListView(
                              controller: _scrollController,
                              shrinkWrap: true,
                              children: [
                                SizedBox(
                                  height: size.height * .2,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        AppConstant.kWidth(width: 10),
                                    shrinkWrap: true,
                                    itemCount: provider
                                        .jobDetailsModel!.jobimages!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child:
                                          provider.jobDetailsModel!.jobimages ==
                                                  null
                                              ? ImgFade.errorImage(
                                                  width: size.width * .6,
                                                  height: size.height * .1)
                                              : provider.jobDetailsModel!
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
                                provider.quoteList.isEmpty
                                    ? const SizedBox()
                                    : AppConstant.kheight(
                                        height: size.width * .02),
                                provider.quoteList.isEmpty
                                    ? const SizedBox()
                                    : TextWidget(
                                        data: "Job Quote Requests",
                                        style: TextStyle(
                                            color: AppColor.blackColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                AppConstant.kheight(height: size.width * .02),
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final quote = provider.quoteList[index];
                                      String status = quote.status!.toString();
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade300)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            titleTrader(
                                                context: context,
                                                index: index,
                                                profilePic:
                                                    quote.profilePic ?? "",
                                                name: quote.name ?? "",
                                                size: size,
                                                titleOne: "Trader",
                                                titleTwo: quote.name ?? "",
                                                isButton: false,
                                                traderId: quote.traderId == null
                                                    ? ""
                                                    : quote.traderId.toString(),
                                                jobQuoteID: quote.id == null
                                                    ? ""
                                                    : quote.id.toString()),
                                            titleTrader(
                                                context: context,
                                                index: index,
                                                profilePic:
                                                    quote.profilePic ?? "",
                                                name: quote.name ?? "",
                                                size: size,
                                                titleOne: "Quote Price",
                                                titleTwo:
                                                    quote.quotedPrice ?? "",
                                                isButton: false,
                                                traderId: quote.traderId == null
                                                    ? ""
                                                    : quote.traderId.toString(),
                                                jobQuoteID: quote.id == null
                                                    ? ""
                                                    : quote.id.toString()),
                                            titleTrader(
                                                context: context,
                                                index: index,
                                                profilePic:
                                                    quote.profilePic ?? "",
                                                name: quote.name ?? "",
                                                size: size,
                                                titleOne: "Quote Reason",
                                                titleTwo:
                                                    quote.quoteReason ?? "",
                                                isButton: false,
                                                traderId: quote.traderId == null
                                                    ? ""
                                                    : quote.traderId.toString(),
                                                jobQuoteID: quote.id == null
                                                    ? ""
                                                    : quote.id.toString()),
                                            titleTrader(
                                                context: context,
                                                index: index,
                                                profilePic:
                                                    quote.profilePic ?? "",
                                                name: quote.name ?? "",
                                                size: size,
                                                titleOne: "status",
                                                traderId: quote.traderId == null
                                                    ? ""
                                                    : quote.traderId.toString(),
                                                titleTwo: quote.status ?? "",
                                                isButton:
                                                    status.toLowerCase() ==
                                                            "requested"
                                                        ? true
                                                        : false,
                                                jobQuoteID: quote.id == null
                                                    ? ""
                                                    : quote.id.toString()),
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
                                                        height:
                                                            size.width * .01),
                                            quote.details == null
                                                ? SizedBox()
                                                : quote.details!.isEmpty
                                                    ? SizedBox()
                                                    : TextWidget(
                                                        data:
                                                            "Communication Details",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17),
                                                        overflow: TextOverflow
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
                                                        color:
                                                            Color(0XFFEEFFEC),
                                                        child: Column(
                                                          children: [
                                                            ListView.separated(
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              separatorBuilder: (context,
                                                                      sIndex) =>
                                                                  AppConstant
                                                                      .kheight(
                                                                          height:
                                                                              1),
                                                              shrinkWrap: true,
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
                                                                        details
                                                                            .createdAt!);
                                                                return subIndex >=
                                                                            2 &&
                                                                        quote.isExpanded ==
                                                                            false
                                                                    ? SizedBox()
                                                                    : Container(
                                                                        margin: subIndex ==
                                                                                0
                                                                            ? EdgeInsets.all(
                                                                                1)
                                                                            : EdgeInsets.only(
                                                                                left: 20,
                                                                                right: 10,
                                                                                bottom: 7),
                                                                        child:
                                                                            Card(
                                                                          color: subIndex == 0
                                                                              ? Color(0XFFEEFFEC)
                                                                              : null,
                                                                          elevation:
                                                                              0,
                                                                          child:
                                                                              Column(
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
                                                                    onTap: () {
                                                                      infoProvider
                                                                          .viewAllReply(
                                                                              index);
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: size.width *
                                                                              .048,
                                                                          vertical: quote.isExpanded!
                                                                              ? size.width * .02
                                                                              : 0),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          height:
                                                                              size.width * .05,
                                                                          width:
                                                                              size.width * .2,
                                                                          decoration:
                                                                              BoxDecoration(color: AppColor.green),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              FaIcon(
                                                                                FontAwesomeIcons.share,
                                                                                size: size.width * .037,
                                                                                color: AppColor.whiteColor,
                                                                              ),
                                                                              AppConstant.kWidth(width: size.width * .009),
                                                                              TextWidget(
                                                                                data: quote.isExpanded! ? "Hide" : "View all",
                                                                                style: TextStyle(color: AppColor.whiteColor),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                            AppConstant.kheight(
                                                                height:
                                                                    size.width *
                                                                        .02),

                                                            //textfield
                                                            quote.details ==
                                                                    null
                                                                ? SizedBox()
                                                                : quote.details!
                                                                        .isEmpty
                                                                    ? SizedBox()
                                                                    : Container(
                                                                        height: size.width *
                                                                            .086,
                                                                        decoration:
                                                                            BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                                        margin: EdgeInsetsDirectional.symmetric(
                                                                            horizontal:
                                                                                10),
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
                                                                height:
                                                                    size.width *
                                                                        .02),
                                                          ],
                                                        ),
                                                      )
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const Divider(),
                                    itemCount: provider.quoteList.length),
                                provider.isFetching &&
                                        provider.hasNext &&
                                        provider.quoteList.isNotEmpty
                                    ? SizedBox(
                                        height: 90,
                                        child: AppConstant
                                            .circularProgressIndicator())
                                    : SizedBox()
                              ],
                            ))
                          ],
                        ),
        );
      }),
    );
  }

  Widget titleTrader(
      {required Size size,
      required String profilePic,
      required String titleOne,
      required String titleTwo,
      required bool isButton,
      required String traderId,
      required String jobQuoteID,
      required String name,
      required int index,
      required BuildContext context}) {
    return Container(
      padding: EdgeInsets.only(
        left: size.width * .04,
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
                      width: size.width * .25,
                      child: TextWidget(
                        data: titleOne,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    AppConstant.kWidth(width: 1),
                    TextWidget(
                      data: ":",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    AppConstant.kWidth(width: size.width * .02),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(size.width * .01),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            isButton == false
                                ? TextWidget(
                                    data: titleTwo,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  )
                                : Expanded(
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            print("accept");
                                            AppConstant.overlayLoaderShow(
                                                context);
                                            await infoProvider
                                                .customerQuoteReqAction(
                                                    index: index,
                                                    jobQuoteID:
                                                        jobQuoteID.toString(),
                                                    status: "accept",
                                                    traderId: traderId,
                                                    jobId: widget.jobId
                                                        .toString());
                                            if (!mounted) return;
                                            AppConstant.overlayLoaderHide(
                                                context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(3),
                                            alignment: Alignment.center,
                                            width: size.width * .17,
                                            decoration: BoxDecoration(
                                                color: AppColor.green,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: TextWidget(
                                                data: "Accept",
                                                style: TextStyle(
                                                    color:
                                                        AppColor.whiteColor)),
                                          ),
                                        ),
                                        AppConstant.kWidth(
                                            width: size.width * .01),
                                        InkWell(
                                          onTap: () async {
                                            AppConstant.overlayLoaderShow(
                                                context);
                                            await infoProvider
                                                .customerQuoteReqAction(
                                                    index: index,
                                                    jobQuoteID:
                                                        jobQuoteID.toString(),
                                                    status: "reject",
                                                    traderId: traderId,
                                                    jobId: widget.jobId
                                                        .toString());
                                            if (!mounted) return;
                                            AppConstant.overlayLoaderHide(
                                                context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(3),
                                            alignment: Alignment.center,
                                            width: size.width * .17,
                                            decoration: BoxDecoration(
                                                color: AppColor.red,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: TextWidget(
                                                data: "Reject",
                                                style: TextStyle(
                                                    color:
                                                        AppColor.whiteColor)),
                                          ),
                                        ),
                                        AppConstant.kWidth(
                                            width: size.width * .01),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: ChatScreen(
                                                      name: name,
                                                      toUsertype: "trader",
                                                      profilePic: profilePic,
                                                      toUserId:
                                                          int.parse(traderId),
                                                    )));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(3),
                                            alignment: Alignment.center,
                                            width: size.width * .17,
                                            decoration: BoxDecoration(
                                                color: AppColor.blackColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: TextWidget(
                                              data: "Chat",
                                              style: TextStyle(
                                                  color: AppColor.whiteColor),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    )
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
