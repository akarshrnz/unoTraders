import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/screens/job/job%20status/customer%20job%20view/customer_live_job_card.dart';
import 'package:codecarrots_unotraders/screens/job/job%20status/components/job_card.dart';
import 'package:codecarrots_unotraders/screens/job/job_detail.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/services/helper/api_services_url.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

import '../../../utils/color.dart';
import '../../../utils/png.dart';

class SeekingQuoteJob extends StatefulWidget {
  const SeekingQuoteJob({Key? key}) : super(key: key);

  @override
  _SeekingQuoteJobState createState() => _SeekingQuoteJobState();
}

class _SeekingQuoteJobState extends State<SeekingQuoteJob> {
  TextEditingController serachcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late JobProvider jobProvider;
  @override
  void initState() {
    jobProvider = Provider.of<JobProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      jobProvider.fetchJobList(
          endPoint: ApiServicesUrl.seekQuoteJob, jobStatus: "Seek Quote");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("buid");
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
            'Seeking Quote Jobs',
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
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Image.asset(
            //     PngImages.search,
            //     width: MediaQuery.of(context).size.width * 0.06,
            //   ),
            // ),
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
                                  isunPublished: false,
                                  endPoint: ApiServicesUrl.seekQuoteJob,
                                  jobStatus: "Seek Quote",
                                  isongoing: false,
                                ),
                              );
                            },
                          );
          },
        ));
  }
}



// import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
// import 'package:codecarrots_unotraders/provider/job_provider.dart';
// import 'package:codecarrots_unotraders/screens/job/job%20status/components/job_card.dart';
// import 'package:codecarrots_unotraders/screens/job/job_detail.dart';
// import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
// import 'package:codecarrots_unotraders/services/helper/api_services_url.dart';
// import 'package:codecarrots_unotraders/utils/constant.dart';
// import 'package:codecarrots_unotraders/utils/img_fade.dart';
// import 'package:flutter/material.dart';

// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:searchbar_animation/searchbar_animation.dart';

// import '../../../utils/color.dart';
// import '../../../utils/png.dart';

// class SeekingQuoteJob extends StatefulWidget {
//   const SeekingQuoteJob({Key? key}) : super(key: key);

//   @override
//   _LiveJobState createState() => _LiveJobState();
// }

// class _LiveJobState extends State<SeekingQuoteJob> {
//   TextEditingController serachcontroller = TextEditingController();

//   late JobProvider jobProvider;
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     jobProvider = Provider.of<JobProvider>(context, listen: false);
//     final size = MediaQuery.of(context).size;
//     print(size.width * .1);
//     return Scaffold(
//       appBar: AppBar(
//         bottomOpacity: 0.0,
//         elevation: 0.0,
//         backgroundColor: AppColor.whiteColor,
//         leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Image.asset(
//               PngImages.arrowBack,
//               width: MediaQuery.of(context).size.width * 0.06,
//             )),
//         centerTitle: true,
//         title: const Text(
//           'Seeking Quote',
//           style: TextStyle(color: AppColor.blackColor),
//         ),
//         actions: [
//           SearchBarAnimation(
//             searchBoxWidth: size.width * .97,
//             textEditingController: serachcontroller,
//             isOriginalAnimation: true,
//             enableKeyboardFocus: true,
//             onFieldSubmitted: (_) {
//               // ignore: avoid_print
//               print("submitter");
//               return null;
//             },
//             onExpansionComplete: () {
//               debugPrint('do something just after searchbox is opened.');
//             },
//             onCollapseComplete: () {
//               serachcontroller.clear();
//               debugPrint('do something just after searchbox is closed.');
//             },
//             onPressButton: (isSearchBarOpens) {
//               debugPrint(
//                   'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
//             },
//             trailingWidget: const Icon(
//               Icons.search,
//               size: 30,
//               color: AppColor.green,
//             ),
//             secondaryButtonWidget: const Icon(
//               Icons.close,
//               size: 20,
//               color: AppColor.green,
//             ),
//             buttonWidget: const Icon(
//               Icons.search,
//               size: 30,
//               color: AppColor.green,
//             ),
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<FetchJobModel>>(
//           future: jobProvider.fetchJob(
//               endPoint: ApiServicesUrl.seekQuoteJob, jobStatus: "Seek Quote"),
//           builder: (context, AsyncSnapshot<List<FetchJobModel>> snapshot) {
//             switch (snapshot.connectionState) {
//               case ConnectionState.waiting:
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               case ConnectionState.done:
//               default:
//                 if (snapshot.hasError) { return Center(child: Text(snapshot.error.toString()));
//                 } else if (snapshot.hasData) {
//                    if(snapshot.data!.isEmpty)return  const Center(child: Text("No data"));
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ChangeNotifierProvider.value(
//                         value: snapshot.data![index],
//                         child: const JobCard(
//                             isUnpublished: true, onlyMoreDetails: false),
//                       );
//                     },
//                   );
//                 } else {
//                   return const Center(child: Text("No data"));
//                 }
//             }
            
//           }),
//     );
//   }
// }
