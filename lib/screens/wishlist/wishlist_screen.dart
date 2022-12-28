import 'package:codecarrots_unotraders/model/wishlist_model.dart';
import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';
import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/wishlist/wishlist_detail.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  late BazaarProvider bazaarProvider;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bazaarProvider = Provider.of<BazaarProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBarWidget(
        appBarTitle: "Favourite",
        leading: const SizedBox(),
      ),
      body: Column(
        children: [
          Flexible(
              child: FutureBuilder<List<WishListModel>>(
                  future: bazaarProvider.fetchWishlist(),
                  builder:
                      (context, AsyncSnapshot<List<WishListModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return  Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(
                            
                            separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              WishListModel data = snapshot.data![index];
                              DateTime date = DateTime.parse(data.createdAt!);

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WishListDetail(
                                                wishListModel: data)));
                                  },
                                  child: Card(
                                    shadowColor: AppColor.blackColor,
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          margin: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          height: 130,
                                          width: 130,
                                          child: data.bazaarimages!.isEmpty
                                              ? Center(
                                                  child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.broken_image,
                                                      color: Colors.grey,
                                                    ),
                                                    Text("No image")
                                                  ],
                                                ))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  child: ImgFade.fadeImage(
                                                      url:
                                                          data.bazaarimages![0])),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              data.product!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: AppColor.blackColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "Posted: ${date.day} ${DateFormat.MMM().format(date)} ${date.year}, ${DateFormat('hh:mm a').format(date)}",
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              data.addedUsertype!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: AppColor.primaryColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 20),
                                              child: Row(
                                                children: [
                                                  ElevatedButton.icon(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.check_box,
                                                      size: 15,
                                                    ),
                                                    label:
                                                        const Text("Shortlisted"),
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            AppColor.blackColor,
                                                        minimumSize:
                                                            const Size(60, 26),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20))),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(
                            child: Text("Document does not exist"));
                      }
                    } else {
                      return Constant.circularProgressIndicator();
                    }

                    // return ListView.separated(
                    //         separatorBuilder: (context, index) => const SizedBox(
                    // height: 10,
                    //         ),
                    //         physics: const NeverScrollableScrollPhysics(),
                    //         shrinkWrap: true,
                    //         itemCount: provider.bazaarProductsList.length,
                    //         itemBuilder: (context, index) {
                    // DateTime date =
                    //     DateTime.parse(provider.bazaarProductsList[index].createdAt!);

                    // return Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 15),
                    //   child: Card(
                    //     shadowColor: AppColor.blackColor,
                    //     clipBehavior: Clip.antiAlias,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10)),
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Container(
                    //           padding: const EdgeInsets.all(10),
                    //           margin: const EdgeInsets.only(
                    //             left: 10,
                    //           ),
                    //           height: 130,
                    //           width: 130,
                    //           child: provider
                    //                   .bazaarProductsList[index].bazaarimages!.isEmpty
                    //               ? Center(
                    //                   child: Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.center,
                    //                   children: const [
                    //                     Icon(
                    //                       Icons.broken_image,
                    //                       color: Colors.grey,
                    //                     ),
                    //                     Text("No image")
                    //                   ],
                    //                 ))
                    //               : ClipRRect(
                    //                   borderRadius: BorderRadius.circular(7),
                    //                   child: ImgFade.fadeImage(
                    //                       url: provider.bazaarProductsList[index]
                    //                           .bazaarimages![0])),
                    //         ),
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             const SizedBox(
                    //               height: 10,
                    //             ),
                    //             Text(
                    //               provider.bazaarProductsList[index].product!,
                    //               maxLines: 2,
                    //               overflow: TextOverflow.ellipsis,
                    //               style: const TextStyle(
                    //                   color: AppColor.blackColor,
                    //                   fontSize: 15,
                    //                   fontWeight: FontWeight.w600),
                    //             ),
                    //             Text(
                    //               "Posted: ${date.day} ${DateFormat.MMM().format(date)} ${date.year}, ${DateFormat('hh:mm a').format(date)}",
                    //               style: const TextStyle(color: Colors.grey),
                    //             ),
                    //             Text(
                    //               provider.bazaarProductsList[index].addedUsertype!,
                    //               maxLines: 1,
                    //               overflow: TextOverflow.ellipsis,
                    //               style: const TextStyle(
                    //                   color: AppColor.primaryColor,
                    //                   fontSize: 15,
                    //                   fontWeight: FontWeight.w600),
                    //             ),
                    //             Padding(
                    //               padding: const EdgeInsets.only(top: 20),
                    //               child: Row(
                    //                 children: [
                    //                   ElevatedButton.icon(
                    //                     onPressed: () {},
                    //                     icon: const Icon(
                    //                       Icons.add_circle,
                    //                       size: 15,
                    //                     ),
                    //                     label: const Text("Shortlist"),
                    //                     style: ElevatedButton.styleFrom(
                    //                         minimumSize: const Size(60, 26),
                    //                         shape: RoundedRectangleBorder(
                    //                             borderRadius:
                    //                                 BorderRadius.circular(20))),
                    //                   ),
                    //                   const SizedBox(
                    //                     width: 5,
                    //                   ),
                    //                   ElevatedButton(
                    //                     onPressed: () {},
                    //                     style: ElevatedButton.styleFrom(
                    //                         backgroundColor: AppColor.blackColor,
                    //                         minimumSize: const Size(70, 26),
                    //                         shape: RoundedRectangleBorder(
                    //                             borderRadius:
                    //                                 BorderRadius.circular(20))),
                    //                     child: const Text("Message"),
                    //                   ),
                    //                   const SizedBox(
                    //                     width: 5,
                    //                   ),
                    //                   OutlinedButton(
                    //                       onPressed: () {},
                    //                       style: OutlinedButton.styleFrom(
                    //                           minimumSize: const Size(75, 26),
                    //                           side: const BorderSide(
                    //                               color: AppColor.primaryColor),
                    //                           shape: RoundedRectangleBorder(
                    //                               borderRadius:
                    //                                   BorderRadius.circular(20))),
                    //                       child: const Text("Report"))
                    //                 ],
                    //               ),
                    //             )
                    //           ],
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // );
                    //         },
                    //       );
                  }))
        ],
      ),
    );
  }
}
