import 'package:codecarrots_unotraders/provider/trader_category_provider.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

class ProfileService extends StatefulWidget {
  const ProfileService({super.key});

  @override
  State<ProfileService> createState() => _ProfileServiceState();
}

class _ProfileServiceState extends State<ProfileService> {
  late TraderCategoryProvider provider;
  List<ValueItem> selectedCategoryOptions = [];
  List<ValueItem> selectedSubCategoryOptions = [];
  MultiSelectController? categoryController;
  MultiSelectController? subCategoryController;

  @override
  void initState() {
    super.initState();
    categoryController = MultiSelectController();
    subCategoryController = MultiSelectController();
    provider = Provider.of<TraderCategoryProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.getAllTraderCategory();
      //initialize();
    });
  }

  initialize() {
    categoryController = MultiSelectController();
    subCategoryController = MultiSelectController();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return subCategoryController == null || categoryController == null
        ? SizedBox()
        : Consumer<TraderCategoryProvider>(
            builder: (BuildContext context, categoryProvider, _) {
            print(categoryProvider.categoryList.length);
            return ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                AppConstant.kheight(height: 20),
                // ignore: prefer_const_constructors, unnecessary_null_comparison
                categoryController == null
                    ? SizedBox()
                    : MultiSelectDropDown(
                        controller: categoryController,
                        showClearIcon: true,
                        onOptionSelected: (options) {
                          selectedCategoryOptions = [];
                          subCategoryController!.clearAllSelection();
                          selectedCategoryOptions = options;
                          // print(selectedCategoryOptions.length);
                          // debugPrint(options.toString());
                          provider.getSubCategoryFromCategory(options);
                        },
                        hint: "Select Category",
                        hintColor: AppColor.textColor,
                        hintStyle: TextStyle(color: AppColor.textColor),
                        options: List<ValueItem>.generate(
                            categoryProvider.categoryList.length,
                            (index) => ValueItem(
                                label: categoryProvider
                                    .categoryList[index].category
                                    .toString(),
                                value: categoryProvider.categoryList[index].id
                                    .toString())).toList(),

                        // const <ValueItem>[
                        //   ValueItem(label: 'Option 1', value: '1'),
                        //   ValueItem(label: 'Option 2', value: '2'),
                        //   ValueItem(label: 'Option 3', value: '3'),
                        //   ValueItem(label: 'Option 4', value: '4'),
                        //   ValueItem(label: 'Option 5', value: '5'),
                        //   ValueItem(label: 'Option 6', value: '6'),
                        // ],
                        selectionType: SelectionType.multi,
                        chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                        dropdownHeight: 300,
                        optionTextStyle: const TextStyle(fontSize: 16),
                        selectedOptionIcon: const Icon(Icons.check_circle),
                      ),
                AppConstant.kheight(height: 20),
                // ignore: unnecessary_null_comparison
                subCategoryController == null
                    ? const SizedBox()
                    : MultiSelectDropDown(
                        controller: subCategoryController,
                        showClearIcon: true,
                        onOptionSelected: (options) {},
                        hint: "Select sub category",
                        hintColor: AppColor.textColor,
                        hintStyle: TextStyle(color: AppColor.textColor),
                        options: List<ValueItem>.generate(
                            categoryProvider.subCategoryList.length,
                            (index) => ValueItem(
                                label: categoryProvider
                                    .subCategoryList[index].category
                                    .toString(),
                                value: categoryProvider
                                    .subCategoryList[index].id
                                    .toString())).toList(),
                        selectionType: SelectionType.multi,
                        chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                        dropdownHeight: 300,
                        optionTextStyle: const TextStyle(fontSize: 16),
                        selectedOptionIcon: const Icon(Icons.check_circle),
                      )
              ],
            );
          });
  }
}
