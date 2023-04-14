// import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
// import 'package:codecarrots_unotraders/model/get_accept_reject_model.dart';
// import 'package:codecarrots_unotraders/provider/customer_job_actions_provider.dart';
// import 'package:codecarrots_unotraders/screens/Message%20Section/chat_screen.dart';
// import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
// import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
// import 'package:codecarrots_unotraders/utils/color.dart';
// import 'package:codecarrots_unotraders/utils/app_constant.dart';
// import 'package:codecarrots_unotraders/utils/img_fade.dart';
// import 'package:codecarrots_unotraders/utils/png.dart';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:page_transition/page_transition.dart';

// import 'package:provider/provider.dart';

// class CustomerMoreDetails extends StatefulWidget {
//   final GetAcceptRejectModel jobDetails;
//   const CustomerMoreDetails({super.key, required this.jobDetails});

//   @override
//   State<CustomerMoreDetails> createState() =>
//       _CustomerAcceptRejectMoreDetailsState();
// }

// class _CustomerAcceptRejectMoreDetailsState extends State<CustomerMoreDetails> {
//   late CustomerJobActionProvider customerActionProvider;
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       customerActionProvider =
//           Provider.of<CustomerJobActionProvider>(context, listen: false);
//       customerActionProvider.clearAll();
//       customerActionProvider.fetchTraderQuoteReq(
//           jobId: widget.jobDetails.jobId.toString());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("job id ${widget.jobDetails.id.toString()}");
//     print(widget.jobDetails.id);
//     print(widget.jobDetails.jobCompletion);
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
//       body: Consumer<CustomerJobActionProvider>(
//           builder: (context, actionProvider, _) {
//         return Padding(
//           padding: EdgeInsets.all(size.width * .03),
//           child: actionProvider.isMoreLoading
//               ? const Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : actionProvider.moreDetailsErrorMessage.isNotEmpty
//                   ? Center(
//                       child: TextWidget(data: "Something Went Wrong"),
//                     )
//                   : Column(
//                       children: [
//                         Flexible(
//                             child: ListView(
//                           shrinkWrap: true,
//                           children: [
//                             SizedBox(
//                               height: size.height * .2,
//                               child: ListView.separated(
//                                 separatorBuilder: (context, index) =>
//                                     AppConstant.kWidth(width: 10),
//                                 shrinkWrap: true,
//                                 itemCount: widget.jobDetails.jobimages!.length,
//                                 scrollDirection: Axis.horizontal,
//                                 itemBuilder: (context, index) => ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: widget.jobDetails.jobimages!.isEmpty
//                                       ? ImgFade.errorImage(
//                                           width: size.width * .6,
//                                           height: size.height * .1)
//                                       : ImgFade.fadeImage(
//                                           height: size.height * .1,
//                                           width: size.width * .6,
//                                           url: widget
//                                               .jobDetails.jobimages![index]),
//                                 ),
//                               ),
//                             ),
//                             AppConstant.kheight(height: size.width * .02),
//                             Row(
//                               children: [
//                                 Padding(
//                                   padding:
//                                       EdgeInsets.only(top: size.width * .02),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(
//                                         width: size.width * .57,
//                                         child: TextWidget(
//                                           data: widget.jobDetails.title
//                                               .toString(),
//                                           maxLines: 4,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: const TextStyle(
//                                               fontSize: 17,
//                                               color: AppColor.blackColor,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       AppConstant.kheight(
//                                           height: size.width * .02),
//                                       Row(
//                                         children: [
//                                           Container(
//                                             alignment: Alignment.center,
//                                             height: size.height * .04,
//                                             decoration: BoxDecoration(
//                                               color: Colors.orangeAccent,
//                                               borderRadius:
//                                                   BorderRadius.circular(5.0),
//                                             ),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(1.0),
//                                               child: Center(
//                                                 child: Row(
//                                                   children: [
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                           left:
//                                                               size.width * .02),
//                                                       child: Image.asset(
//                                                           PngImages.dollar),
//                                                     ),
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                           left:
//                                                               size.width * .01,
//                                                           right:
//                                                               size.width * .02),
//                                                       child: TextWidget(
//                                                         data: widget
//                                                             .jobDetails.budget
//                                                             .toString(),
//                                                         style: const TextStyle(
//                                                           color: AppColor
//                                                               .whiteColor,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           AppConstant.kWidth(
//                                               width: size.width * .01),
//                                           const Icon(
//                                             Icons.alarm,
//                                             color: AppColor.primaryColor,
//                                           ),
//                                           TextWidget(
//                                             data:
//                                                 "Posted:  ${date.day} ${DateFormat.MMM().format(date)} ${date.year}",
//                                             style: TextStyle(
//                                               color: AppColor.secondaryColor,
//                                               fontWeight: FontWeight.w500,
//                                               fontSize: size.width * 0.028,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             actionProvider.traderQuoteReqList.isEmpty
//                                 ? const SizedBox()
//                                 : AppConstant.kheight(height: size.width * .02),
//                             actionProvider.traderQuoteReqList.isEmpty
//                                 ? const SizedBox()
//                                 : TextWidget(
//                                     data: "Job Quote Requests",
//                                     style: TextStyle(
//                                         color: AppColor.blackColor,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                             AppConstant.kheight(height: size.width * .02),
//                             ListView.separated(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   final traderReq =
//                                       actionProvider.traderQuoteReqList[index];
//                                   String status = traderReq.status!.toString();
//                                   return Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       titleTrader(
//                                           name: traderReq.name ?? "",
//                                           profilePic:
//                                               traderReq.profilePic ?? "",
//                                           size: size,
//                                           titleOne: "Trader",
//                                           titleTwo: traderReq.name ?? "",
//                                           isButton: false,
//                                           traderId: traderReq.traderId ?? "",
//                                           jobQuoteID: traderReq.quoteId ?? ""),
//                                       titleTrader(
//                                           name: traderReq.name ?? "",
//                                           profilePic:
//                                               traderReq.profilePic ?? "",
//                                           size: size,
//                                           titleOne: "Quote Price",
//                                           titleTwo: traderReq.quotedPrice ?? "",
//                                           isButton: false,
//                                           traderId: traderReq.traderId ?? "",
//                                           jobQuoteID: traderReq.quoteId ?? ""),
//                                       titleTrader(
//                                           name: traderReq.name ?? "",
//                                           profilePic:
//                                               traderReq.profilePic ?? "",
//                                           size: size,
//                                           titleOne: "Quote Reason",
//                                           titleTwo: traderReq.quoteReason ?? "",
//                                           isButton: false,
//                                           traderId: traderReq.traderId ?? "",
//                                           jobQuoteID: traderReq.quoteId ?? ""),
//                                       titleTrader(
//                                           profilePic:
//                                               traderReq.profilePic ?? "",
//                                           name: traderReq.name ?? "",
//                                           size: size,
//                                           titleOne: "status",
//                                           traderId: traderReq.traderId ?? "",
//                                           titleTwo: traderReq.status ?? "",
//                                           isButton: status.toLowerCase() ==
//                                                   "requested"
//                                               ? true
//                                               : false,
//                                           jobQuoteID: traderReq.quoteId ?? ""),
//                                     ],
//                                   );
//                                 },
//                                 separatorBuilder: (context, index) =>
//                                     const Divider(),
//                                 itemCount:
//                                     actionProvider.traderQuoteReqList.length)
//                           ],
//                         ))
//                       ],
//                     ),
//         );
//       }),
//     );
//   }

