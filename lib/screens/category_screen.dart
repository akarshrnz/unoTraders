import 'package:codecarrots_unotraders/model/trader_subcategory.dart';
import 'package:codecarrots_unotraders/model/traders_category_model.dart';
import 'package:codecarrots_unotraders/screens/homepage/components/list_traders.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/services/api_sevices.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<TradersCategoryModel>> traderCategoryList;
  List<TradersCategoryModel> serviceList = [];
  List<TradersCategoryModel> data = [];
  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  fetchApi() async {
    traderCategoryList = ApiServices.getTraderCategory();
    data = await traderCategoryList;
    parentCategory(parentCategory: "Service");
  }

  parentCategory({required String parentCategory}) {
    serviceList = [];
    for (var element in data) {
      if (element.mainCategory == parentCategory) {
        serviceList.add(element);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(appBarTitle: "Category"),
      body: Column(
        children: [
          Flexible(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<TradersCategoryModel>>(
                    future: traderCategoryList,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<TradersCategoryModel>> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Center(child: Text("An error has occured")),
                        );
                      } else if (!snapshot.hasData) {
                        return const SizedBox();
                      } else if (snapshot.hasData) {
                        return ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => ExpansionTile(
                                  title: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.all(size.width * .01),
                                        child: const CircleAvatar(
                                            radius: 11,
                                            backgroundColor: AppColor.green,
                                            child: CircleAvatar(
                                              radius: 9,
                                              backgroundColor: Colors.white,
                                            )),
                                      ),
                                      Text(
                                        serviceList[index].category.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  children: <Widget>[
                                    FutureBuilder<List<TraderSubCategory>>(
                                        future:
                                            ApiServices.getTraderSubCategory(
                                                id: serviceList[index].id!),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<
                                                    List<TraderSubCategory>>
                                                snapshot) {
                                          if (snapshot.hasError) {
                                            return const Center(
                                              child:
                                                  Text("An error has occured"),
                                            );
                                          } else if (snapshot.hasData) {
                                            List<TraderSubCategory> data =
                                                snapshot.data!;
                                            return ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: data.length,
                                                itemBuilder:
                                                    (context, index) =>
                                                        ListTile(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                PageTransition(
                                                                    type: PageTransitionType
                                                                        .fade,
                                                                    child:
                                                                        ListTraders(
                                                                      id: data[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      category:
                                                                          data[index]
                                                                              .category!,
                                                                    )));
                                                            // Navigator.push(
                                                            //     context,
                                                            // MaterialPageRoute(
                                                            //   builder:
                                                            //       (context) =>
                                                            //           ListTraders(
                                                            //     id: data[index]
                                                            //         .id
                                                            //         .toString(),
                                                            //     category: data[
                                                            //             index]
                                                            //         .category!,
                                                            //   ),
                                                            // ));
                                                          },
                                                          title: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15),
                                                            child: Text(
                                                              data[index]
                                                                  .category
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        )
                                                //Column(
                                                //   crossAxisAlignment:
                                                //       CrossAxisAlignment.start,
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment.spaceEvenly,
                                                //   children: [
                                                //     Padding(
                                                //       padding:
                                                //           const EdgeInsets.all(10),
                                                //       child: Row(
                                                //         mainAxisAlignment:
                                                //             MainAxisAlignment.start,
                                                //         children: [
                                                //           const Icon(
                                                //             Icons.double_arrow,
                                                //             size: 14,
                                                //             color: AppColor
                                                //                 .secondaryColor,
                                                //           ),
                                                //           Constant.kWidth(width: 5),
                                                //           Text(data[0].category!),
                                                //         ],
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
                                                );
                                          } else {
                                            return const SizedBox();
                                          }
                                        })
                                    // ListTile(
                                    //   title: Text(
                                    //     items.description,
                                    //     style: TextStyle(fontWeight: FontWeight.w700),
                                    //   ),
                                    // )
                                  ],
                                ),
                            separatorBuilder: (context, index) =>
                                Constant.kheight(height: size.width * .03),
                            itemCount: serviceList.length);
                        // return GridView.builder(
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   gridDelegate:
                        //       const SliverGridDelegateWithFixedCrossAxisCount(
                        //           childAspectRatio: 2 / 1.59,
                        //           crossAxisCount: 2),
                        //   itemCount: serviceList.length,
                        //   itemBuilder: (context, index) {
                        //     return Card(
                        //       clipBehavior: Clip.antiAlias,
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(10)),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         children: [
                        //           Row(
                        //             children: [
                        //               SizedBox(
                        //                 height: 10,
                        //               ),
                        //               Expanded(
                        //                 child: Container(
                        //                   alignment: Alignment.centerLeft,
                        //                   color: Colors.red,
                        //                   height: 40,
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.all(10),
                        //                     child: Text(
                        // serviceList[index]
                        //     .category
                        //     .toString(),
                        //                       style: const TextStyle(
                        //                         color: AppColor.whiteColor,
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //           FutureBuilder<List<TraderSubCategory>>(
                        //               future: ApiServices.getTraderSubCategory(
                        //                   id: serviceList[index].id!),
                        //               builder: (BuildContext context,
                        //                   AsyncSnapshot<List<TraderSubCategory>>
                        //                       snapshot) {
                        //                 if (snapshot.hasError) {
                        //                   return const Center(
                        //                     child: Text("An error has occured"),
                        //                   );
                        //                 } else if (snapshot.hasData) {
                        //                   List<TraderSubCategory> data =
                        //                       snapshot.data!;
                        //                   return Column(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.spaceEvenly,
                        //                     children: [
                        //                       Padding(
                        //                         padding:
                        //                             const EdgeInsets.all(10),
                        //                         child: Row(
                        //                           mainAxisAlignment:
                        //                               MainAxisAlignment.start,
                        //                           children: [
                        //                             const Icon(
                        //                               Icons.double_arrow,
                        //                               size: 14,
                        //                               color: AppColor
                        //                                   .secondaryColor,
                        //                             ),
                        //                             Constant.kWidth(width: 5),
                        //                             Text(data[0].category!),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                       data.length >= 2
                        //                           ? Padding(
                        //                               padding:
                        //                                   const EdgeInsets.all(
                        //                                       10.0),
                        //                               child: Row(
                        //                                 children: [
                        //                                   const Icon(
                        //                                     Icons.double_arrow,
                        //                                     size: 14,
                        //                                     color: AppColor
                        //                                         .secondaryColor,
                        //                                   ),
                        //                                   Constant.kWidth(
                        //                                       width: 5),
                        //                                   Text(data[1]
                        //                                       .category!),
                        //                                 ],
                        //                               ),
                        //                             )
                        //                           : const SizedBox(),
                        //                       Padding(
                        //                         padding:
                        //                             const EdgeInsets.all(8.0),
                        //                         child: Container(
                        //                           alignment:
                        //                               Alignment.centerLeft,
                        //                           width: 100,
                        //                           decoration: BoxDecoration(
                        //                               color: AppColor
                        //                                   .whiteBtnColor,
                        //                               borderRadius:
                        //                                   BorderRadius.circular(
                        //                                       20.0),
                        //                               border: Border.all(
                        //                                 color: AppColor
                        //                                     .secondaryColor,
                        //                               )),
                        //                           child: const Padding(
                        //                             padding:
                        //                                 EdgeInsets.all(8.0),
                        //                             child: Center(
                        //                                 child: Text(
                        //                               'View More',
                        //                               style: TextStyle(
                        //                                   fontWeight:
                        //                                       FontWeight.w500),
                        //                             )),
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   );
                        //                 } else {
                        //                   return const SizedBox();
                        //                 }
                        //               })
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColor.secondaryColor,
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
