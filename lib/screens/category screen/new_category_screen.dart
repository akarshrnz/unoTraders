import 'package:codecarrots_unotraders/provider/home_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'list_traders.dart';

class NewCategoryScreen extends StatelessWidget {
  const NewCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(
        appBarTitle: "Category",
        leading: const SizedBox(),
      ),
      body: Consumer<HomeProvider>(
          builder: (BuildContext context, homeProvider, _) {
        return SizedBox(
          child: homeProvider.errorMessage.isNotEmpty
              ? Center(child: TextWidget(data: homeProvider.errorMessage))
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
                                      TextWidget(
                                        data: homeProvider
                                            .allCatList[index].category
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  children: <Widget>[
                                    homeProvider.allCatList[index]
                                                .subcategories ==
                                            null
                                        ? SizedBox()
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: homeProvider
                                                        .allCatList[index]
                                                        .subcategories ==
                                                    null
                                                ? 0
                                                : homeProvider.allCatList[index]
                                                    .subcategories!.length,
                                            itemBuilder: (context, indexSub) {
                                              final subData = homeProvider
                                                  .allCatList[index]
                                                  .subcategories![indexSub];
                                              return ListTile(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child: ListTraders(
                                                            id: subData.id
                                                                .toString(),
                                                            category: subData
                                                                .category!,
                                                          )));
                                                },
                                                title: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15),
                                                  child: TextWidget(
                                                    data: subData.category
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              );
                                            })
                                  ],
                                ),
                            separatorBuilder: (context, index) =>
                                AppConstant.kheight(height: size.width * .03),
                            itemCount: homeProvider.allCatList.length),
                      ),
                    )
                  ],
                ),
        );
      }),
    );
  }
}
