import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/screens/job/customer%20job%20screen/post_job.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/seek%20quote/customer_seek_quote_result.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/customer_job_more_details.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CustomerLiveJobCard extends StatefulWidget {
  final bool? isPostedjob;
  final bool isongoing;
  final bool isSeekingQuote;
  final bool isunPublished;
  final String jobStatus;
  final String endPoint;
  const CustomerLiveJobCard({
    this.isPostedjob,
    super.key,
    required this.endPoint,
    required this.jobStatus,
    required this.isSeekingQuote,
    required this.isunPublished,
    required this.isongoing,
  });

  @override
  State<CustomerLiveJobCard> createState() => _CustomerLiveJobCardState();
}

class _CustomerLiveJobCardState extends State<CustomerLiveJobCard> {
  @override
  Widget build(BuildContext context) {
    final jobModel = Provider.of<FetchJobModel>(context);
    final jobProvider = Provider.of<JobProvider>(context, listen: true);
    final size = MediaQuery.of(context).size;
    DateTime date = DateTime.parse(jobModel.createdAt ?? "");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width,

        //             width: size.width * 0.3,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                  borderRadius: BorderRadius.circular(10),
                  child: jobModel.jobimages!.isEmpty
                      ? ImgFade.errorImage(
                          height: size.height * .1, width: size.width * .2)
                      : ImgFade.fadeImage(
                          height: size.height * .1,
                          width: size.width * .2,
                          url: jobModel.jobimages![0]),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.width * .02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * .57,
                          child: TextWidget(
                            data: jobModel.title.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 15,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        AppConstant.kheight(height: size.width * .02),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * .02),
                                        child: Image.asset(PngImages.dollar),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * .01,
                                            right: size.width * .02),
                                        child: TextWidget(
                                          data: jobModel.budget.toString(),
                                          style: const TextStyle(
                                            color: AppColor.whiteColor,
                                            fontWeight: FontWeight.w500,
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
                              padding: EdgeInsets.only(left: size.width * .02),
                              child: TextWidget(
                                data:
                                    "Posted:  ${date.day} ${DateFormat.MMM().format(date)} ${date.year}",
                                style: TextStyle(
                                  color: AppColor.secondaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.width * 0.028,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    AppConstant.kheight(height: size.width * .02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * .57,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * .029,
                                width: size.width * .26,
                                child: DefaultButton(
                                  text: "More Details",
                                  onPress: () {
                                    // ignore: avoid_print
                                    print("Pressed");
                                    print(jobModel.id.toString());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CustomerJobMoreDetails(
                                            jobId: jobModel.id.toString(),
                                            // jobDetails: jobModel,
                                            // endPoint: widget.endPoint,
                                            // jobStatus: widget.jobStatus
                                          ),
                                        ));
                                  },
                                  radius: 20,
                                ),
                              ),
                              AppConstant.kWidth(width: 10),
                              widget.isongoing == true
                                  ? SizedBox(
                                      height: size.height * .029,
                                      width: size.width * .26,
                                      child: DefaultButton(
                                        text: "Complete",
                                        onPress: () async {
                                          print("Complete 1");
                                          print(jobModel.id.toString());
                                          print(jobModel.traderId.toString());
                                          // await jobProvider.completeJobStatus(
                                          //     jobEndPoint: endPoint,
                                          //     jobStatus: jobStatus,
                                          //     jobId: jobModel.id.toString(),
                                          //     endPoints: Url.completedEndpoints,
                                          //     status: 'Completed');
                                          bool res = await jobProvider
                                              .completeJobStatus(
                                                  traderId: jobModel.traderId
                                                      .toString(),
                                                  jobEndPoint: widget.endPoint,
                                                  jobStatus: widget.jobStatus,
                                                  jobId: jobModel.id.toString(),
                                                  endPoints:
                                                      Url.completedEndpoints,
                                                  status: 'Completed',
                                                  ctx: context);
                                          // if (true == true) {
                                          //   print("Complete ddd");
                                          //   // if (!mounted) return;
                                          //   print("Complete after");
                                          //   // ignore: use_build_context_synchronously
                                          //   Navigator.push(
                                          //       context,
                                          //       PageTransition(
                                          //           type:
                                          //               PageTransitionType.fade,
                                          //           child: CustomerReviewScreen(
                                          //             jobId: jobModel.id
                                          //                 .toString(),
                                          //             traderId: jobModel
                                          //                 .traderId
                                          //                 .toString(),
                                          //             callCompleted: true,
                                          //           )));
                                          // }
                                        },
                                        radius: 20,
                                      ),
                                    )
                                  : widget.isunPublished == true
                                      ? SizedBox(
                                          height: size.height * .029,
                                          width: size.width * .26,
                                          child: DefaultButton(
                                            text: "Post Job",
                                            onPress: () async {
                                              await jobProvider.updateJobStatus(
                                                  jobId: jobModel.id.toString(),
                                                  endPoints: 'postjob',
                                                  status: 'Unpublished',
                                                  jobEndPoint: widget.endPoint,
                                                  jobStatus: widget.jobStatus);
                                            },
                                            radius: 20,
                                          ),
                                        )
                                      : SizedBox(
                                          height: size.height * .029,
                                          width: size.width * .26,
                                          child: DefaultButton(
                                            text: "Unpublish",
                                            onPress: () async {
                                              await jobProvider.updateJobStatus(
                                                  jobId: jobModel.id.toString(),
                                                  endPoints:
                                                      Url.unPublishEndpoints,
                                                  jobEndPoint: widget.endPoint,
                                                  jobStatus: widget.jobStatus,
                                                  status: 'Unpublish');
                                            },
                                            radius: 20,
                                          ),
                                        ),
                            ],
                          ),
                        ),
                        AppConstant.kheight(height: 10),
                        widget.isongoing == true
                            ? const SizedBox()
                            : SizedBox(
                                width: size.width * .57,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: size.height * .029,
                                      width: size.width * .26,
                                      child: DefaultButton(
                                        text: "Seek Quote",
                                        onPress: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: QuoteResults(
                                                    jobId:
                                                        jobModel.id.toString(),
                                                  )));
                                        },
                                        radius: 20,
                                      ),
                                    ),
                                    AppConstant.kWidth(width: 10),

                                    // for seeking quote page change complete button not needed

                                    widget.isongoing == true
                                        ? const SizedBox()
                                        : widget.isunPublished == true
                                            ? SizedBox(
                                                height: size.height * .029,
                                                width: size.width * .26,
                                                child: DefaultButton(
                                                  text: "Edit",
                                                  onPress: () async {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    PostJob(
                                                                      isUpdatejob:
                                                                          true,
                                                                      jobId: jobModel
                                                                          .id
                                                                          .toString(),
                                                                    )));
                                                    // await jobProvider
                                                    //     .updateJobStatus(
                                                    //         jobId: jobModel.id
                                                    //             .toString(),
                                                    //         endPoints:
                                                    //             ApiServicesUrl
                                                    //                 .completedEndpoints,
                                                    //         jobEndPoint:
                                                    //             endPoint,
                                                    //         jobStatus:
                                                    //             jobStatus,
                                                    //         status:
                                                    //             'published');
                                                  },
                                                  radius: 20,
                                                ),
                                              )
                                            : widget.isSeekingQuote == true
                                                ? SizedBox(
                                                    height: size.height * .029,
                                                    width: size.width * .26,
                                                    child: DefaultButton(
                                                      text: "Post Job",
                                                      onPress: () async {
                                                        //         await jobProvider.updateJobStatus(
                                                        // jobId: jobModel.id.toString(),
                                                        // endPoints: 'postjob',
                                                        // status: '',
                                                        // jobEndPoint: widget.endPoint,
                                                        // jobStatus: widget.jobStatus);
                                                        await jobProvider
                                                            .updateJobStatus(
                                                                jobId: jobModel
                                                                    .id
                                                                    .toString(),
                                                                endPoints: Url
                                                                    .postJobEndpoints,
                                                                jobEndPoint:
                                                                    widget
                                                                        .endPoint,
                                                                jobStatus: widget
                                                                    .jobStatus,
                                                                status:
                                                                    'published');
                                                      },
                                                      radius: 20,
                                                    ),
                                                  )
                                                : widget.isPostedjob == true
                                                    ? SizedBox()
                                                    : SizedBox(
                                                        height:
                                                            size.height * .029,
                                                        width: size.width * .26,
                                                        child: DefaultButton(
                                                          text: "Completed",
                                                          onPress: () async {
                                                            bool res = await jobProvider.completeJobStatus(
                                                                traderId: jobModel
                                                                    .traderId
                                                                    .toString(),
                                                                ctx: context,
                                                                jobEndPoint:
                                                                    widget
                                                                        .endPoint,
                                                                jobStatus: widget
                                                                    .jobStatus,
                                                                jobId: jobModel
                                                                    .id
                                                                    .toString(),
                                                                endPoints: Url
                                                                    .completedEndpoints,
                                                                status:
                                                                    'Completed');
                                                            // if (res == true) {
                                                            //   if (!mounted) return;
                                                            //   Navigator.push(
                                                            //       context,
                                                            //       PageTransition(
                                                            //           type:
                                                            //               PageTransitionType
                                                            //                   .fade,
                                                            //           child:
                                                            //               CustomerReviewScreen(
                                                            //             callCompleted:
                                                            //                 true,
                                                            //             jobId: jobModel
                                                            //                 .id
                                                            //                 .toString(),
                                                            //             traderId: jobModel
                                                            //                 .traderId
                                                            //                 .toString(),
                                                            //           )));
                                                            // }
                                                          },
                                                          radius: 20,
                                                        ),
                                                      ),
                                  ],
                                ),
                              )
                      ],
                    ),
                    AppConstant.kheight(height: 10)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
