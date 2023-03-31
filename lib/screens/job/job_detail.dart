import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:codecarrots_unotraders/utils/png.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class JobDetail extends StatelessWidget {
  final FetchJobModel jobDetails;
  const JobDetail({super.key, required this.jobDetails});

  @override
  Widget build(BuildContext context) {
    print("job id");
    print(jobDetails.id);
    final size = MediaQuery.of(context).size;
    DateTime date = DateTime.parse(jobDetails.createdAt!);
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
      body: Padding(
        padding: EdgeInsets.all(size.width * .03),
        child: Column(
          children: [
            Flexible(
                child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: size.height * .2,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        AppConstant.kWidth(width: 10),
                    shrinkWrap: true,
                    itemCount: jobDetails.jobimages!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: jobDetails.jobimages!.isEmpty
                          ? ImgFade.errorImage(
                              width: size.width * .6, height: size.height * .1)
                          : ImgFade.fadeImage(
                              height: size.height * .1,
                              width: size.width * .6,
                              url: jobDetails.jobimages![index]),
                    ),
                  ),
                ),
                AppConstant.kheight(height: size.width * .02),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.width * .02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * .57,
                            child: TextWidget(
                              data: jobDetails.title.toString(),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          AppConstant.kheight(height: size.width * .02),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: size.height * .04,
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
                                            data: jobDetails.budget.toString(),
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
                              AppConstant.kWidth(width: size.width * .01),
                              const Icon(
                                Icons.alarm,
                                color: AppColor.primaryColor,
                              ),
                              TextWidget(
                                data:
                                    "Posted:  ${date.day} ${DateFormat.MMM().format(date)} ${date.year}",
                                style: TextStyle(
                                  color: AppColor.secondaryColor,
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
                TextWidget(
                  data: "Job Quote Requests",
                  style: TextStyle(
                      color: AppColor.blackColor, fontWeight: FontWeight.bold),
                ),
                AppConstant.kheight(height: size.width * .02),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
