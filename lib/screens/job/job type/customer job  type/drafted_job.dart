import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/draft_job_card.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../utils/color.dart';
import '../../../../utils/png.dart';

class SavedJob extends StatefulWidget {
  const SavedJob({Key? key}) : super(key: key);

  @override
  _SavedJobState createState() => _SavedJobState();
}

class _SavedJobState extends State<SavedJob> {
  TextEditingController serachcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late JobProvider jobProvider;
  @override
  void initState() {
    jobProvider = Provider.of<JobProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      jobProvider.fetchJobList(endPoint: Url.savedJob, jobStatus: "Saved");
      // jobProvider.fetchJobList(endPoint: Url.publishedJob, jobStatus: "");
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
          title: TextWidget(
            data: 'Draft Jobs',
            style: TextStyle(color: AppColor.blackColor),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            jobProvider.fetchJobList(
                endPoint: Url.savedJob, jobStatus: "Saved");
          },
          child: Consumer<JobProvider>(
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
                                  child: DraftJobCard(
                                    endPoint: Url.savedJob,
                                    index: index,
                                    jobStatus: "Saved",
                                  ),
                                );
                              },
                            );
            },
          ),
        ));
  }
}



// import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
// import 'package:codecarrots_unotraders/provider/job_provider.dart';
// import 'package:codecarrots_unotraders/screens/job/job%20type/components/job_card.dart';
// import 'package:codecarrots_unotraders/screens/job/job_detail.dart';
// import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
// import 'package:codecarrots_unotraders/services/helper/url.dart';
// import 'package:codecarrots_unotraders/utils/app_constant.dart';
// import 'package:codecarrots_unotraders/utils/img_fade.dart';
// import 'package:flutter/material.dart';

// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:searchbar_animation/searchbar_animation.dart';

// import '../../../../utils/color.dart';
// import '../../../../utils/png.dart';

// class SavedJob extends StatefulWidget {
//   const SavedJob({Key? key}) : super(key: key);

//   @override
//   _LiveJobState createState() => _LiveJobState();
// }

// class _LiveJobState extends State<SavedJob> {
//   TextEditingController serachcontroller = TextEditingController();

//   late JobProvider jobProvider;
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("draft");
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
//         title: const TextWidget(data:
//           'Draft Jobs',
//           style: TextStyle(color: AppColor.blackColor),
//         ),
//         // actions: [
//         //   SearchBarAnimation(
//         //     searchBoxWidth: size.width * .97,
//         //     textEditingController: serachcontroller,
//         //     isOriginalAnimation: true,
//         //     enableKeyboardFocus: true,
//         //     onFieldSubmitted: (_) {
//         //       // ignore: avoid_print
//         //       print("submitter");
//         //       return null;
//         //     },
//         //     onExpansionComplete: () {
//         //       debugPrint('do something just after searchbox is opened.');
//         //     },
//         //     onCollapseComplete: () {
//         //       serachcontroller.clear();
//         //       debugPrint('do something just after searchbox is closed.');
//         //     },
//         //     onPressButton: (isSearchBarOpens) {
//         //       debugPrint(
//         //           'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
//         //     },
//         //     trailingWidget: const Icon(
//         //       Icons.search,
//         //       size: 30,
//         //       color: AppColor.green,
//         //     ),
//         //     secondaryButtonWidget: const Icon(
//         //       Icons.close,
//         //       size: 20,
//         //       color: AppColor.green,
//         //     ),
//         //     buttonWidget: const Icon(
//         //       Icons.search,
//         //       size: 30,
//         //       color: AppColor.green,
//         //     ),
//         //   ),
//         // ],
//       ),
//       body: FutureBuilder<List<FetchJobModel>>(
//           future:
//               jobProvider.fetchJob(endPoint: Url.savedJob, jobStatus: "Saved"),
//           builder: (context, AsyncSnapshot<List<FetchJobModel>> snapshot) {
//             switch (snapshot.connectionState) {
//               case ConnectionState.waiting:
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               case ConnectionState.done:
//               default:
//                 if (snapshot.hasError) {
//                   return Center(child: TextWidget(data:snapshot.error.toString()));
//                 } else if (snapshot.hasData) {
//                   if (snapshot.data!.isEmpty) {
//                     return const Center(child: TextWidget(data:"No data"));
//                   }
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ChangeNotifierProvider.value(
//                         value: snapshot.data![index],
//                         child: const JobCard(
//                           isUnpublished: true,
//                           isDelete: true,
//                           isEdit: true,
//                         ),
//                       );
//                     },
//                   );
//                 } else {
//                   return const Center(child: TextWidget(data:"No data"));
//                 }
//             }
//           }),
//     );
//   }
// }
