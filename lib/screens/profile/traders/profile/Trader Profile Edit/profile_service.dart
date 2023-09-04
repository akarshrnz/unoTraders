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
                :categoryProvider.serviceOptions.keys.toList().isEmpty
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
                              categoryProvider.traderServicesList[index].id!,
                              () => categoryProvider
                                  .traderServicesList[index].service!);
                   
                          serviceId.forEach((key, value) {
                            print("key values below");
                            print("key is $key value is $value");
                            
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
            //AppConstant.kheight(height: size.width * .03),
            AppConstant.kheight(height: 20),
            isLoading
                ? Center(child: AppConstant.circularProgressIndicator())
                : DefaultButton(
                    text: "Submit",
                    onPress: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await submitUpdates();

                      setState(() {
                        isLoading = false;
                      });
                    },
                    radius: size.width * .04),
            AppConstant.kheight(height: size.width * .03)
          ],
        );
      }),
    );
  }

  Future<void> submitUpdates() async {
    bool res = await provider.updateTraderProfileServicePage();
    if (res == true) {
      if (!mounted) return;
      Navigator.pop(context);
    } else {}
  }
}
