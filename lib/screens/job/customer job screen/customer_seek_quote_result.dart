import 'package:codecarrots_unotraders/model/customer_seek_quote_model.dart';
import 'package:codecarrots_unotraders/model/quote/get_quote_model.dart';
import 'package:codecarrots_unotraders/provider/current_user_provider.dart';
import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/router_class.dart';
import 'package:codecarrots_unotraders/screens/Message%20Section/chat_screen.dart';
import 'package:codecarrots_unotraders/screens/Profile/traders/trader_profile_visit.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/services/job_services.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class QuoteResults extends StatefulWidget {
  final String jobId;

  const QuoteResults({
    super.key,
    required this.jobId,
  });

  @override
  State<QuoteResults> createState() => _QuoteResultsState();
}

class _QuoteResultsState extends State<QuoteResults> {
  late JobProvider jobProvider;
  @override
  void initState() {
    jobProvider = Provider.of<JobProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      jobProvider.fetchQuote(jobId: widget.jobId);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(widget.jobId);
    return Scaffold(
      appBar: AppBarWidget(
        appBarTitle: "Traders",
      ),
      body: Consumer<JobProvider>(builder: (BuildContext context, provider, _) {
        return provider.isSeekingQuote
            ? AppConstant.circularProgressIndicator()
            : provider.seekQuoteError.isNotEmpty
                ? Center(
                    child: TextWidget(data: "No Traders"),
                  )
                : provider.getQuoteList.isEmpty
                    ? Center(
                        child: TextWidget(data: "No Traders"),
                      )
                    : Column(
                        children: [
                          Flexible(
                              child: bodyWidget(provider.getQuoteList, size))
                        ],
                      );
      }),
    );
  }

  ListView bodyWidget(List<CustomerSeekQuoteModel> getQuoteList, Size size) {
    return ListView.builder(
      itemCount: getQuoteList.length,
      itemBuilder: (context, index) {
        CustomerSeekQuoteModel data = getQuoteList[index];
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * .02, vertical: size.width * .02),
          width: size.width,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: TraderProfileVisit(
                        category: data.mainCategory.toString(),
                        id: data.id.toString(),
                      )));
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(size.width * .02),
                        child: CircleAvatar(
                          radius: size.width * .07,
                          backgroundColor: AppColor.green,
                          child: CircleAvatar(
                            backgroundColor: AppColor.whiteColor,
                            radius: size.width * .06,
                            backgroundImage: NetworkImage(
                              data.profilePic!,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: size.width * .03, bottom: size.width * .03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title(
                                  text: data.name!,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              Row(
                                children: [
                                  title(
                                      text: data.rating!,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      maxLines: 1),
                                  AppConstant.kWidth(width: size.width * .01),
                                  Expanded(
                                      child: Container(
                                    child: title(
                                        text: "reviews",
                                        color: AppColor.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ))
                                ],
                              ),
                              title(
                                  text: data.completedWorks!,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .02),
                    child: title(
                        text: 'Description testing  ',
                        maxLines: 2,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: size.width * .02,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * .02),
                    child: Row(
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
                                  borderRadius:
                                      BorderRadius.circular(size.width * .03),
                                  color: Colors.green,
                                ),
                                height: size.width * .06,
                                child: TextWidget(
                                  data: "Message",
                                  style: TextStyle(color: AppColor.whiteColor),
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
                                if (data.mobile != null &&
                                    data.countryCode != null) {
                                  if (data.mobile!.isNotEmpty &&
                                      data.countryCode!.isNotEmpty) {
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
                                  borderRadius:
                                      BorderRadius.circular(size.width * .03),
                                  color: Colors.green,
                                ),
                                height: size.width * .06,
                                child: TextWidget(
                                  data: "Call",
                                  style: TextStyle(color: AppColor.whiteColor),
                                ),
                              ),
                            )),
                        SizedBox(
                          width: size.width * .02,
                        ),
                        Expanded(
                            flex: 1,
                            child: Consumer<CurrentUserProvider>(
                                builder: (context, currentUserProvider, _) {
                              return InkWell(
                                onTap: () async {
                                  final sharedPrefs =
                                      await SharedPreferences.getInstance();
                                  String id = sharedPrefs.getString('id')!;
                                  String userType =
                                      sharedPrefs.getString('userType')!;
                                  String userName =
                                      sharedPrefs.getString('userName')!;
                                  GetQuoteModel getQuote = GetQuoteModel(
                                      jobId: int.parse(
                                        widget.jobId,
                                      ),
                                      name: userName,
                                      traderId: data.id,
                                      userId: int.parse(id),
                                      userType: userType);
                                  print(getQuote.toJson());
                                  await JobServices.customerGetQuote(
                                      getQuote: getQuote);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(size.width * .03),
                                    color: Colors.black,
                                  ),
                                  height: size.width * .06,
                                  child: TextWidget(
                                    data: "Get a quote",
                                    style:
                                        TextStyle(color: AppColor.whiteColor),
                                  ),
                                ),
                              );
                            })),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.width * .02,
                  ),

                  // Container(
                  //   height: size.width * .1,
                  //   color: AppColor.blackColor,
                  //   child: Row(
                  //     mainAxisAlignment:
                  //         MainAxisAlignment.end,
                  //     children: [
                  //       bottomButton(
                  //         icon: Icons.chat,
                  //         label: "Message",
                  //         onPressed: () {
                  //           // ignore: avoid_print
                  //           print("pressed");
                  //         },
                  //       ),
                  //       verticaldivider(size),
                  //       bottomButton(
                  //         icon: Icons.phone,
                  //         label: "Phone",
                  //         onPressed: () {
                  //           // ignore: avoid_print
                  //           print("pressed");
                  //         },
                  //       ),
                  //       verticaldivider(size),
                  //       bottomButton(
                  //         icon: Icons.request_quote,
                  //         label: "Get a Quote",
                  //         onPressed: () {
                  //           // ignore: avoid_print
                  //           print("pressed");
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  SizedBox verticaldivider(Size size) {
    return SizedBox(
        height: size.width * .07,
        child: const VerticalDivider(
          color: AppColor.whiteColor,
          width: 2,
        ));
  }

  ElevatedButton bottomButton(
      {required IconData icon,
      required String label,
      required Function() onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppColor.green,
      ),
      label: TextWidget(data: label),
      style: ElevatedButton.styleFrom(backgroundColor: AppColor.blackColor),
    );
  }

  Widget title(
      {required String text,
      double? fontSize,
      FontWeight? fontWeight,
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
}
