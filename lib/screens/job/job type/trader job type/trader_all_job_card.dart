import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/trader%20job%20type/quote_request_popup.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/trader%20job%20type/trader_more_details.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TraderJobViewCard extends StatelessWidget {
  const TraderJobViewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final jobModel = Provider.of<FetchJobModel>(context);
    final size = MediaQuery.of(context).size;
    DateTime date = DateTime.parse(jobModel.createdAt!);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TraderJobMoreDetail(
                                            jobId: jobModel.id.toString(),
                                            isAlljobs: true,
                                          ),
                                        ));
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           TraderAllJobMoreDetail(
                                    //         jobDetails: jobModel,
                                    //         isAlljobs: true,
                                    //       ),
                                    //     ));
                                  },
                                  radius: 20,
                                ),
                              ),
                              AppConstant.kWidth(width: 10),
                              SizedBox(
                                height: size.height * .029,
                                width: size.width * .26,
                                child: DefaultButton(
                                  text: "Quote job",
                                  onPress: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => QuoteRequestPopUp(
                                        callMessage: false,
                                        jobId: jobModel.id.toString(),
                                        jobTitle: jobModel.title ?? "",
                                        userid: jobModel.userId.toString(),
                                      ),
                                    );
                                  },
                                  radius: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppConstant.kheight(height: 10),
                        SizedBox(
                          width: size.width * .57,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * .029,
                                width: size.width * .35,
                                child: DefaultButton(
                                  backgroundColor: AppColor.blackColor,
                                  text: "Request More Details",
                                  onPress: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => QuoteRequestPopUp(
                                        callMessage: false,
                                        jobTitle: jobModel.title ?? "",
                                        userid: jobModel.userId.toString(),
                                        jobId: jobModel.id.toString(),
                                        isRequestMoreDetails: true,
                                      ),
                                    );
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
