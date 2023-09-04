import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/customer_job_more_details.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
// ignore: unused_import
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class JobClarificationRequest extends StatefulWidget {
  const JobClarificationRequest({super.key});

  @override
  State<JobClarificationRequest> createState() =>
      _JobClarificationRequestState();
}

class _JobClarificationRequestState extends State<JobClarificationRequest> {
  late JobProvider jobProvider;
  @override
  void initState() {
    jobProvider = Provider.of<JobProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      jobProvider.fetchJobClarification();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            data: 'Job Clarification Request',
            style: TextStyle(color: AppColor.blackColor),
          ),
        ),
        body: Consumer<JobProvider>(
          builder: (context, jProvider, child) {
            return jProvider.isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : jProvider.jobClarificationList.isEmpty &&
                        jProvider.errorMessage.isEmpty
                    ? Center(
                        child: TextWidget(data: "No Data"),
                      )
                    : jProvider.errorMessage.isNotEmpty
                        ? Center(
                            child: TextWidget(data: "Something Went Wrong"),
                          )
                        : ListView.builder(
                            itemCount: jProvider.jobClarificationList.length,
                            itemBuilder: (context, index) {
                              final jobModel =
                                  jProvider.jobClarificationList[index];
                              DateTime date =
                                  DateTime.parse(jobModel.createdAt ?? "");
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  clipBehavior: Clip.antiAlias,
                                  shadowColor: AppColor.blackColor,
                                  elevation: 2,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * .03,
                                            top: size.width * .03,
                                            bottom: size.width * .03,
                                            right: size.width * .03),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: jobModel.jobimage == null
                                              ? ImgFade.errorImage(
                                                  height: size.height * .1,
                                                  width: size.width * .2)
                                              : jobModel.jobimage!.isEmpty
                                                  ? ImgFade.errorImage(
                                                      height: size.height * .1,
                                                      width: size.width * .2)
                                                  : ImgFade.fadeImage(
                                                      height: size.height * .1,
                                                      width: size.width * .2,
                                                      url: jobModel.jobimage!),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: size.width * .02),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: size.width * .57,
                                                      child: TextWidget(
                                                        data: jobModel.title
                                                            .toString(),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color: AppColor
                                                                .blackColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    AppConstant.kheight(
                                                        height:
                                                            size.width * .02),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .orangeAccent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(1.0),
                                                            child: Center(
                                                              child: Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: size.width *
                                                                            .02),
                                                                    child: Image.asset(
                                                                        PngImages
                                                                            .dollar),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: size.width *
                                                                            .01,
                                                                        right: size.width *
                                                                            .02),
                                                                    child:
                                                                        TextWidget(
                                                                      data: jobModel
                                                                          .budget
                                                                          .toString(),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: AppColor
                                                                            .whiteColor,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          // 'Posted: ${ snapshot.data![index].createdAt}',
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left:
                                                                      size.width *
                                                                          .02),
                                                          child: TextWidget(
                                                            data:
                                                                "Posted:  ${date.day} ${DateFormat.MMM().format(date)} ${date.year}",
                                                            style: TextStyle(
                                                              color: AppColor
                                                                  .secondaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  size.width *
                                                                      0.028,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                AppConstant.kheight(
                                                    height: size.width * .02),
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: size.width * .57,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height:
                                                                  size.height *
                                                                      .029,
                                                              width:
                                                                  size.width *
                                                                      .26,
                                                              child:
                                                                  DefaultButton(
                                                                text:
                                                                    "More Details",
                                                                onPress: () {
                                                                  // ignore: avoid_print
                                                                  print(
                                                                      "Pressed");
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                CustomerJobMoreDetails(
                                                                          jobId: jobModel
                                                                              .id
                                                                              .toString(),
                                                                          // jobDetails: jobModel,
                                                                          // endPoint: widget.endPoint,
                                                                          // jobStatus: widget.jobStatus
                                                                        ),
                                                                      ));
                                                                },
                                                                radius: 20,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      AppConstant.kheight(
                                                          height: 10),
                                                    ])
                                              ]))
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
          },
        ));
  }
}