//   Widget titleTrader(
//       {required Size size,
//       required String name,
//       required String titleOne,
//       required String profilePic,
//       required String titleTwo,
//       required bool isButton,
//       required String traderId,
//       required String jobQuoteID}) {
//     return Container(
//       padding: EdgeInsets.only(
//         left: size.width * .04,
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
//                       width: size.width * .3,
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
//                     AppConstant.kWidth(width: size.width * .02),
//                     Expanded(
//                       child: Container(
//                         padding: EdgeInsets.all(size.width * .01),
//                         alignment: Alignment.centerLeft,
//                         child: Row(
//                           children: [
//                             isButton == false
//                                 ? TextWidget(
//                                     data: titleTwo,
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 2,
//                                   )
//                                 : Expanded(
//                                     child: Row(
//                                       children: [
//                                         InkWell(
//                                           onTap: () async {
//                                             print("accept");
//                                             await customerActionProvider
//                                                 .customerQuoteReqAction(
//                                                     jobQuoteID:
//                                                         jobQuoteID.toString(),
//                                                     status: "accept",
//                                                     traderId: traderId,
//                                                     jobId: widget.jobDetails.id
//                                                         .toString());
//                                           },
//                                           child: Container(
//                                             padding: const EdgeInsets.all(3),
//                                             alignment: Alignment.center,
//                                             width: size.width * .17,
//                                             decoration: BoxDecoration(
//                                                 color: AppColor.green,
//                                                 borderRadius:
//                                                     BorderRadius.circular(10)),
//                                             child: TextWidget(
//                                                 data: "Accept",
//                                                 style: TextStyle(
//                                                     color:
//                                                         AppColor.whiteColor)),
//                                           ),
//                                         ),
//                                         AppConstant.kWidth(
//                                             width: size.width * .01),
//                                         InkWell(
//                                           onTap: () async {
//                                             await customerActionProvider
//                                                 .customerQuoteReqAction(
//                                                     jobQuoteID:
//                                                         jobQuoteID.toString(),
//                                                     status: "reject",
//                                                     traderId: traderId,
//                                                     jobId: widget.jobDetails.id
//                                                         .toString());
//                                           },
//                                           child: Container(
//                                             padding: const EdgeInsets.all(3),
//                                             alignment: Alignment.center,
//                                             width: size.width * .17,
//                                             decoration: BoxDecoration(
//                                                 color: AppColor.red,
//                                                 borderRadius:
//                                                     BorderRadius.circular(10)),
//                                             child: TextWidget(
//                                                 data: "Reject",
//                                                 style: TextStyle(
//                                                     color:
//                                                         AppColor.whiteColor)),
//                                           ),
//                                         ),
//                                         AppConstant.kWidth(
//                                             width: size.width * .01),
//                                         InkWell(
//                                           onTap: () {
//                                             Navigator.push(
//                                                 context,
//                                                 PageTransition(
//                                                     type:
//                                                         PageTransitionType.fade,
//                                                     child: ChatScreen(
//                                                       name: name,
//                                                       toUsertype: "trader",
//                                                       profilePic: profilePic,
//                                                       toUserId:
//                                                           int.parse(traderId),
//                                                     )));
//                                           },
//                                           child: Container(
//                                             padding: const EdgeInsets.all(3),
//                                             alignment: Alignment.center,
//                                             width: size.width * .17,
//                                             decoration: BoxDecoration(
//                                                 color: AppColor.blackColor,
//                                                 borderRadius:
//                                                     BorderRadius.circular(10)),
//                                             child: TextWidget(
//                                               data: "Chat",
//                                               style: TextStyle(
//                                                   color: AppColor.whiteColor),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                           ],
//                         ),
//                       ),
//                     )
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
