import 'package:codecarrots_unotraders/model/get_accept_reject_model.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/customer_job_more_details.dart';
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

class CustomerJobCard extends StatelessWidget {
  final bool? isUnpublished;
  final bool? onlyMoreDetails;
  const CustomerJobCard({super.key, this.isUnpublished, this.onlyMoreDetails});

  @override
  Widget build(BuildContext context) {
    final jobModel = Provider.of<GetAcceptRejectModel>(context);
    print("job id");
    print(jobModel.jobId);
    print(jobModel);
    final size = MediaQuery.of(context).size;
    DateTime date = DateTime.parse(jobModel.createdAt!);
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
                                    // for accept/reject/ongoing => onlyMoreDetails == true

                                    if (onlyMoreDetails == true) {
                                      print("only more details");

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CustomerJobMoreDetails(
                                                    jobId:
                                                        jobModel.id.toString()),
                                          ));
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           CustomerMoreDetails(
                                      //               jobDetails: jobModel),
                                      //     ));
                                    } else {
                                      // Navigator.push(context, MaterialPageRoute(
                                      //   builder: (context) {
                                      //     print("else part");
                                      //     return JobDetail(
                                      //         jobDetails: jobModel);
                                      //   },
                                      // ));
                                    }
                                  },
                                  radius: 20,
                                ),
                              ),
                              AppConstant.kWidth(width: 10),
                              onlyMoreDetails == true
                                  ? const SizedBox()
                                  : isUnpublished == true
                                      ? SizedBox(
                                          height: size.height * .029,
                                          width: size.width * .26,
                                          child: DefaultButton(
                                            text: "Edit",
                                            onPress: () {},
                                            radius: 20,
                                          ),
                                        )
                                      : SizedBox(
                                          height: size.height * .029,
                                          width: size.width * .26,
                                          child: DefaultButton(
                                            text: "Unpublish",
                                            onPress: () {},
                                            radius: 20,
                                          ),
                                        ),
                            ],
                          ),
                        ),
                        AppConstant.kheight(
                            height: onlyMoreDetails == true ? 0 : 10),
                        onlyMoreDetails == true
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
                                        onPress: () {},
                                        radius: 20,
                                      ),
                                    ),
                                    AppConstant.kWidth(
                                        width:
                                            onlyMoreDetails == true ? 0 : 10),
                                    onlyMoreDetails == true
                                        ? const SizedBox()
                                        : isUnpublished == true
                                            ? SizedBox(
                                                height: size.height * .029,
                                                width: size.width * .26,
                                                child: DefaultButton(
                                                  text: "Post Job",
                                                  onPress: () {},
                                                  radius: 20,
                                                ),
                                              )
                                            : SizedBox(
                                                height: size.height * .029,
                                                width: size.width * .26,
                                                child: DefaultButton(
                                                  text: "Completed",
                                                  onPress: () {},
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
