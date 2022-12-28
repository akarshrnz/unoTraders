import 'package:codecarrots_unotraders/model/add_wishlist_model.dart';
import 'package:codecarrots_unotraders/model/bazaar_model.dart';
import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/bazaar_detail.dart';
import 'package:codecarrots_unotraders/services/helper/api_services_url.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BazaarItems extends StatelessWidget {
  const BazaarItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BazaarModel bazaarModelProvider = Provider.of<BazaarModel>(context);
    BazaarProvider bazaarProvider =
        Provider.of<BazaarProvider>(context, listen: false);
    DateTime date = DateTime.parse(bazaarModelProvider.createdAt!);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BazaarDetail(
                      bazaarModel: bazaarModelProvider,
                    )));
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
                      children: const [
                        Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        ),
                        Text("No image")
                      ],
                    ))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: ImgFade.fadeImage(
                          url: bazaarModelProvider.bazaarimages![0])),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  bazaarModelProvider.product!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Posted: ${date.day} ${DateFormat.MMM().format(date)} ${date.year}, ${DateFormat('hh:mm a').format(date)}",
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  bazaarModelProvider.addedUsertype!,
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
                              label: const Text("Shortlisted"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.blackColor,
                                  minimumSize: const Size(60, 26),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            )
                          : ElevatedButton.icon(
                              onPressed: () async {
                                AddWishListModel wishlist = AddWishListModel(
                                    productId: bazaarModelProvider.id,
                                    userId: int.parse(ApiServicesUrl.id),
                                    userType: ApiServicesUrl.userType);

                                await bazaarProvider
                                    .addWishlist(wishlist: wishlist)
                                    .then((value) {
                                  Constant.toastMsg(
                                      msg: "Product Added to Wishlist",
                                      backgroundColor: AppColor.green);
                                  bazaarProvider.fetchBazaarProducts();

                                  return;
                                }).onError((error, stackTrace) {
                                  Constant.toastMsg(
                                      msg: "Something Went Wrong",
                                      backgroundColor: AppColor.red);
                                  return;
                                });
                              },
                              icon: const Icon(
                                Icons.add_circle,
                                size: 15,
                              ),
                              label: const Text("Shortlist"),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(60, 26),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.blackColor,
                            minimumSize: const Size(70, 26),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text("Message"),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size(75, 26),
                              side: const BorderSide(
                                  color: AppColor.primaryColor),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: const Text("Report"))
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
