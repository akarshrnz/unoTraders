import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/customer_live_job_card.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/components/job_card.dart';
import 'package:codecarrots_unotraders/screens/job/job_detail.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class CustomerOngoingjob extends StatefulWidget {
  const CustomerOngoingjob({Key? key}) : super(key: key);

  @override
  _CustomerOngoingjobState createState() => _CustomerOngoingjobState();
}

class _CustomerOngoingjobState extends State<CustomerOngoingjob> {
  TextEditingController serachcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late JobProvider jobProvider;
  @override
  void initState() {
    jobProvider = Provider.of<JobProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      jobProvider.fetchJobList(endPoint: Url.ongoingJob, jobStatus: "Ongoing");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("ongoing job build");
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
            data: 'Ongoing Jobs',
            style: TextStyle(color: AppColor.blackColor),
          ),
          // actions: [
          //   SearchBarAnimation(
          //     searchBoxWidth: size.width * .97,
          //     textEditingController: serachcontroller,
          //     isOriginalAnimation: true,
          //     enableKeyboardFocus: true,
          //     onFieldSubmitted: (_) {
          //       // ignore: avoid_print
          //       print("submitter");
          //       return null;
          //     },
          //     onExpansionComplete: () {
          //       debugPrint('do something just after searchbox is opened.');
          //     },
          //     onCollapseComplete: () {
          //       serachcontroller.clear();
          //       debugPrint('do something just after searchbox is closed.');
          //     },
          //     onPressButton: (isSearchBarOpens) {
          //       debugPrint(
          //           'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
          //     },
          //     trailingWidget: const Icon(
          //       Icons.search,
          //       size: 30,
          //       color: AppColor.green,
          //     ),
          //     secondaryButtonWidget: const Icon(
          //       Icons.close,
          //       size: 20,
          //       color: AppColor.green,
          //     ),
          //     buttonWidget: const Icon(
          //       Icons.search,
          //       size: 30,
          //       color: AppColor.green,
          //     ),
          //   ),
          //   // Padding(
          //   //   padding: const EdgeInsets.all(8.0),
          //   //   child: Image.asset(
          //   //     PngImages.search,
          //   //     width: MediaQuery.of(context).size.width * 0.06,
          //   //   ),
          //   // ),
          // ],
        ),
        body: Consumer<JobProvider>(
          builder: (context, jProvider, child) {
            return jProvider.isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : jProvider.getjobslist.isEmpty &&
                        jProvider.errorMessage.isEmpty
                    ? Center(
                        child: TextWidget(data: "No Data"),
                      )
                    : jProvider.errorMessage.isNotEmpty
                        ? Center(
                            child: TextWidget(data: "Something Went Wrong"),
                          )
                        : ListView.builder(
                            itemCount: jProvider.getjobslist.length,
                            itemBuilder: (context, index) {
                              print(index.toString());
                              return ChangeNotifierProvider.value(
                                value: jProvider.getjobslist[index],
                                child: const CustomerLiveJobCard(
                                  isSeekingQuote: true,
                                  isunPublished: true,
                                  endPoint: Url.ongoingJob,
                                  jobStatus: "Ongoing",
                                  isongoing: true,
                                ),
                              );
                            },
                          );
          },
        ));
  }
}
