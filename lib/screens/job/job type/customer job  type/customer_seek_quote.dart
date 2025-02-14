// import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
// import 'package:codecarrots_unotraders/provider/job_provider.dart';
// import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/customer_live_job_card.dart';
// import 'package:codecarrots_unotraders/screens/job/job%20type/components/job_card.dart';
// import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/draft_job_card.dart';
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

// class CustomerSeekQuote extends StatefulWidget {
//   const CustomerSeekQuote({Key? key}) : super(key: key);

//   @override
//   _SavedJobState createState() => _SavedJobState();
// }

// class _SavedJobState extends State<CustomerSeekQuote> {
//   TextEditingController serachcontroller = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   late JobProvider jobProvider;
//   @override
//   void initState() {
//     jobProvider = Provider.of<JobProvider>(context, listen: false);
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       jobProvider.fetchJobList(
//           endPoint: Url.seekQuoteJob, jobStatus: "Seek Quote");
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     print("buid");
//     return Scaffold(
//         appBar: AppBar(
//           bottomOpacity: 0.0,
//           elevation: 0.0,
//           backgroundColor: AppColor.whiteColor,
//           leading: GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Image.asset(
//                 PngImages.arrowBack,
//                 width: MediaQuery.of(context).size.width * 0.06,
//               )),
//           centerTitle: true,
//           title: const Text(
//             'Draft Jobs',
//             style: TextStyle(color: AppColor.blackColor),
//           ),
//         ),
//         body: RefreshIndicator(
//           onRefresh: () async {
//             jobProvider.fetchJobList(
//                 endPoint: Url.savedJob, jobStatus: "Saved");
//           },
//           child: Consumer<JobProvider>(
//             builder: (context, jProvider, child) {
//               return jProvider.isLoading == true
//                   ? const Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : jProvider.getjobslist.isEmpty &&
//                           jProvider.errorMessage.isEmpty
//                       ? const Center(
//                           child: Text("No Data"),
//                         )
//                       : jProvider.errorMessage.isNotEmpty
//                           ? const Center(
//                               child: Text("Something Went Wrong"),
//                             )
//                           : ListView.builder(
//                               itemCount: jProvider.getjobslist.length,
//                               itemBuilder: (context, index) {
//                                 print(index.toString());
//                                 return ChangeNotifierProvider.value(
//                                   value: jProvider.getjobslist[index],
//                                   child: const DraftJobCard(
//                                     endPoint: Url.seekQuoteJob,
//                                     jobStatus: "Seek Quote",
//                                   ),
//                                 );
//                               },
//                             );
//             },
//           ),
//         ));
//   }
// }
