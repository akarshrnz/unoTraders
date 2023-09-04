import 'package:codecarrots_unotraders/model/add_wishlist_model.dart';
import 'package:codecarrots_unotraders/model/wishlist_model.dart';
import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/screens/wishlist/wishlist_detail.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  bool isLoading = false;
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
      body: Provider.of<BazaarProvider>(context, listen: true).isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Flexible(
                    child: FutureBuilder<List<WishListModel>>(
                        future: bazaarProvider.fetchWishlist(),
                        builder: (context,
                            AsyncSnapshot<List<WishListModel>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Center(
                                child:
                                    TextWidget(data: snapshot.error.toString()),
                              );
                            } else if (snapshot.hasData) {
                              final data = snapshot.data ?? [];

                              if (data.isEmpty) {
                                return Center(
                                  child: TextWidget(
                                      data: "No Products Shortlisted"),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      height: 10,
                                    ),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      WishListModel data =
                                          snapshot.data![index];
                                      DateTime date =
                                          DateTime.parse(data.createdAt!);

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        WishListDetail(
                                                            wishListModel:
                                                                data)));
                                          },
                                          child: Card(
                                            shadowColor: AppColor.blackColor,
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  margin: const EdgeInsets.only(
                                                    left: 10,
                                                  ),
                                                  height: 130,
                                                  width: 130,
                                                  child: data
                                                          .bazaarimages!.isEmpty
                                                      ? Center(
                                                          child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .broken_image,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            TextWidget(
                                                                data:
                                                                    "No image")
                                                          ],
                                                        ))
                                                      : ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7),
                                                          child: ImgFade.fadeImage(
                                                              url:
                                                                  data.bazaarimages![
                                                                      0])),
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
                                                    TextWidget(
                                                      data: data.product!,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: AppColor
                                                              .blackColor,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    TextWidget(
                                                      data:
                                                          "Posted: ${date.day} ${DateFormat.MMM().format(date)} ${date.year}, ${DateFormat('hh:mm a').format(date)}",
                                                      style: const TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    TextWidget(
                                                      data: data.addedUsertype!,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: AppColor
                                                              .primaryColor,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      child: Row(
                                                        children: [
                                                          ElevatedButton.icon(
                                                            onPressed:
                                                                () async {
                                                              final sharedPrefs =
                                                                  await SharedPreferences
                                                                      .getInstance();
                                                              String id =
                                                                  sharedPrefs
                                                                      .getString(
                                                                          'id')!;
                                                              String userType =
                                                                  sharedPrefs
                                                                      .getString(
                                                                          'userType')!;
                                                              AddWishListModel
                                                                  wishlist =
                                                                  AddWishListModel(
                                                                      productId:
                                                                          data
                                                                              .id,
                                                                      userId: int
                                                                          .parse(
                                                                              id),
                                                                      userType:
                                                                          userType);

                                                              await bazaarProvider
                                                                  .removeFetchWishList(
                                                                      wishlist:
                                                                          wishlist);

                                                              // await bazaarProvider
                                                              //     .removeWishlist(
                                                              //         wishlist:
                                                              //             wishlist)
                                                              //     .then((value) {
                                                              //   Constant.toastMsg(
                                                              //       msg:
                                                              //           "Product Removed from Wishlist",
                                                              //       backgroundColor:
                                                              //           AppColor.green);
                                                              //   setState(() {});

                                                              //   return;
                                                              // }).onError((error,
                                                              //         stackTrace) {
                                                              //   Constant.toastMsg(
                                                              //       msg:
                                                              //           "Something Went Wrong",
                                                              //       backgroundColor:
                                                              //           AppColor.red);
                                                              //   return;
                                                              // });
                                                            },
                                                            icon: const Icon(
                                                              Icons.check_box,
                                                              size: 15,
                                                            ),
                                                            label: TextWidget(
                                                                data:
                                                                    "Shortlisted"),
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    AppColor
                                                                        .blackColor,
                                                                minimumSize:
                                                                    const Size(
                                                                        60, 26),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                              }
                            } else {
                              return Center(
                                  child: TextWidget(
                                      data: "Document does not exist"));
                            }
                          } else {
                            return AppConstant.circularProgressIndicator();
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
                          //                     TextWidget(data:"No image")
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
                          //             TextWidget(data:
                          //               provider.bazaarProductsList[index].product!,
                          //               maxLines: 2,
                          //               overflow: TextOverflow.ellipsis,
                          //               style: const TextStyle(
                          //                   color: AppColor.blackColor,
                          //                   fontSize: 15,
                          //                   fontWeight: FontWeight.w600),
                          //             ),
                          //             TextWidget(data:
                          //               "Posted: ${date.day} ${DateFormat.MMM().format(date)} ${date.year}, ${DateFormat('hh:mm a').format(date)}",
                          //               style: const TextStyle(color: Colors.grey),
                          //             ),
                          //             TextWidget(data:
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
                          //                     label: const TextWidget(data:"Shortlist"),
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
                          //                     child: const TextWidget(data:"Message"),
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
                          //                       child: const TextWidget(data:"Report"))
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
