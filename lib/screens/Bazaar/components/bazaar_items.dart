import 'package:codecarrots_unotraders/model/add_wishlist_model.dart';
import 'package:codecarrots_unotraders/model/bazaar_detail_post_model.dart';
import 'package:codecarrots_unotraders/model/bazaar_model.dart';
import 'package:codecarrots_unotraders/model/message/bazaar_store_message_model.dart';
import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';
import 'package:codecarrots_unotraders/provider/message_provider.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/bazaar_detail.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/bazaar_detail_page.dart';
import 'package:codecarrots_unotraders/screens/Message%20Section/chat_screen.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:mj_image_slider/mj_image_slider.dart';
import 'package:mj_image_slider/mj_options.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BazaarItems extends StatelessWidget {
  final bool? isShortListOnly;
  const BazaarItems({
    Key? key,
    this.isShortListOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BazaarModel bazaarModelProvider = Provider.of<BazaarModel>(context);
    BazaarProvider bazaarProvider =
        Provider.of<BazaarProvider>(context, listen: false);
    MessageProvider messageProvider =
        Provider.of<MessageProvider>(context, listen: false);
    DateTime date = DateTime.parse(bazaarModelProvider.createdAt!);
    return InkWell(
      onTap: () async {
        final sharedPrefs = await SharedPreferences.getInstance();
        String id = sharedPrefs.getString('id')!;
        String userType = sharedPrefs.getString('userType')!;
        BazaarDetailPostModel postBody = BazaarDetailPostModel(
            productId: bazaarModelProvider.id,
            userId: int.parse(id),
            userType: userType);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BazaarDetailScreen(
                      postBody: postBody,
                    )));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => BazaarDetail(
        //               bazaarModel: bazaarModelProvider,
        //             )));
      },
      child: Card(
        shadowColor: AppColor.blackColor,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                margin: const EdgeInsets.only(
                  left: 10,
                ),
                height: 130,
                width: 130,
                child: bazaarModelProvider.bazaarimages!.isEmpty
                    ? Center(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                          ),
                          TextWidget(data: "No image")
                        ],
                      ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: ImgFade.fadeImage(
                            url: bazaarModelProvider.bazaarimages![0]),
                      )
                // MJImageSlider(
                //     options: MjOptions(height: 130, width: null),
                //     widgets: [
                //       ...bazaarModelProvider.bazaarimages!
                //           .map((e) => Container(
                //                 margin: EdgeInsets.only(right: 5),
                //                 child: ClipRRect(
                //                     borderRadius: BorderRadius.circular(13),
                //                     child: Image(
                //                       image: NetworkImage(
                //                         e,
                //                       ),
                //                       fit: BoxFit.cover,
                //                     )),
                //               ))
                //           .toList(),

                //  ],
                //   ),
                ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  data: bazaarModelProvider.product!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                TextWidget(
                  data:
                      "Posted: ${date.day} ${DateFormat.MMM().format(date)} ${date.year}, ${DateFormat('hh:mm a').format(date)}",
                  style: const TextStyle(color: Colors.grey),
                ),
                TextWidget(
                  data: bazaarModelProvider.addedUsertype!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      bazaarModelProvider.wishlist == 1
                          ? ElevatedButton.icon(
                              onPressed: () async {
                                AppConstant.overlayLoaderShow(context);
                                final sharedPrefs =
                                    await SharedPreferences.getInstance();
                                String id = sharedPrefs.getString('id')!;
                                String userType =
                                    sharedPrefs.getString('userType')!;
                                print("shortlisted pressed");
                                AddWishListModel wishlist = AddWishListModel(
                                    productId: bazaarModelProvider.id,
                                    userId: int.parse(id),
                                    userType: userType);

                                await bazaarProvider
                                    .removeWishlist(wishlist: wishlist)
                                    .then((value) {
                                  AppConstant.toastMsg(
                                      msg: "Product Removed from Wishlist",
                                      backgroundColor: AppColor.green);
                                  bazaarProvider.fetchBazaarProducts();

                                  return;
                                }).onError((error, stackTrace) {
                                  AppConstant.toastMsg(
                                      msg: "Something Went Wrong",
                                      backgroundColor: AppColor.red);
                                  return;
                                });

                                // ignore: use_build_context_synchronously
                                AppConstant.overlayLoaderHide(context);
                                // AddWishListModel wishlist = AddWishListModel(
                                //     productId: bazaarModelProvider
                                //         .bazaarProductsList[
                                //             index]
                                //         .id,
                                //     userId: int.parse(
                                //         ApiServicesUrl
                                //             .id),
                                //     userType:
                                //         ApiServicesUrl
                                //             .userType);

                                // await bazaarModelProvider
                                //     .addWishlist(
                                //         wishlist:
                                //             wishlist)
                                //     .then((value) {
                                //   Constant.toastMsg(
                                //       msg:
                                //           "Product Added to Wishlist",
                                //       backgroundColor:
                                //           AppColor
                                //               .green);
                                //                 bazaarModelProvider.fetchBazaarProducts();

                                //   return;
                                // }).onError((error,
                                //         stackTrace) {
                                //   Constant.toastMsg(
                                //       msg:
                                //           "Something Went Wrong",
                                //       backgroundColor:
                                //           AppColor
                                //               .red);
                                //   return;
                                // });
                              },
                              icon: const Icon(
                                Icons.check_box,
                                size: 15,
                              ),
                              label: TextWidget(data: "Shortlisted"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.blackColor,
                                  minimumSize: const Size(60, 26),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            )
                          : ElevatedButton.icon(
                              onPressed: () async {
                                AppConstant.overlayLoaderShow(context);
                                final sharedPrefs =
                                    await SharedPreferences.getInstance();
                                String id = sharedPrefs.getString('id')!;
                                String userType =
                                    sharedPrefs.getString('userType')!;
                                AddWishListModel wishlist = AddWishListModel(
                                    productId: bazaarModelProvider.id,
                                    userId: int.parse(id),
                                    userType: userType);

                                await bazaarProvider
                                    .addWishlist(wishlist: wishlist)
                                    .then((value) {
                                  AppConstant.toastMsg(
                                      msg: "Product Added to Wishlist",
                                      backgroundColor: AppColor.green);
                                  bazaarProvider.fetchBazaarProducts();

                                  return;
                                }).onError((error, stackTrace) {
                                  AppConstant.toastMsg(
                                      msg: "Something Went Wrong",
                                      backgroundColor: AppColor.red);
                                  return;
                                });
                                // ignore: use_build_context_synchronously
                                AppConstant.overlayLoaderHide(context);
                              },
                              icon: const Icon(
                                Icons.add_circle,
                                size: 15,
                              ),
                              label: TextWidget(data: "Shortlist"),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(60, 26),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                      const SizedBox(
                        width: 5,
                      ),
                      isShortListOnly != null
                          ? const SizedBox()
                          : ElevatedButton(
                              onPressed: () async {
                                final sharedPrefs =
                                    await SharedPreferences.getInstance();
                                String id = sharedPrefs.getString('id')!;
                                String userType =
                                    sharedPrefs.getString('userType')!;
                                if (bazaarModelProvider.addedBy.toString() ==
                                        id &&
                                    bazaarModelProvider.addedUsertype
                                            .toString() ==
                                        userType) {
                                  AppConstant.toastMsg(
                                      msg: "This product is added by you",
                                      backgroundColor: AppColor.red);
                                } else {
                                  final model = bazaarModelProvider;
                                  BazaarStoreMessageModel storeBazaar =
                                      BazaarStoreMessageModel(
                                          fromUserId: int.parse(id),
                                          fromUserType: userType,
                                          productId: bazaarModelProvider.id,
                                          toUserId: int.parse(
                                              bazaarModelProvider.addedBy ??
                                                  "0"),
                                          toUserType: bazaarModelProvider
                                                  .addedUsertype ??
                                              "");

                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: ChatScreen(
                                            name: model.name ?? "",
                                            toUserId:
                                                int.parse(model.addedBy ?? "0"),
                                            profilePic: model.profilePic ?? "",
                                            toUsertype:
                                                model.addedUsertype ?? "",
                                            storeBazaar: storeBazaar,
                                          )));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.blackColor,
                                  minimumSize: const Size(70, 26),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              child: TextWidget(data: "Message"),
                            ),
                      const SizedBox(
                        width: 5,
                      ),
                      isShortListOnly != null
                          ? const SizedBox()
                          : OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(75, 26),
                                  side: const BorderSide(
                                      color: AppColor.primaryColor),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              child: TextWidget(data: "Report"))
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
