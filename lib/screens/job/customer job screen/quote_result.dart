import 'package:codecarrots_unotraders/model/customer_seek_quote_model.dart';
import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/router_class.dart';
import 'package:codecarrots_unotraders/screens/profile/traders/trader_profile_visit.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/services/helper/api_services_url.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class QuoteResults extends StatefulWidget {
  final String jobId;
  const QuoteResults({super.key, required this.jobId});

  @override
  State<QuoteResults> createState() => _QuoteResultsState();
}

class _QuoteResultsState extends State<QuoteResults> {
  late JobProvider jobProvider;

  @override
  Widget build(BuildContext context) {
    jobProvider = Provider.of<JobProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    print(ApiServicesUrl.id);
    return Scaffold(
      appBar: AppBarWidget(
        appBarTitle: "Traders",
      ),
      body: Column(
        children: [
          Flexible(
            child: FutureBuilder<List<CustomerSeekQuoteModel>>(
                future: jobProvider.fetchQuote(jobId: widget.jobId),
                builder: (context,
                    AsyncSnapshot<List<CustomerSeekQuoteModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    } else if (snapshot.hasData) {
                      return snapshot.data!.isEmpty
                          ? const Center(
                              child: Text("No Traders"),
                            )
                          : ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                CustomerSeekQuoteModel data =
                                    snapshot.data![index];
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * .02,
                                      vertical: size.width * .02),
                                  width: size.width,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              child: TraderProfileVisit(
                                                category: data.mainCategory
                                                    .toString(),
                                                id: data.id.toString(),
                                              )));
                                    },
                                    child: Card(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    size.width * .02),
                                                child: CircleAvatar(
                                                  radius: size.width * .09,
                                                  backgroundColor:
                                                      AppColor.green,
                                                  child: CircleAvatar(
                                                    radius: size.width * .08,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      data.profilePic!,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: size.width * .03,
                                                      bottom: size.width * .03),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      title(
                                                          text: data.name!,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      Row(
                                                        children: [
                                                          title(
                                                              text:
                                                                  data.rating!,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              maxLines: 1),
                                                          Constant.kWidth(
                                                              width:
                                                                  size.width *
                                                                      .01),
                                                          Expanded(
                                                              child: Container(
                                                            child: title(
                                                                text: "reviews",
                                                                color: AppColor
                                                                    .green,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ))
                                                        ],
                                                      ),
                                                      title(
                                                          text: data
                                                              .completedWorks!,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.width * .02),
                                            child: title(
                                                text: 'Description missing ',
                                                maxLines: 2,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: size.width * .02,
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: size.width * .02),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    size.width *
                                                                        .03),
                                                        color: Colors.green,
                                                      ),
                                                      height: size.width * .06,
                                                      child: const Text(
                                                        "Message",
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .whiteColor),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  width: size.width * .02,
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    size.width *
                                                                        .03),
                                                        color: Colors.green,
                                                      ),
                                                      height: size.width * .06,
                                                      child: const Text(
                                                        "Call",
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .whiteColor),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  width: size.width * .02,
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    size.width *
                                                                        .03),
                                                        color: Colors.black,
                                                      ),
                                                      height: size.width * .06,
                                                      child: const Text(
                                                        "Get a quote",
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .whiteColor),
                                                      ),
                                                    )),
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
                    } else {
                      return const Center(
                          child: Text("Document does not exist"));
                    }
                  } else {
                    return Constant.circularProgressIndicator();
                  }
                }),
          )
        ],
      ),
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
      label: Text(label),
      style: ElevatedButton.styleFrom(backgroundColor: AppColor.blackColor),
    );
  }

  Widget title(
      {required String text,
      double? fontSize,
      FontWeight? fontWeight,
      int? maxLines,
      Color? color}) {
    return Text(
      text,
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
