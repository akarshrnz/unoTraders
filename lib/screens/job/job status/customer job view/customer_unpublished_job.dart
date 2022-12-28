import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/screens/job/job%20status/customer%20job%20view/customer_live_job_card.dart';

import 'package:codecarrots_unotraders/services/helper/api_services_url.dart';
import 'package:codecarrots_unotraders/utils/color.dart';

import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class UnPublishedJob extends StatefulWidget {
  const UnPublishedJob({Key? key}) : super(key: key);

  @override
  _UnPublishedJobState createState() => _UnPublishedJobState();
}

class _UnPublishedJobState extends State<UnPublishedJob> {
  TextEditingController serachcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late JobProvider jobProvider;
  @override
  void initState() {
    jobProvider = Provider.of<JobProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      jobProvider.fetchJobList(
          endPoint: ApiServicesUrl.unpublishedJob, jobStatus: "Unpublished");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("un published job build");
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
          title: const Text(
            'unpublished Jobs',
            style: TextStyle(color: AppColor.blackColor),
          ),
          actions: [
            SearchBarAnimation(
              searchBoxWidth: size.width * .97,
              textEditingController: serachcontroller,
              isOriginalAnimation: true,
              enableKeyboardFocus: true,
              onFieldSubmitted: (_) {
                // ignore: avoid_print
                print("submitter");
                return null;
              },
              onExpansionComplete: () {
                debugPrint('do something just after searchbox is opened.');
              },
              onCollapseComplete: () {
                serachcontroller.clear();
                debugPrint('do something just after searchbox is closed.');
              },
              onPressButton: (isSearchBarOpens) {
                debugPrint(
                    'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
              },
              trailingWidget: const Icon(
                Icons.search,
                size: 30,
                color: AppColor.green,
              ),
              secondaryButtonWidget: const Icon(
                Icons.close,
                size: 20,
                color: AppColor.green,
              ),
              buttonWidget: const Icon(
                Icons.search,
                size: 30,
                color: AppColor.green,
              ),
            ),
          ],
        ),
        body: Consumer<JobProvider>(
          builder: (context, jProvider, child) {
            return jProvider.isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : jProvider.getjobslist.isEmpty &&
                        jProvider.errorMessage.isEmpty
                    ? const Center(
                        child: Text("No Data"),
                      )
                    : jProvider.errorMessage.isNotEmpty
                        ? const Center(
                            child: Text("Something Went Wrong"),
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
                                  endPoint: ApiServicesUrl.unpublishedJob,
                                  jobStatus: "Unpublished",
                                  isongoing: false,
                                ),
                              );
                            },
                          );
          },
        ));
  }
}
