// import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
// import 'package:codecarrots_unotraders/provider/trader_job_info_provider.dart';
// import 'package:codecarrots_unotraders/screens/job/job%20type/trader%20job%20type/quote_request_popup.dart';
// import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
// import 'package:codecarrots_unotraders/utils/color.dart';
// import 'package:codecarrots_unotraders/utils/app_constant.dart';
// import 'package:codecarrots_unotraders/utils/img_fade.dart';
// import 'package:codecarrots_unotraders/utils/png.dart';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import 'package:provider/provider.dart';

// class TraderAllJobMoreDetail extends StatefulWidget {
//   final FetchJobModel jobDetails;
//   final bool isAlljobs;
//   const TraderAllJobMoreDetail(
//       {super.key, required this.jobDetails, required this.isAlljobs});

//   @override
//   State<TraderAllJobMoreDetail> createState() => _TraderJobMoreDetailState();
// }

// class _TraderJobMoreDetailState extends State<TraderAllJobMoreDetail> {
//   late TraderInfoProvider infoProvider;
//   @override
//   void initState() {
//     infoProvider = Provider.of<TraderInfoProvider>(context, listen: false);
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       infoProvider.getTraderJobInformation(
//           jobId: widget.jobDetails.id.toString());
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("trader More details");
//     print("job id");
//     print(widget.jobDetails.id);
//     final size = MediaQuery.of(context).size;
//     DateTime date = DateTime.parse(widget.jobDetails.createdAt!);
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
//         title: TextWidget(
//           data: 'Job',
//           style: TextStyle(color: AppColor.blackColor),
//         ),
//       ),
//       body: Consumer<TraderInfoProvider>(builder: (context, provider, _) {
//         return provider.traderMoreLoading
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Padding(
//                 padding: EdgeInsets.all(size.width * .03),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Flexible(
//                         child: ListView(
//                       shrinkWrap: true,
//                       children: [
//                         SizedBox(
//                           height: size.height * .2,
//                           child: ListView.separated(
//                             separatorBuilder: (context, index) =>
//                                 AppConstant.kWidth(width: 10),
//                             shrinkWrap: true,
//                             itemCount: widget.jobDetails.jobimages!.length,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) => ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: widget.jobDetails.jobimages!.isEmpty
//                                   ? ImgFade.errorImage(
//                                       width: size.width * .6,
//                                       height: size.height * .1)
//                                   : ImgFade.fadeImage(
//                                       height: size.height * .1,
//                                       width: size.width * .6,
//                                       url: widget.jobDetails.jobimages![index]),
//                             ),
//                           ),
//                         ),
//                         AppConstant.kheight(height: size.width * .02),
//                         Row(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(top: size.width * .02),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     width: size.width * .57,
//                                     child: TextWidget(
//                                       data: widget.jobDetails.title.toString(),
//                                       maxLines: 4,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(
//                                           fontSize: 17,
//                                           color: AppColor.blackColor,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   AppConstant.kheight(height: size.width * .02),
//                                   Row(
//                                     children: [
//                                       Container(
//                                         alignment: Alignment.center,
//                                         height: size.height * .04,
//                                         decoration: BoxDecoration(
//                                           color: Colors.orangeAccent,
//                                           borderRadius:
//                                               BorderRadius.circular(5.0),
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(1.0),
//                                           child: Center(
//                                             child: Row(
//                                               children: [
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                       left: size.width * .02),
//                                                   child: Image.asset(
//                                                       PngImages.dollar),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                       left: size.width * .01,
//                                                       right: size.width * .02),
//                                                   child: TextWidget(
//                                                     data: widget
//                                                         .jobDetails.budget
//                                                         .toString(),
//                                                     style: const TextStyle(
//                                                       color:
//                                                           AppColor.whiteColor,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       AppConstant.kWidth(
//                                           width: size.width * .01),
//                                       const Icon(
//                                         Icons.alarm,
//                                         color: AppColor.primaryColor,
//                                       ),
//                                       TextWidget(
//                                         data:
//                                             "Posted:  ${date.day} ${DateFormat.MMM().format(date)} ${date.year}",
//                                         style: TextStyle(
//                                           color: AppColor.secondaryColor,
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: size.width * 0.028,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         AppConstant.kheight(height: size.width * .02),

//                         AppConstant.kheight(height: size.width * .02),
//                         // const TextWidget(data:
//                         //   "Job Quote Requests",
//                         //   style: TextStyle(
//                         //       color: AppColor.blackColor, fontWeight: FontWeight.bold),
//                         // ),
//                         // Constant.kheight(height: size.width * .02),
//                       ],
//                     )),
//                     widget.isAlljobs == false
//                         ? const SizedBox()
//                         : SizedBox(
//                             width: size.width,
//                             child: Row(
//                               children: [
//                                 InkWell(
//                                   onTap: () async {
//                                     await showDialog(
//                                       context: context,
//                                       builder: (context) => QuoteRequestPopUp(
//                                         callMessage: false,
//                                         jobTitle: widget.jobDetails.title ?? "",
//                                         userid:
//                                             widget.jobDetails.userId.toString(),
//                                         jobId: widget.jobDetails.id.toString(),
//                                         isRequestMoreDetails: true,
//                                       ),
//                                     );
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     width: size.width * .4,
//                                     padding: EdgeInsets.all(size.width * .02),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(7),
//                                       color: AppColor.green,
//                                     ),
//                                     child: TextWidget(
//                                       data: "Request More details",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: size.width * .03,
//                                 ),
//                                 InkWell(
//                                   onTap: () async {
//                                     await showDialog(
//                                       context: context,
//                                       builder: (context) => QuoteRequestPopUp(
//                                         callMessage: false,
//                                         jobTitle: widget.jobDetails.title ?? "",
//                                         userid:
//                                             widget.jobDetails.userId.toString(),
//                                         jobId: widget.jobDetails.id.toString(),
//                                       ),
//                                     );
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     width: size.width * .3,
//                                     padding: EdgeInsets.all(size.width * .02),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(7),
//                                       color: AppColor.green,
//                                     ),
//                                     child: TextWidget(
//                                       data: "Quote Job",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                     AppConstant.kheight(height: size.width * .02),
//                     provider.traderJobInfo.isEmpty
//                         ? const SizedBox()
//                         : TextWidget(
//                             data: "Job Quote Requests",
//                             style: TextStyle(
//                                 color: AppColor.blackColor,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                     AppConstant.kheight(height: size.width * .02),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: provider.traderJobInfo.length,
//                       itemBuilder: (context, index) {
//                         final data = provider.traderJobInfo[index];

//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             titleTrader(
//                               size: size,
//                               titleOne: "Trader",
//                               titleTwo: data.name ?? "",
//                             ),
//                             titleTrader(
//                               size: size,
//                               titleOne: "Quote Price",
//                               titleTwo: data.quotedPrice ?? "",
//                             ),
//                             titleTrader(
//                               size: size,
//                               titleOne: "Quote Reason",
//                               titleTwo: data.quoteReason ?? "",
//                             ),
//                             titleTrader(
//                               size: size,
//                               titleOne: "Status",
//                               titleTwo: data.status ?? "",
//                             ),
//                           ],
//                         );
//                       },
//                     )
//                   ],
//                 ),
//               );
//       }),
//     );
//   }

//   Widget titleTrader({
//     required Size size,
//     required String titleOne,
//     required String titleTwo,
//   }) {
//     return Container(
//       padding: EdgeInsets.only(
//         // left: size.width * .04,
//         right: size.width * .01,
//         top: size.width * .02,
//       ),
//       child: Row(
//         children: [
//           Flexible(
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(size.width * .01),
//                       alignment: Alignment.centerLeft,
//                       width: size.width * .23,
//                       child: TextWidget(
//                         data: titleOne,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     AppConstant.kWidth(width: size.width * .01),
//                     TextWidget(
//                       data: ":",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     AppConstant.kWidth(width: size.width * .028),
//                     Expanded(
//                         child: Container(
//                       child: TextWidget(
//                         data: titleTwo,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ))
//                   ],
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
