import 'package:codecarrots_unotraders/model/trader_subcategory.dart';
import 'package:codecarrots_unotraders/model/traders_category_model.dart';
import 'package:codecarrots_unotraders/provider/trader_category_provider.dart';
import 'package:codecarrots_unotraders/screens/category%20screen/list_traders.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/api_sevices.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late TraderCategoryProvider provider;
  // late Future<List<TradersCategoryModel>> traderCategoryList;
  // List<TradersCategoryModel> serviceList = [];
  // List<TradersCategoryModel> data = [];
  @override
  void initState() {
    provider = Provider.of<TraderCategoryProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.getAllTraderCategory();
    });
    super.initState();
    // fetchApi();
  }

  // fetchApi() async {
  //   traderCategoryList = ApiServices.getTraderCategory();
  //   data = await traderCategoryList;
  //   parentCategory(parentCategory: "Service");
  // }

  // parentCategory({required String parentCategory}) {
  //   serviceList = [];
  // for (var element in data) {
  //   if (element.mainCategory == parentCategory) {
  //     serviceList.add(element);
  //   }
  // }
  // }

  @override
  Widget build(BuildContext context) {
    print("category build");
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(
        appBarTitle: "Category",
        leading: const SizedBox(),
      ),
      body: Consumer<TraderCategoryProvider>(
          builder: (BuildContext context, categoryProvider, _) {
        return categoryProvider.isLoading
            ? categoryProvider.errorMessage.isNotEmpty
                ? Container(
                    width: size.width,
                    height: size.height,
                    child: Center(
                      child: TextWidget(data: categoryProvider.errorMessage),
                    ),
                  )
                : Container(
                    width: size.width,
                    height: size.height,
                    child: AppConstant.circularProgressIndicator())
            : Column(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ExpansionTile(
                                title: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(size.width * .01),
                                      child: const CircleAvatar(
                                          radius: 11,
                                          backgroundColor: AppColor.green,
                                          child: CircleAvatar(
                                            radius: 9,
                                            backgroundColor: Colors.white,
                                          )),
                                    ),
                                    TextWidget(
                                      data: categoryProvider
                                          .serviceList[index].category
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                children: <Widget>[
                                  FutureBuilder<List<TraderSubCategory>>(
                                      future: ApiServices.getTraderSubCategory(
                                          id: categoryProvider
                                              .serviceList[index].id!),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<List<TraderSubCategory>>
                                              snapshot) {
                                        if (snapshot.hasError) {
                                          return Center(
                                            child: TextWidget(
                                                data: "An error has occurred"),
                                          );
                                        } else if (snapshot.hasData) {
                                          List<TraderSubCategory> data =
                                              snapshot.data!;
                                          return ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: data.length,
                                              itemBuilder: (context, index) =>
                                                  ListTile(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              child:
                                                                  ListTraders(
                                                                id: data[index]
                                                                    .id
                                                                    .toString(),
                                                                category: data[
                                                                        index]
                                                                    .category!,
                                                              )));
                                                    },
                                                    title: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15),
                                                      child: TextWidget(
                                                        data: data[index]
                                                            .category
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ));
                                        } else {
                                          return const SizedBox();
                                        }
                                      })
                                ],
                              ),
                          separatorBuilder: (context, index) =>
                              AppConstant.kheight(height: size.width * .03),
                          itemCount: categoryProvider.serviceList.length),
                    ),
                  )
                ],
              );
      }),
    );
  }
}
