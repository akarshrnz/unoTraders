import 'package:codecarrots_unotraders/provider/trader_update_profile_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileService extends StatefulWidget {
  const ProfileService({super.key});

  @override
  State<ProfileService> createState() => _ProfileServiceState();
}

class _ProfileServiceState extends State<ProfileService> {
  late TraderUpdateProfileProvider provider;
  Map<int, String> selectedSubCategoryId = {};
  Map<int, String> serviceId = {};
  Map<int, String> selectedCategoryId = {};
  bool isLoading = false;
  @override
  void initState() {
    provider = Provider.of<TraderUpdateProfileProvider>(context, listen: false);
    //  categoryController = MultiSelectController();
    //   subCategoryController = MultiSelectController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.assignAllCategories();
      getAllAssignedValues();
      //initialize();
    });
    super.initState();
  }

  getAllAssignedValues() {
    selectedCategoryId = provider.getAssignedCategories();
    selectedSubCategoryId = provider.getAssignedSubCategories();
    serviceId = provider.getAssignedServiceCategories();
    print("categories assined valus>>");
    selectedCategoryId.forEach((key, value) {
      print("key values");
      print(key);
      print(value);
    });
    print("end >>>>>>>>>>>");

    print("sub categories assined valus>>");
    selectedSubCategoryId.forEach((key, value) {
      print("key values");
      print(key);
      print(value);
    });
    print("end >>>>>>>>>>>");

    print("services assined valus>>");
    serviceId.forEach((key, value) {
      print("key values");
      print(key);
      print(value);
    });
    print("end >>>>>>>>>>>");
    print(selectedCategoryId.keys.toList());
    print(selectedSubCategoryId.keys.toList());
    provider.getSubCategoryFromCategory(selectedCategoryId.keys.toList());
    provider.getServicesFromSubCategory(
        subCategoryId: selectedSubCategoryId.keys.toList());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Consumer<TraderUpdateProfileProvider>(
          builder: (BuildContext context, categoryProvider, _) {
        print(categoryProvider.categoryList.length);
        return ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            //category
            AppConstant.kheight(height: 20),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.textColor),
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Category"),
                    InkWell(
                        onTap: () {
                          provider.showDropDown(
                              category: true,
                              subCategory: false,
                              serviceCategory: false);
                        },
                        child: Icon(
                          Icons.arrow_drop_down_sharp,
                        ))
                  ],
                )),
            categoryProvider.showCategoryDropDown == true
                ? SizedBox()
                : categoryProvider.selectedCategoryOptions.keys.toList().isEmpty
                    ? SizedBox()
                    : Container(
                        margin: EdgeInsets.only(
                          top: 12,
                        ),
                        // color: Colors.red,
                        width: size.width,
                        height: 40,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryProvider
                              .selectedCategoryOptions.keys
                              .toList()
                              .length,
                          itemBuilder: (context, index) {
                            final id = categoryProvider
                                .selectedCategoryOptions.keys
                                .toList()[index];
                            return Container(
                              padding: EdgeInsets.only(left: 16, right: 5),
                              margin: EdgeInsets.only(
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                  color: AppColor.green,
                                  borderRadius: BorderRadius.circular(9)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    categoryProvider
                                        .selectedCategoryOptions[id]!,
                                    style: TextStyle(
                                        color: AppColor.whiteColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: InkWell(
                                        onTap: () {
                                          print("remove category id id $id");
                                          print("before remove");
                                          selectedCategoryId
                                              .forEach((key, value) {
                                            print("key values");
                                            print(key);
                                            print(value);
                                          });
                                          provider.removeCategory(id);
                                          print("remove category id id $id");
                                          selectedCategoryId.remove(id);
                                          print("after remove");
                                          selectedCategoryId
                                              .forEach((key, value) {
                                            print("key values");
                                            print(key);
                                            print(value);
                                          });
                                          print("fetch new sub category");

                                          provider.getSubCategoryFromCategory(
                                              selectedCategoryId.keys.toList());
                                          print("end remove category");
                                        },
                                        child: Icon(
                                          Icons.close_sharp,
                                          color: AppColor.whiteColor,
                                        )),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
            AppConstant.kheight(height: 10),

            categoryProvider.showCategoryDropDown == true
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categoryProvider.categoryList.length,
                    itemBuilder: (context, index) => InkWell(
                        onTap: () async {
                          print("category clicked");
                          await provider.addCategory(
                              categoryProvider.categoryList[index].category!,
                              categoryProvider.categoryList[index].id!);
                          selectedCategoryId.putIfAbsent(
                              categoryProvider.categoryList[index].id!,
                              () => categoryProvider
                                  .categoryList[index].category!);
                          provider.getSubCategoryFromCategory(
                              selectedCategoryId.keys.toList());
                          selectedCategoryId.forEach((key, value) {
                            print("key values");
                            print(key);
                            print(value);
                          });
                          print("end clicked");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: AppColor.green)),
                          child: Text(
                              provider.categoryList[index].category.toString()),
                        )))
                : SizedBox(),

            //sub category
            //  AppConstant.kheight(height: 10),
            Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.textColor),
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Sub Category"),
                    InkWell(
                        onTap: () {
                          print("Select Sub Category");
                          provider.showDropDown(
                              category: false,
                              subCategory: true,
                              serviceCategory: false);
                        },
                        child: Icon(
                          Icons.arrow_drop_down_sharp,
                        ))
                  ],
                )),
            categoryProvider.showSubCategoryDropDown == true
                ? SizedBox()
                : categoryProvider.selectedSubCategoryOptions.keys
                        .toList()
                        .isEmpty
                    ? SizedBox()
                    : Container(
                        margin: EdgeInsets.only(
                          top: 12,
                        ),
                        // color: Colors.red,
                        width: size.width,
                        height: 40,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryProvider
                              .selectedSubCategoryOptions.keys
                              .toList()
                              .length,
                          itemBuilder: (context, index) {
                            final id = categoryProvider
                                .selectedSubCategoryOptions.keys
                                .toList()[index];
                            return Container(
                              padding: EdgeInsets.only(left: 16, right: 5),
                              margin: EdgeInsets.only(
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                  color: AppColor.green,
                                  borderRadius: BorderRadius.circular(9)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    categoryProvider
                                        .selectedSubCategoryOptions[id]!,
                                    style: TextStyle(
                                        color: AppColor.whiteColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: InkWell(
                                        onTap: () {
                                          print("remove category");
                                          provider.removeSubCategory(id);
                                          selectedSubCategoryId.remove(id);
                                          print("last sub cat");
                                          selectedSubCategoryId
                                              .forEach((key, value) {
                                            print("key values");
                                            print(key);
                                            print(value);
                                          });
                                          provider.getServicesFromSubCategory(
                                              subCategoryId:
                                                  selectedSubCategoryId.keys
                                                      .toList());
                                        },
                                        child: Icon(
                                          Icons.close_sharp,
                                          color: AppColor.whiteColor,
                                        )),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),

            categoryProvider.showSubCategoryDropDown == true
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categoryProvider.subCategoryList.length,
                    itemBuilder: (context, index) => InkWell(
                        onTap: () async {
                          print("sub category clicked");
                          await provider.addSubCategory(
                              categoryProvider.subCategoryList[index].category!,
                              categoryProvider.subCategoryList[index].id!);
                          selectedSubCategoryId.putIfAbsent(
                              categoryProvider.subCategoryList[index].id!,
                              () => categoryProvider
                                  .subCategoryList[index].category!);
                          print("last sub cat");
                          selectedSubCategoryId.forEach((key, value) {
                            print("key values");
                            print(key);
                            print(value);
                          });
                          provider.getServicesFromSubCategory(
                              subCategoryId:
                                  selectedSubCategoryId.keys.toList());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: AppColor.green)),
                          child: Text(provider.subCategoryList[index].category
                              .toString()),
                        )))
                : SizedBox(),

            //service category
            AppConstant.kheight(height: 10),
            Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.textColor),
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Service Category"),
                    InkWell(
                        onTap: () {
                          print("Select Service Category");
                          provider.showDropDown(
                              category: false,
                              subCategory: false,
                              serviceCategory: true);
                        },
                        child: Icon(
                          Icons.arrow_drop_down_sharp,
                        ))
                  ],
                )),
            categoryProvider.showServiceCategoryDropDown == true
                ? SizedBox()
                : Container(
                    margin: EdgeInsets.only(
                      top: 12,
                    ),
                    // color: Colors.red,
                    width: size.width,
                    height: 40,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          categoryProvider.serviceOptions.keys.toList().length,
                      itemBuilder: (context, index) {
                        final id = categoryProvider.serviceOptions.keys
                            .toList()[index];
                        return Container(
                          padding: EdgeInsets.only(left: 16, right: 5),
                          margin: EdgeInsets.only(
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                              color: AppColor.green,
                              borderRadius: BorderRadius.circular(9)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                categoryProvider.serviceOptions[id]!,
                                style: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: InkWell(
                                    onTap: () {
                                      print("remove service category");
                                      provider.removeServiceCategory(id);
                                      serviceId.remove(id);
                                      print("last sub cat");
                                      serviceId.forEach((key, value) {
                                        print("key values");
                                        print(key);
                                        print(value);
                                      });
                                    },
                                    child: Icon(
                                      Icons.close_sharp,
                                      color: AppColor.whiteColor,
                                    )),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
            categoryProvider.showServiceCategoryDropDown == true
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categoryProvider.traderServicesList.length,
                    itemBuilder: (context, index) => InkWell(
                        onTap: () async {
                          print("service category clicked");
                          await provider.addServiceCategory(
                              categoryProvider
                                  .traderServicesList[index].service!,
                              categoryProvider.traderServicesList[index].id!);
                          serviceId.putIfAbsent(
                              categoryProvider.subCategoryList[index].id!,
                              () => categoryProvider
                                  .traderServicesList[index].service!);
                          print("last sub cat");
                          serviceId.forEach((key, value) {
                            print("key values");
                            print(key);
                            print(value);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: AppColor.green)),
                          child: Text(provider.traderServicesList[index].service
                              .toString()),
                        )))
                : SizedBox(),
            AppConstant.kheight(height: size.width * .03),
            isLoading
                ? Center(child: AppConstant.circularProgressIndicator())
                : DefaultButton(
                    text: "Submit",
                    onPress: () async {
                      setState(() {
                        isLoading = true;
                      });
                      print("satrt>>>>>>>>>");

                      bool res =
                          await provider.updateTraderProfileServicePage();
                      if (res == true) {
                        if (!mounted) return;
                        Navigator.pop(context);
                      } else {}
                      setState(() {
                        isLoading = false;
                      });
                    },
                    radius: size.width * .04),
            AppConstant.kheight(height: size.width * .03)

            // SizedBox(
            //   width: size.width,
            //   child: Stack(
            //     children: [
            //       Container(
            //         width: size.width,
            //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //         decoration: BoxDecoration(
            //           border: Border.all(color: Colors.grey),
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         child: DropdownButtonHideUnderline(
            //           child: DropdownButton<String>(
            //             isDense: true,
            //             value: selectedItems.isNotEmpty
            //                 ? selectedItems.join(', ')
            //                 : null,
            //             onChanged: (val) {},
            //             items: allItems.map((String item) {
            //               return DropdownMenuItem<String>(
            //                 alignment: AlignmentDirectional.bottomEnd,
            //                 value: item,
            //                 child: Row(
            //                   children: <Widget>[
            //                     Checkbox(
            //                       value: selectedItems.contains(item),
            //                       onChanged: (value) {
            //                         toggleItem(item);
            //                       },
            //                     ),
            //                     SizedBox(width: 8),
            //                     Text(item),
            //                   ],
            //                 ),
            //               );
            //             }).toList(),
            //           ),
            //         ),
            //       ),
            //       Positioned(
            //         top: 10,
            //         left: 10,
            //         right: 50,
            //         bottom: 10,
            //         child: Container(
            //           alignment: Alignment.center,
            //           width: size.width,
            //           // height: 50,
            //           color: Colors.red,
            //           child: SingleChildScrollView(
            //             scrollDirection: Axis.horizontal,
            //             child: Row(
            //               children: [
            //                 Text(
            //                   "no data",
            //                   style: TextStyle(color: Colors.white),
            //                 ),
            //                 Text(
            //                   "no data",
            //                   style: TextStyle(color: Colors.white),
            //                 ),
            //                 Text(
            //                   "no data",
            //                   style: TextStyle(color: Colors.white),
            //                 ),
            //                 Text(
            //                   "no data",
            //                   style: TextStyle(color: Colors.white),
            //                 ),
            //                 Container(
            //                   color: Colors.yellow,
            //                   width: 900,
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),

            // ignore: prefer_const_constructors, unnecessary_null_comparison
            // MultiSelectDropDown(
            //         controller: categoryController,
            //         showClearIcon: true,
            //         onOptionSelected: (options) {
            //           selectedCategoryOptions = [];
            //           selectedSubCategoryOptions = [];
            //           serviceOptions = [];
            //           subCategoryController.clearAllSelection();
            //           selectedCategoryOptions = options;
            //           // print(selectedCategoryOptions.length);
            //           // debugPrint(options.toString());
            //           provider.getSubCategoryFromCategory(options);
            //         },
            //         hint: "Select Category",
            //         hintColor: AppColor.textColor,
            //         hintStyle: TextStyle(color: AppColor.textColor),
            //         options: List<ValueItem>.generate(
            //             categoryProvider.categoryList.length,
            //             (index) => ValueItem(
            //                 label: categoryProvider.categoryList[index].category
            //                     .toString(),
            //                 value: categoryProvider.categoryList[index].id
            //                     .toString())).toList(),

            //         // const <ValueItem>[
            //         //   ValueItem(label: 'Option 1', value: '1'),
            //         //   ValueItem(label: 'Option 2', value: '2'),
            //         //   ValueItem(label: 'Option 3', value: '3'),
            //         //   ValueItem(label: 'Option 4', value: '4'),
            //         //   ValueItem(label: 'Option 5', value: '5'),
            //         //   ValueItem(label: 'Option 6', value: '6'),
            //         // ],
            //         selectionType: SelectionType.multi,
            //         chipConfig: const ChipConfig(wrapType: WrapType.wrap),
            //         dropdownHeight: 300,
            //         optionTextStyle: const TextStyle(fontSize: 16),
            //         selectedOptionIcon: const Icon(Icons.check_circle),
            //       ),
            // AppConstant.kheight(height: 20),
            // // ignore: unnecessary_null_comparison
            // MultiSelectDropDown(
            //   controller: subCategoryController,
            //   showClearIcon: true,
            //   onOptionSelected: (options) {
            //     // print("sub cat");
            //     // print(options.length);
            //     // selectedSubCategoryOptions = [];
            //     // selectedCategoryOptions = options;
            //     // serviceOptions = [];
            //     // serviceController.clearAllSelection();
            //     // List<int> subCatId = [];
            //     // if (options.isNotEmpty) {
            //     //   for (var element in options) {
            //     //     if (element.value != null && element.value!.isNotEmpty) {
            //     //       subCatId.add(int.parse(element.value!));
            //     //     }
            //     //   }
            //     // }
            //     // print("length of subcatId ${subCatId.length}");
            //     // if (subCatId.isNotEmpty) {
            //     //   provider.getServicesFromSubCategory(subCategoryId: subCatId);
            //     // }
            //   },
            //   hint: "Select sub category",
            //   hintColor: AppColor.textColor,
            //   hintStyle: TextStyle(color: AppColor.textColor),
            //   options: List<ValueItem>.generate(
            //       categoryProvider.subCategoryList.length,
            //       (index) => ValueItem(
            //           label: categoryProvider.subCategoryList[index].category
            //               .toString(),
            //           value: categoryProvider.subCategoryList[index].id
            //               .toString())).toList(),
            //   selectionType: SelectionType.multi,
            //   chipConfig: const ChipConfig(wrapType: WrapType.wrap),
            //   dropdownHeight: 300,
            //   optionTextStyle: const TextStyle(fontSize: 16),
            //   selectedOptionIcon: const Icon(Icons.check_circle),
            // ),
            // AppConstant.kheight(height: 20),
            // MultiSelectDropDown(
            //   controller: serviceController,
            //   showClearIcon: true,
            //   onOptionSelected: (options) {
            //     serviceOptions = [];
            //     serviceOptions = options;
            //   },
            //   hint: "Select services",
            //   hintColor: AppColor.textColor,
            //   hintStyle: TextStyle(color: AppColor.textColor),
            //   options: List<ValueItem>.generate(
            //       categoryProvider.subCategoryList.length,
            //       (index) => ValueItem(
            //           label: categoryProvider.traderServicesList[index].category
            //               .toString(),
            //           value: categoryProvider.traderServicesList[index].id
            //               .toString())).toList(),
            //   selectionType: SelectionType.multi,
            //   chipConfig: const ChipConfig(wrapType: WrapType.wrap),
            //   dropdownHeight: 300,
            //   optionTextStyle: const TextStyle(fontSize: 16),
            //   selectedOptionIcon: const Icon(Icons.check_circle),
            // )
          ],
        );
      }),
    );
  }
}
