// import 'package:codecarrots_unotraders/utils/color.dart';
// import 'package:codecarrots_unotraders/utils/png.dart';
// import 'package:flutter/material.dart';

// class Bazaar extends StatefulWidget {
//   const Bazaar({Key? key}) : super(key: key);

//   @override
//   _BazaarState createState() => _BazaarState();
// }

// class _BazaarState extends State<Bazaar> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         bottomOpacity: 0.0,
//         elevation: 0.0,
//         backgroundColor: AppColor.whiteColor,
//         leading: GestureDetector(
//           onTap: (){
//             Navigator.pop(context);
//           },
//             child: Image.asset(PngImages.arrowBack)),
//         centerTitle: true,
//         title: const Text(
//           'Bazaar',
//           style: TextStyle(color: AppColor.blackColor),
//         ),
//       ),
//       body: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.04,
//                 decoration: BoxDecoration(
//                     color: AppColor.whiteBtnColor,
//                     borderRadius: BorderRadius.circular(20.0),
//                     border: Border.all(
//                       color: AppColor.secondaryColor,
//                     )),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Center(
//                       child: Text(
//                     'Sell on Bazaar Now',
//                     style: TextStyle(
//                         color: AppColor.blackColor,
//                         fontWeight: FontWeight.w500,
//                         fontSize: MediaQuery.of(context).size.width * 0.03),
//                   )),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Image.asset(
//                   PngImages.searchRounded,
//                   width: MediaQuery.of(context).size.width * 0.08,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GestureDetector(
//                     onTap: () => _buildPopupDialog(context),
//                     child: Image.asset(
//                       PngImages.sort,
//                       width: MediaQuery.of(context).size.width * 0.08,
//                     )),
//               ),
//             ],
//           ),
//           Expanded(
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: 5,
//               itemBuilder: (BuildContext context, int index) {
//                 return Card(
//                   shadowColor: AppColor.blackColor,
//                   elevation: 10,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Image.asset(
//                         PngImages.bazaar,
//                         height: MediaQuery.of(context).size.height * 0.2,
//                         width: MediaQuery.of(context).size.width * 0.3,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20.0, left: 10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Ultratech-Cement',
//                               style: TextStyle(
//                                   color: AppColor.blackColor,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             const Text(
//                               'Posted: 25 Jan 2022,11.00PM',
//                               style: TextStyle(
//                                   color: Colors.grey,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             const Text(
//                               'Admin',
//                               style: TextStyle(
//                                   color: AppColor.secondaryColor,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.04,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.2,
//                                   decoration: BoxDecoration(
//                                     color: AppColor.secondaryColor,
//                                     borderRadius: BorderRadius.circular(20.0),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Center(
//                                         child: Row(
//                                       children: [
//                                         Image.asset(PngImages.plus),
//                                         Text(
//                                           'Shortlist',
//                                           style: TextStyle(
//                                               color: AppColor.whiteColor,
//                                               fontWeight: FontWeight.w500,
//                                               fontSize: MediaQuery.of(context)
//                                                       .size
//                                                       .width *
//                                                   0.03),
//                                         ),
//                                       ],
//                                     )),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     height: MediaQuery.of(context).size.height *
//                                         0.04,
//                                     width:
//                                         MediaQuery.of(context).size.width * 0.2,
//                                     decoration: BoxDecoration(
//                                       color: AppColor.blackColor,
//                                       borderRadius: BorderRadius.circular(20.0),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Center(
//                                           child: Text(
//                                         'Message',
//                                         style: TextStyle(
//                                             color: AppColor.whiteColor,
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.03),
//                                       )),
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.04,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.2,
//                                   decoration: BoxDecoration(
//                                       color: AppColor.whiteBtnColor,
//                                       borderRadius: BorderRadius.circular(20.0),
//                                       border: Border.all(
//                                         color: AppColor.secondaryColor,
//                                       )),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Center(
//                                         child: Text(
//                                       'Report',
//                                       style: TextStyle(
//                                           color: AppColor.blackColor,
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               0.03),
//                                     )),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future _buildPopupDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               const Text('Search Products'),
//               IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(
//                     Icons.cancel,
//                     color: AppColor.secondaryColor,
//                   ))
//             ],
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       hintText: 'Search for Product',
//                       labelText: 'Search for Product',
//                       labelStyle: const TextStyle(color: AppColor.blackColor),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         borderSide:
//                             const BorderSide(color: AppColor.blackColor),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         borderSide:
//                             const BorderSide(color: AppColor.blackColor),
//                       )),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.07,
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                         hintText: 'Main Category',
//                         labelText: 'Main Category',
//                         labelStyle: const TextStyle(color: AppColor.blackColor),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide:
//                               const BorderSide(color: AppColor.blackColor),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide:
//                               const BorderSide(color: AppColor.blackColor),
//                         )),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       hintText: 'Sub Category',
//                       labelText: 'Sub Category',
//                       labelStyle: const TextStyle(color: AppColor.blackColor),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         borderSide:
//                             const BorderSide(color: AppColor.blackColor),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         borderSide:
//                             const BorderSide(color: AppColor.blackColor),
//                       )),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(top: 8.0),
//                 child: Text('Location Range'),
//               ),
//               Slider.adaptive(
//                 min: 0.0,
//                 value: 10.0,
//                 max: 30.0,
//                 onChanged: (double value) {},
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text('1km'),
//                     Text('10km'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0,right: 20.0),
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 decoration: BoxDecoration(
//                   color: AppColor.secondaryColor,
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Search',
//                     style: TextStyle(
//                         color: AppColor.whiteColor,
//                         fontSize: MediaQuery.of(context).size.width * 0.045,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
