import 'package:codecarrots_unotraders/model/trader_subcategory.dart';
import 'package:codecarrots_unotraders/screens/category%20screen/list_traders.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ViewMoreCategories extends StatelessWidget {
  final List<TraderSubCategory> subCategoryList;
  final String title;
  const ViewMoreCategories(
      {super.key, required this.subCategoryList, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        appBarTitle: title,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
              ),
              shrinkWrap: true,
              itemCount: subCategoryList.length,
              itemBuilder: (context, index) {
                print(subCategoryList[index].category);
                print(subCategoryList[index].id);
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListTraders(
                              id: subCategoryList[index].id.toString(),
                              category: subCategoryList[index].category!,
                            ),
                          ));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.double_arrow,
                          size: 17,
                          color: AppColor.secondaryColor,
                        ),
                        AppConstant.kWidth(width: 5),
                        Text(
                          subCategoryList[index].category!,
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
