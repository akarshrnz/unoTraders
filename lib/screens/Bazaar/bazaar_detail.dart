import 'package:carousel_slider/carousel_slider.dart';
import 'package:codecarrots_unotraders/model/bazaar_model.dart';
import 'package:codecarrots_unotraders/model/wishlist_model.dart';
import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';
import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BazaarDetail extends StatelessWidget {
  final BazaarModel bazaarModel;
  const BazaarDetail({super.key, required this.bazaarModel});

  @override
  Widget build(BuildContext context) {
    final bazaarProvider = Provider.of<BazaarProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    DateTime date = DateTime.parse(bazaarModel.createdAt!);

    return Scaffold(
      appBar: AppBarWidget(
        appBarTitle: "Bazaar",
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView(shrinkWrap: true, children: [
              Padding(
                padding: EdgeInsets.all(size.width * .02),
                child: SizedBox(
                    child: Card(
                  clipBehavior: Clip.antiAlias,
                  shadowColor: Colors.grey,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider.builder(
                          itemCount: bazaarModel.bazaarimages!.length,
                          itemBuilder: (context, index, realIndex) {
                            return ImgFade.fadeImage(
                                width: size.width,
                                url: bazaarModel.bazaarimages![index]);
                          },
                          options: CarouselOptions(
                            scrollPhysics:
                                bazaarModel.bazaarimages!.length == 1
                                    ? const NeverScrollableScrollPhysics()
                                    : null,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            viewportFraction: 1,
                            height: size.height * .4,
                            autoPlay: bazaarModel.bazaarimages!.length == 1
                                ? false
                                : true,
                            autoPlayInterval: const Duration(seconds: 5),
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * .01, top: size.width * .02),
                        child: textWidget(
                            text: bazaarModel.product!,
                            fontSize: size.width * .04,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: size.width * .01,
                        ),
                        child: textWidget(
                            text: "Posted by :${bazaarModel.addedBy!}",
                            fontSize: size.width * .04,
                            fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * .01, bottom: size.width * .02),
                        child: textWidget(
                            text: bazaarModel.description!,
                            fontSize: size.width * .04,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: size.width * .07,
                            width: size.width * .47,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(size.width * .05),
                                border: Border.all(
                                    color: AppColor.green, width: 1.5)),
                            child: Text(
                              "Posted: ${date.day} ${DateFormat.MMM().format(date)} ${date.year}, ${DateFormat('hh:mm a').format(date)}",
                            ),
                          ),
                          Constant.kWidth(width: size.width * .02),
                          Container(
                            alignment: Alignment.center,
                            height: size.width * .07,
                            width: size.width * .2,
                            decoration: BoxDecoration(
                                color: AppColor.green,
                                borderRadius:
                                    BorderRadius.circular(size.width * .05),
                                border: Border.all(
                                    color: AppColor.green, width: 1.5)),
                            child: const Text("Share",
                                style: TextStyle(
                                  color: AppColor.whiteColor,
                                )),
                          )
                        ],
                      ),
                      Constant.kheight(height: size.width * .02),
                    ],
                  ),
                )),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * .03,
                    top: size.width * .02,
                    bottom: size.width * .02),
                child: textWidget(
                    text: "Related Products",
                    fontSize: size.width * .04,
                    fontWeight: FontWeight.w500),
              ),
              FutureBuilder<List<BazaarModel>>(
                  future: bazaarProvider.fetchBazaarProd(),
                  builder:
                      (context, AsyncSnapshot<List<BazaarModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Something went wrong"),
                        );
                      } else if (snapshot.hasData) {
                        return Container(
                          padding: EdgeInsets.all(size.width * .02),
                          width: size.width,
                          height: size.height * .44,
                          child: ListView.builder(
                            physics:const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              BazaarModel data = snapshot.data![index];
                              DateTime date = DateTime.parse(
                                data.createdAt!);

                              return InkWell(
                                onTap: () {
                                   Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BazaarDetail(
                                                  bazaarModel:data
                                                )));
                                },
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  shadowColor: Colors.grey,
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: size.width * .03,
                                        ),
                                        child: textWidget(
                                            text: data.product ?? "",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: size.width * .03,bottom: size.width * .03,top: size.width * .01
                                        ),
                                        child: textWidget(
                                            text: "Posted: ${date.day} ${DateFormat.MMM().format(date)} ${date.year}, ${DateFormat('hh:mm a').format(date)}",color: AppColor.green
                              ,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: size.width * .016,
                                        ),
                                        child: data.bazaarimages!.isEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.broken_image,
                                                    color: Colors.grey,
                                                  ),
                                                  Text("No image")
                                                ],
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                child: ImgFade.fadeImage(
                                                    height: size.height * .3,
                                                    width: size.width * .5,
                                                    url: data.bazaarimages![0])),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: size.width * .03,
                                        ),
                                        child: ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.check_box,
                                            size: 15,
                                          ),
                                          label:data.wishlist==1?const Text("Shortlisted"): const Text("Shortlist"),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:data.wishlist==1?AppColor.blackColor: AppColor.green,
                                              minimumSize: Size(size.width * .44,
                                                  size.width * .06),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20))),
                                        ),
                                      ),
                                    ],
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
                  })
            ]),
          ),
        ],
      ),
    );
  }

  Text textWidget(
      {required String text,
      required double fontSize,
      required FontWeight fontWeight,Color? color}) {
    return Text(
      text,
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color:color?? AppColor.blackColor,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }
}
