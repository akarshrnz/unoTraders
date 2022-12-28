import 'dart:io';

import 'package:codecarrots_unotraders/screens/job/customer%20job%20screen/quote_result.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/main.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/provider/location_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/default_button.dart';

class PostJob extends StatefulWidget {
  final bool? isUpdatejob;
  const PostJob({super.key, this.isUpdatejob});

  @override
  State<PostJob> createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {
  final _formKey = GlobalKey<FormState>();
  late JobProvider jobProvider;
  late LocationProvider locationProvider;
  late ImagePickProvider imageProvider;
  late FocusNode nameFocus;
  late FocusNode phoneFocus;
  late FocusNode titleFocus;
  late FocusNode budgetFocus;
  late FocusNode locationFocus;
  late FocusNode descriptionFocus;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController budgetController;

  String? selectedCompletion;
  bool materialChecked = false;
  bool _postJobLoading = false;
  bool _seekQuoteLoading = false;
  bool _savePostLoading = false;

  initalization() {
    nameFocus = FocusNode();
    phoneFocus = FocusNode();
    titleFocus = FocusNode();
    budgetFocus = FocusNode();
    descriptionFocus = FocusNode();
    locationFocus = FocusNode();
    nameController = TextEditingController(text: sp!.getString('userName'));
    phoneController = TextEditingController(text: sp!.getString('mobile'));
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    budgetController = TextEditingController();
    locationController = TextEditingController();
  }

  clearField() {
    titleController.clear();
    descriptionController.clear();
    budgetController.clear();
    locationController.clear();
    selectedCompletion = null;
    materialChecked = false;
    jobProvider.clearCategories();
    locationProvider.clearAll();
    imageProvider.clearImage();
    nameFocus.unfocus();
    phoneFocus.unfocus();
    titleFocus.unfocus();
    budgetFocus.unfocus();
    descriptionFocus.unfocus();
    locationFocus.unfocus();
  }

  @override
  void dispose() {
    nameFocus.dispose();
    phoneFocus.dispose();
    titleFocus.dispose();
    budgetFocus.dispose();
    descriptionFocus.dispose();
    locationFocus.dispose();
    nameController.dispose();
    phoneController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    budgetController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initalization();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      jobProvider = Provider.of<JobProvider>(context, listen: false);
      imageProvider = Provider.of<ImagePickProvider>(context, listen: false);
      locationProvider = Provider.of<LocationProvider>(context, listen: false);
      locationProvider.initalizeLocation();
      locationProvider.clearAll();
      jobProvider.clear();
      imageProvider.clearImage();
      fetchData();
    });
  }

  fetchData() async {
    await jobProvider.fetchCategory();
    if (widget.isUpdatejob != null) {}
  }

  List<String> completionDropDown = [
    'Urgent',
    'in 2 Days',
    'in 1 Week',
    'in 1 Month'
  ];
  Map<String, String> status = {
    'saved': 'Saved',
    'published': 'Published',
    'seekQuote': 'Seek Quote'
  };
  @override
  Widget build(BuildContext context) {
    final imagePickProvider =
        Provider.of<ImagePickProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(appBarTitle: "Post a Job"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 23),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Text(
                        "Post Your job Here",
                        style: TextStyle(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Constant.kheight(height: 20),
                      //name
                      columnWidget(
                          widgetOne: const Text("Name"),
                          widgetTwo: TextFieldWidget(
                              focusNode: nameFocus,
                              controller: nameController,
                              enabled: false,
                              hintText: "Name",
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (p0) {
                                nameFocus.unfocus();
                                FocusScope.of(context).requestFocus(phoneFocus);
                              },
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                } else {
                                  return null;
                                }
                              })),
                      columnWidget(
                        widgetOne: const Text("Phone"),
                        widgetTwo: TextFieldWidget(
                            focusNode: phoneFocus,
                            enabled: false,
                            controller: phoneController,
                            hintText: "Phone",
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (p0) {
                              phoneFocus.unfocus();
                              FocusScope.of(context).requestFocus(phoneFocus);
                            },
                            onEditingComplete: () =>
                                FocusScope.of(context).nextFocus(),
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              } else if (value.length < 10) {
                                return "Please enter a valid phone number";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      //category
                      columnWidget(
                        widgetOne: const Text("Category"),
                        widgetTwo: Consumer<JobProvider>(
                            builder: (context, provider, _) {
                          return Container(
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonFormField(
                                isExpanded: true,
                                hint: const Text("Category"),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.blackColor)),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return "This field is required";
                                  }
                                  return null;
                                },
                                value: provider.selectedcategory,
                                items: provider.categoryErrorMessage.isNotEmpty
                                    ? [
                                        DropdownMenuItem(
                                          value: provider.categoryErrorMessage,
                                          child: Text(
                                            provider.categoryErrorMessage,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ]
                                    : provider.categoryList.map((e) {
                                        return DropdownMenuItem(
                                          value: e.category,
                                          child: Text(e.category!),
                                        );
                                      }).toList(),
                                onChanged: (value) {
                                  if (provider.categoryErrorMessage.isEmpty) {
                                    provider.changeCategory(
                                        categoryName: value.toString());
                                  }
                                }),
                          );
                        }),
                      ),

                      //sub category
                      columnWidget(
                        widgetOne: const Text("Sub Category"),
                        widgetTwo: Consumer<JobProvider>(
                            builder: (context, provider, _) {
                          return Container(
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonFormField(
                                isExpanded: true,
                                hint: const Text("Category"),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.blackColor)),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      provider
                                          .subCategoryErrorMessage.isNotEmpty) {
                                    return "This field is required";
                                  }
                                  return null;
                                },
                                value: provider.selectedSubCategory,
                                items: provider
                                        .subCategoryErrorMessage.isNotEmpty
                                    ? [
                                        DropdownMenuItem(
                                          value:
                                              provider.subCategoryErrorMessage,
                                          child: Text(
                                            provider.subCategoryErrorMessage,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ]
                                    : provider.subCategoryList.map((e) {
                                        return DropdownMenuItem(
                                          value: e.category,
                                          child: Text(e.category!),
                                        );
                                      }).toList(),
                                onChanged: (value) {
                                  if (provider
                                      .subCategoryErrorMessage.isEmpty) {
                                    provider.changeSubCategory(
                                        categoryName: value.toString());
                                  }
                                }),
                          );
                        }),
                      ),

                      columnWidget(
                        widgetOne: const Text("Title"),
                        widgetTwo: TextFieldWidget(
                            focusNode: titleFocus,
                            controller: titleController,
                            hintText: "Title",
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (p0) {
                              titleFocus.unfocus();
                              FocusScope.of(context).requestFocus(phoneFocus);
                            },
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      columnWidget(
                        widgetOne: const Text("Description"),
                        widgetTwo: TextFieldWidget(
                            focusNode: descriptionFocus,
                            controller: descriptionController,
                            hintText: "Description about work",
                            maxLines: 5,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (p0) {
                              titleFocus.unfocus();
                              FocusScope.of(context).requestFocus(phoneFocus);
                            },
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      columnWidget(
                        widgetOne: const Text("Budget"),
                        widgetTwo: TextFieldWidget(
                            focusNode: budgetFocus,
                            controller: budgetController,
                            hintText: "Budget/price",
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (p0) {
                              titleFocus.unfocus();
                              FocusScope.of(context).requestFocus(phoneFocus);
                            },
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      //time of completion
                      columnWidget(
                        widgetOne: const Text("Time for Completion"),
                        widgetTwo: Container(
                          decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButtonFormField(
                              hint: const Text("Select"),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.blackColor)),
                                contentPadding: EdgeInsets.all(10),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return "This field is required";
                                }
                                return null;
                              },
                              value: selectedCompletion,
                              items: completionDropDown.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedCompletion = value.toString();
                                });
                              }),
                        ),
                      ),

                      columnWidget(
                        widgetOne: Text("Location"),
                        widgetTwo: TextFieldWidget(
                            focusNode: locationFocus,
                            controller: locationController,
                            hintText: "Location",
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                locationProvider.autocompleteSearch(
                                    search: value);
                              } else {
                                locationProvider.clearAll();
                              }
                            },
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (p0) {
                              locationFocus.unfocus();
                            },
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      Consumer<LocationProvider>(
                          builder: (context, locProvider, _) {
                        return locProvider.predictions.isEmpty ||
                                locationController.text.toString().isEmpty
                            ? const SizedBox(
                                height: 0,
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: locProvider.predictions.length,
                                itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        locationFocus.unfocus();
                                        locationProvider.onSelected(
                                            value:
                                                locProvider.predictions[index]);
                                        locationController.text = locProvider
                                            .selected!.description
                                            .toString();
                                        locationProvider.clearPrediction();
                                      },
                                      child: ListTile(
                                        leading: const Icon(
                                          Icons.location_on,
                                          color: AppColor.primaryColor,
                                        ),
                                        title: Text(locProvider
                                            .predictions[index].description
                                            .toString()),
                                      ),
                                    ));
                      }),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Consumer<LocationProvider>(
                            builder: (context, locProvider, _) {
                          return locProvider.locationError.isNotEmpty
                              ? Text(
                                  locProvider.locationError,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.red),
                                )
                              : const SizedBox();
                        }),
                      ),
                      Consumer<ImagePickProvider>(
                          builder: (context, imageProvider, _) {
                        return imageProvider.images.isEmpty == true
                            ? Constant.kheight(height: 10)
                            : Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                height: imageProvider.images.isEmpty == true
                                    ? 0
                                    : 190,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: AppColor.whiteColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  // gridDelegate:
                                  //     const SliverGridDelegateWithFixedCrossAxisCount(
                                  //   crossAxisCount: 2,
                                  // ),
                                  itemCount: imageProvider.images.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: Image.file(
                                              File(imageProvider
                                                  .images[index].path),
                                              height: 190,
                                              width: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 1,
                                            child: IconButton(
                                                onPressed: () {
                                                  imageProvider.remove(index);
                                                },
                                                icon: const Icon(
                                                    Icons.cancel_outlined)),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                      }),

                      SizedBox(
                        height: 45,
                        child: ElevatedButton.icon(
                          label: Text(
                            "Add photo",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          onPressed: () {
                            imagePickProvider.pickImage();
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              alignment: Alignment.centerLeft,
                              side: const BorderSide(
                                color: Colors.grey,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              backgroundColor: AppColor.whiteColor),
                          icon: const FaIcon(
                            FontAwesomeIcons.images,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Constant.kheight(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: materialChecked,
                              onChanged: (value) {
                                setState(() {
                                  materialChecked = value!;
                                });
                              },
                            ),
                          ),
                          const Text(" Materials Purchased")
                        ],
                      ),
                      Constant.kheight(height: 5),

                      // _seekQuoteLoading == true
                      //     ? Constant.circularProgressIndicator()
                      //     :

                      Consumer<JobProvider>(builder: (context, jProvider, _) {
                        return jProvider.isLoading == true
                            ? Constant.circularProgressIndicator()
                            : Consumer<LocationProvider>(
                                builder: (context, locProvider, _) {
                                return DefaultButton(
                                  height: 45,
                                  text: "Seek Quote",
                                  onPress: () async {
                                    // setState(() {
                                    //   _seekQuoteLoading = true;
                                    // });
                                    //seekQuote
                                    if (_formKey.currentState!.validate()) {
                                      // ignore: avoid_print
                                      print("valid");
                                      bool res = await jobProvider.postSavedJob(
                                          customerId:
                                              int.parse(sp!.getString('id')!),
                                          jobTitle: titleController.text
                                              .trim()
                                              .toString(),
                                          jobDescription: descriptionController
                                              .text
                                              .trim()
                                              .toString(),
                                          budget: budgetController.text
                                              .trim()
                                              .toString(),
                                          timeForCompletion:
                                              selectedCompletion!,
                                          location: locationController.text
                                              .toString(),
                                          locationLatitude:
                                              locProvider.latitude,
                                          locationLongitude:
                                              locProvider.longitude,
                                          materialPurchased:
                                              materialChecked == true
                                                  ? '1'
                                                  : '0',
                                          jobimages:
                                              imagePickProvider.imageFile,
                                          jobStatus: status['seekQuote']!,
                                          context: context);
                                      if (res == true) {
                                        clearField();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  QuoteResults(jobId: "60"),
                                            ));
                                      } else {
                                        Constant.toastMsg(
                                            msg: "Something Went Wrong",
                                            backgroundColor: AppColor.red);
                                      }

                                      // try {
                                      //   await jobProvider
                                      //       .postJob(
                                      //           customerId: int.parse(
                                      //               sp!.getString('id')!),
                                      //           jobTitle: titleController.text
                                      //               .trim()
                                      //               .toString(),
                                      //           jobDescription:
                                      //               descriptionController.text
                                      //                   .trim()
                                      //                   .toString(),
                                      //           budget: budgetController.text
                                      //               .trim()
                                      //               .toString(),
                                      //           timeForCompletion:
                                      //               selectedCompletion!,
                                      //           location: locationController
                                      //               .text
                                      //               .toString(),
                                      //           locationLatitude:
                                      //               locProvider.latitude,
                                      //           locationLongitude:
                                      //               locProvider.longitude,
                                      //           materialPurchased:
                                      //               materialChecked == true
                                      //                   ? '1'
                                      //                   : '0',
                                      //           jobimages:
                                      //               imagePickProvider.imageFile,
                                      //           jobStatus: status['seekQuote']!,
                                      //           context: context);
                                      //            Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 QuoteResults(
                                      //                     jobId:
                                      //                         "60"),
                                      //           ));
                                      //   //     .then((value) {
                                      //   //        Navigator.push(
                                      //   //         context,
                                      //   //         MaterialPageRoute(
                                      //   //           builder: (context) =>
                                      //   //               QuoteResults(
                                      //   //                   jobId:
                                      //   //                       jProvider.jobId),
                                      //   //         ));
                                      //   //   // if (jProvider.jobId.isNotEmpty) {

                                      //   //   //   clearField();
                                      //   //   // }
                                      //   //   return true;
                                      //   // });
                                      // } catch (e) {
                                      //   Constant.toastMsg(
                                      //       msg: "Something Went Wrong",
                                      //       backgroundColor: AppColor.red);
                                      // }
                                      setState(() {
                                        _seekQuoteLoading = false;
                                      });
                                    } else {
                                      // ignore: avoid_print
                                      print("in valid");
                                      Constant.toastMsg(
                                          msg:
                                              "Please make sure all fields are filled in correctly",
                                          backgroundColor: AppColor.red);
                                    }
                                  },
                                  radius: 5,
                                  backgroundColor: Colors.green,
                                );
                              });
                      }),
                      Constant.kheight(height: 5),
                      _postJobLoading == true
                          ? Constant.circularProgressIndicator()
                          : Consumer<LocationProvider>(
                              builder: (context, locProvider, _) {
                              return DefaultButton(
                                height: 45,
                                text: "Post Job",
                                onPress: () async {
                                  setState(() {
                                    _postJobLoading = true;
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    // ignore: avoid_print
                                    print("valid");

                                    await jobProvider
                                        .postJob(
                                            customerId:
                                                int.parse(sp!.getString('id')!),
                                            jobTitle: titleController.text
                                                .trim()
                                                .toString(),
                                            jobDescription:
                                                descriptionController.text
                                                    .trim()
                                                    .toString(),
                                            budget: budgetController.text
                                                .trim()
                                                .toString(),
                                            timeForCompletion:
                                                selectedCompletion!,
                                            location: locationController.text
                                                .toString(),
                                            locationLatitude:
                                                locProvider.latitude,
                                            locationLongitude:
                                                locProvider.longitude,
                                            materialPurchased:
                                                materialChecked == true
                                                    ? '1'
                                                    : '0',
                                            jobimages:
                                                imagePickProvider.imageFile,
                                            jobStatus: status['published']!,
                                            context: context)
                                        .then((value) {
                                      clearField();
                                      Constant.toastMsg(
                                          msg: "Job Posted Sucessfully",
                                          backgroundColor:
                                              AppColor.primaryColor);
                                    }).onError((error, stackTrace) {
                                      Constant.toastMsg(
                                          msg: error.toString(),
                                          backgroundColor: AppColor.red);
                                      return;
                                    });
                                  } else {
                                    // ignore: avoid_print
                                    print("in valid");
                                    Constant.toastMsg(
                                        msg:
                                            "Please make sure all fields are filled in correctly",
                                        backgroundColor: AppColor.red);
                                  }
                                  setState(() {
                                    _postJobLoading = false;
                                  });
                                },
                                radius: 5,
                                backgroundColor: AppColor.blackColor,
                              );
                            }),
                      Constant.kheight(height: 5),
                      _savePostLoading == true
                          ? Constant.circularProgressIndicator()
                          : Consumer<LocationProvider>(
                              builder: (context, locProvider, _) {
                              return DefaultButton(
                                height: 45,
                                text: "Save & Post Later",
                                onPress: () async {
                                  setState(() {
                                    _savePostLoading = true;
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    // ignore: avoid_print
                                    print("valid");

                                    await jobProvider
                                        .postJob(
                                            customerId:
                                                int.parse(sp!.getString('id')!),
                                            jobTitle: titleController.text
                                                .trim()
                                                .toString(),
                                            jobDescription:
                                                descriptionController.text
                                                    .trim()
                                                    .toString(),
                                            budget: budgetController.text
                                                .trim()
                                                .toString(),
                                            timeForCompletion:
                                                selectedCompletion!,
                                            location: locationController.text
                                                .toString(),
                                            locationLatitude:
                                                locProvider.latitude,
                                            locationLongitude:
                                                locProvider.longitude,
                                            materialPurchased:
                                                materialChecked == true
                                                    ? '1'
                                                    : '0',
                                            jobimages:
                                                imagePickProvider.imageFile,
                                            jobStatus: status['saved']!,
                                            context: context)
                                        .then((value) {
                                      clearField();
                                      Constant.toastMsg(
                                          msg: "Job Saved Sucessfully",
                                          backgroundColor:
                                              AppColor.primaryColor);
                                    }).onError((error, stackTrace) {
                                      Constant.toastMsg(
                                          msg: "Something Went Wrong",
                                          backgroundColor: AppColor.red);
                                      return;
                                    });
                                  } else {
                                    // ignore: avoid_print
                                    print("in valid");
                                    Constant.toastMsg(
                                        msg:
                                            "Please make sure all fields are filled in correctly",
                                        backgroundColor: AppColor.red);
                                  }
                                  setState(() {
                                    _savePostLoading = false;
                                  });
                                },
                                radius: 5,
                                backgroundColor: Colors.green,
                              );
                            }),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column columnWidget({required Widget widgetOne, required Widget widgetTwo}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widgetOne,
        Constant.kheight(height: 5),
        widgetTwo,
      ],
    );
  }
}



//copy
// import 'dart:io';

// import 'package:codecarrots_unotraders/screens/job/customer%20job%20screen/quote_result.dart';
// import 'package:codecarrots_unotraders/utils/color.dart';
// import 'package:codecarrots_unotraders/main.dart';
// import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
// import 'package:codecarrots_unotraders/provider/job_provider.dart';
// import 'package:codecarrots_unotraders/provider/location_provider.dart';
// import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
// import 'package:codecarrots_unotraders/utils/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'package:provider/provider.dart';

// import '../../widgets/app_bar.dart';
// import '../../widgets/default_button.dart';

// class PostJob extends StatefulWidget {
//   const PostJob({super.key});

//   @override
//   State<PostJob> createState() => _PostJobState();
// }

// class _PostJobState extends State<PostJob> {
//   final _formKey = GlobalKey<FormState>();
//   late JobProvider jobProvider;
//   late LocationProvider locationProvider;
//   late ImagePickProvider imageProvider;
//   late FocusNode nameFocus;
//   late FocusNode phoneFocus;
//   late FocusNode titleFocus;
//   late FocusNode budgetFocus;
//   late FocusNode locationFocus;
//   late FocusNode descriptionFocus;
//   late TextEditingController nameController;
//   late TextEditingController phoneController;
//   late TextEditingController titleController;
//   late TextEditingController descriptionController;
//   late TextEditingController locationController;
//   late TextEditingController budgetController;

//   String? selectedCompletion;
//   bool materialChecked = false;
//   bool _postJobLoading = false;
//   bool _seekQuoteLoading = false;
//   bool _savePostLoading = false;

//   initalization() {
//     nameFocus = FocusNode();
//     phoneFocus = FocusNode();
//     titleFocus = FocusNode();
//     budgetFocus = FocusNode();
//     descriptionFocus = FocusNode();
//     locationFocus = FocusNode();
//     nameController = TextEditingController(text: sp!.getString('userName'));
//     phoneController = TextEditingController(text: sp!.getString('mobile'));
//     titleController = TextEditingController();
//     descriptionController = TextEditingController();
//     budgetController = TextEditingController();
//     locationController = TextEditingController();
//   }

//   clearField() {
//     titleController.clear();
//     descriptionController.clear();
//     budgetController.clear();
//     locationController.clear();
//     selectedCompletion = null;
//     materialChecked = false;
//     jobProvider.clearCategories();
//     locationProvider.clearAll();
//     imageProvider.clearImage();
//      nameFocus .unfocus();
//     phoneFocus .unfocus();
//     titleFocus .unfocus();
//     budgetFocus .unfocus();
//     descriptionFocus .unfocus();
//     locationFocus .unfocus();
//   }

//   @override
//   void dispose() {
//     nameFocus.dispose();
//     phoneFocus.dispose();
//     titleFocus.dispose();
//     budgetFocus.dispose();
//     descriptionFocus.dispose();
//     locationFocus.dispose();
//     nameController.dispose();
//     phoneController.dispose();
//     titleController.dispose();
//     descriptionController.dispose();
//     budgetController.dispose();
//     locationController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     initalization();
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       jobProvider = Provider.of<JobProvider>(context, listen: false);
//       imageProvider = Provider.of<ImagePickProvider>(context, listen: false);
//       locationProvider = Provider.of<LocationProvider>(context, listen: false);
//       locationProvider.initalizeLocation();
//       locationProvider.clearAll();
//       jobProvider.clear();
//       imageProvider.clearImage();
//       jobProvider.fetchCategory();
//     });
//   }

//   List<String> completionDropDown = [
//     'Urgent',
//     'in 2 Days',
//     'in 1 Week',
//     'in 1 Month'
//   ];
//   Map<String, String> status = {
//     'saved': 'Saved',
//     'published': 'Published',
//     'seekQuote': 'Seek Quote'
//   };
//   @override
//   Widget build(BuildContext context) {
//     final imagePickProvider =
//         Provider.of<ImagePickProvider>(context, listen: false);
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBarWidget(appBarTitle: "Post a Job"),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Flexible(
//               child: Form(
//                 key: _formKey,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 20, top: 23),
//                   child: ListView(
//                     shrinkWrap: true,
//                     children: [
//                       const Text(
//                         "Post Your job Here",
//                         style: TextStyle(
//                             color: AppColor.blackColor,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       Constant.kheight(height: 20),
//                       //name
//                       columnWidget(
//                           widgetOne: const Text("Name"),
//                           widgetTwo: TextFieldWidget(
//                               focusNode: nameFocus,
//                               controller: nameController,
//                               enabled: false,
//                               hintText: "Name",
//                               textInputAction: TextInputAction.next,
//                               onFieldSubmitted: (p0) {
//                                 nameFocus.unfocus();
//                                 FocusScope.of(context).requestFocus(phoneFocus);
//                               },
//                               validate: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return "This field is required";
//                                 } else {
//                                   return null;
//                                 }
//                               })),
//                       columnWidget(
//                         widgetOne: const Text("Phone"),
//                         widgetTwo: TextFieldWidget(
//                             focusNode: phoneFocus,
//                             enabled: false,
//                             controller: phoneController,
//                             hintText: "Phone",
//                             keyboardType:
//                                 const TextInputType.numberWithOptions(),
//                             textInputAction: TextInputAction.next,
//                             onFieldSubmitted: (p0) {
//                               phoneFocus.unfocus();
//                               FocusScope.of(context).requestFocus(phoneFocus);
//                             },
//                             onEditingComplete: () =>
//                                 FocusScope.of(context).nextFocus(),
//                             validate: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return "This field is required";
//                               } else if (value.length < 10) {
//                                 return "Please enter a valid phone number";
//                               } else {
//                                 return null;
//                               }
//                             }),
//                       ),
//                       //category
//                       columnWidget(
//                         widgetOne: const Text("Category"),
//                         widgetTwo: Consumer<JobProvider>(
//                             builder: (context, provider, _) {
//                           return Container(
//                             decoration: BoxDecoration(
//                                 color: AppColor.whiteColor,
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: DropdownButtonFormField(
//                                 isExpanded: true,
//                                 hint: const Text("Category"),
//                                 decoration: const InputDecoration(
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppColor.blackColor)),
//                                   contentPadding: EdgeInsets.all(10),
//                                 ),
//                                 validator: (value) {
//                                   if (value == null) {
//                                     return "This field is required";
//                                   }
//                                   return null;
//                                 },
//                                 value: provider.selectedcategory,
//                                 items: provider.categoryErrorMessage.isNotEmpty
//                                     ? [
//                                         DropdownMenuItem(
//                                           value: provider.categoryErrorMessage,
//                                           child: Text(
//                                             provider.categoryErrorMessage,
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         )
//                                       ]
//                                     : provider.categoryList.map((e) {
//                                         return DropdownMenuItem(
//                                           value: e.category,
//                                           child: Text(e.category!),
//                                         );
//                                       }).toList(),
//                                 onChanged: (value) {
//                                   if (provider.categoryErrorMessage.isEmpty) {
//                                     provider.changeCategory(
//                                         categoryName: value.toString());
//                                   }
//                                 }),
//                           );
//                         }),
//                       ),

//                       //sub category
//                       columnWidget(
//                         widgetOne: const Text("Sub Category"),
//                         widgetTwo: Consumer<JobProvider>(
//                             builder: (context, provider, _) {
//                           return Container(
//                             decoration: BoxDecoration(
//                                 color: AppColor.whiteColor,
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: DropdownButtonFormField(
//                                 isExpanded: true,
//                                 hint: const Text("Category"),
//                                 decoration: const InputDecoration(
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppColor.blackColor)),
//                                   contentPadding: EdgeInsets.all(10),
//                                 ),
//                                 validator: (value) {
//                                   if (value == null ||
//                                       provider
//                                           .subCategoryErrorMessage.isNotEmpty) {
//                                     return "This field is required";
//                                   }
//                                   return null;
//                                 },
//                                 value: provider.selectedSubCategory,
//                                 items: provider
//                                         .subCategoryErrorMessage.isNotEmpty
//                                     ? [
//                                         DropdownMenuItem(
//                                           value:
//                                               provider.subCategoryErrorMessage,
//                                           child: Text(
//                                             provider.subCategoryErrorMessage,
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         )
//                                       ]
//                                     : provider.subCategoryList.map((e) {
//                                         return DropdownMenuItem(
//                                           value: e.category,
//                                           child: Text(e.category!),
//                                         );
//                                       }).toList(),
//                                 onChanged: (value) {
//                                   if (provider
//                                       .subCategoryErrorMessage.isEmpty) {
//                                     provider.changeSubCategory(
//                                         categoryName: value.toString());
//                                   }
//                                 }),
//                           );
//                         }),
//                       ),

//                       columnWidget(
//                         widgetOne: const Text("Title"),
//                         widgetTwo: TextFieldWidget(
//                             focusNode: titleFocus,
//                             controller: titleController,
//                             hintText: "Title",
//                             textInputAction: TextInputAction.next,
//                             onFieldSubmitted: (p0) {
//                               titleFocus.unfocus();
//                               FocusScope.of(context).requestFocus(phoneFocus);
//                             },
//                             validate: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return "This field is required";
//                               } else {
//                                 return null;
//                               }
//                             }),
//                       ),
//                       columnWidget(
//                         widgetOne: const Text("Description"),
//                         widgetTwo: TextFieldWidget(
//                             focusNode: descriptionFocus,
//                             controller: descriptionController,
//                             hintText: "Description about work",
//                             maxLines: 5,
//                             textInputAction: TextInputAction.next,
//                             onFieldSubmitted: (p0) {
//                               titleFocus.unfocus();
//                               FocusScope.of(context).requestFocus(phoneFocus);
//                             },
//                             validate: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return "This field is required";
//                               } else {
//                                 return null;
//                               }
//                             }),
//                       ),
//                       columnWidget(
//                         widgetOne: const Text("Budget"),
//                         widgetTwo: TextFieldWidget(
//                             focusNode: budgetFocus,
//                             controller: budgetController,
//                             hintText: "Budget/price",
//                             textInputAction: TextInputAction.next,
//                             onFieldSubmitted: (p0) {
//                               titleFocus.unfocus();
//                               FocusScope.of(context).requestFocus(phoneFocus);
//                             },
//                             validate: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return "This field is required";
//                               } else {
//                                 return null;
//                               }
//                             }),
//                       ),
//                       //time of completion
//                       columnWidget(
//                         widgetOne: const Text("Time for Completion"),
//                         widgetTwo: Container(
//                           decoration: BoxDecoration(
//                               color: AppColor.whiteColor,
//                               borderRadius: BorderRadius.circular(10)),
//                           child: DropdownButtonFormField(
//                               hint: const Text("Select"),
//                               decoration: const InputDecoration(
//                                 border: OutlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: AppColor.blackColor)),
//                                 contentPadding: EdgeInsets.all(10),
//                               ),
//                               validator: (value) {
//                                 if (value == null) {
//                                   return "This field is required";
//                                 }
//                                 return null;
//                               },
//                               value: selectedCompletion,
//                               items: completionDropDown.map((item) {
//                                 return DropdownMenuItem(
//                                   value: item,
//                                   child: Text(item),
//                                 );
//                               }).toList(),
//                               onChanged: (value) {
//                                 setState(() {
//                                   selectedCompletion = value.toString();
//                                 });
//                               }),
//                         ),
//                       ),

//                       columnWidget(
//                         widgetOne: Text("Location"),
//                         widgetTwo: TextFieldWidget(
//                             focusNode: locationFocus,
//                             controller: locationController,
//                             hintText: "Location",
//                             onChanged: (value) {
//                               if (value.isNotEmpty) {
//                                 locationProvider.autocompleteSearch(
//                                     search: value);
//                               } else {
//                                 locationProvider.clearAll();
//                               }
//                             },
//                             textInputAction: TextInputAction.next,
//                             onFieldSubmitted: (p0) {
//                               locationFocus.unfocus();
//                             },
//                             validate: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return "This field is required";
//                               } else {
//                                 return null;
//                               }
//                             }),
//                       ),
//                       Consumer<LocationProvider>(
//                           builder: (context, locProvider, _) {
//                         return locProvider.predictions.isEmpty ||
//                                 locationController.text.toString().isEmpty
//                             ? const SizedBox(
//                                 height: 0,
//                               )
//                             : ListView.builder(
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemCount: locProvider.predictions.length,
//                                 itemBuilder: (context, index) => InkWell(
//                                       onTap: () {
//                                         locationFocus.unfocus();
//                                         locationProvider.onSelected(
//                                             value:
//                                                 locProvider.predictions[index]);
//                                         locationController.text = locProvider
//                                             .selected!.description
//                                             .toString();
//                                         locationProvider.clearPrediction();
//                                       },
//                                       child: ListTile(
//                                         leading: const Icon(
//                                           Icons.location_on,
//                                           color: AppColor.primaryColor,
//                                         ),
//                                         title: Text(locProvider
//                                             .predictions[index].description
//                                             .toString()),
//                                       ),
//                                     ));
//                       }),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width,
//                         child: Consumer<LocationProvider>(
//                             builder: (context, locProvider, _) {
//                           return locProvider.locationError.isNotEmpty
//                               ? Text(
//                                   locProvider.locationError,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(color: Colors.red),
//                                 )
//                               : const SizedBox();
//                         }),
//                       ),
//                       Consumer<ImagePickProvider>(
//                           builder: (context, imageProvider, _) {
//                         return imageProvider.images.isEmpty == true
//                             ? Constant.kheight(height: 10)
//                             : Container(
//                                 margin: const EdgeInsets.symmetric(vertical: 8),
//                                 height: imageProvider.images.isEmpty == true
//                                     ? 0
//                                     : 190,
//                                 width: MediaQuery.of(context).size.width,
//                                 decoration: BoxDecoration(
//                                   color: AppColor.whiteColor,
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   shrinkWrap: true,
//                                   // gridDelegate:
//                                   //     const SliverGridDelegateWithFixedCrossAxisCount(
//                                   //   crossAxisCount: 2,
//                                   // ),
//                                   itemCount: imageProvider.images.length,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return Padding(
//                                       padding: const EdgeInsets.all(5.0),
//                                       child: Stack(
//                                         children: [
//                                           Container(
//                                             decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                     color: Colors.black)),
//                                             child: Image.file(
//                                               File(imageProvider
//                                                   .images[index].path),
//                                               height: 190,
//                                               width: 150,
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                           Positioned(
//                                             top: 0,
//                                             right: 1,
//                                             child: IconButton(
//                                                 onPressed: () {
//                                                   imageProvider.remove(index);
//                                                 },
//                                                 icon: const Icon(
//                                                     Icons.cancel_outlined)),
//                                           )
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               );
//                       }),

//                       SizedBox(
//                         height: 45,
//                         child: ElevatedButton.icon(
//                           label: Text(
//                             "Add photo",
//                             style: TextStyle(color: Colors.grey[700]),
//                           ),
//                           onPressed: () {
//                             imagePickProvider.pickImage();
//                           },
//                           style: ElevatedButton.styleFrom(
//                               elevation: 0,
//                               alignment: Alignment.centerLeft,
//                               side: const BorderSide(
//                                 color: Colors.grey,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(5)),
//                               backgroundColor: AppColor.whiteColor),
//                           icon: const FaIcon(
//                             FontAwesomeIcons.images,
//                             color: Colors.green,
//                           ),
//                         ),
//                       ),
//                       Constant.kheight(height: 5),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 24,
//                             width: 24,
//                             child: Checkbox(
//                               materialTapTargetSize:
//                                   MaterialTapTargetSize.shrinkWrap,
//                               value: materialChecked,
//                               onChanged: (value) {
//                                 setState(() {
//                                   materialChecked = value!;
//                                 });
//                               },
//                             ),
//                           ),
//                           const Text(" Materials Purchased")
//                         ],
//                       ),
//                       Constant.kheight(height: 5),

//                       // _seekQuoteLoading == true
//                       //     ? Constant.circularProgressIndicator()
//                       //     :

//                       Consumer<JobProvider>(builder: (context, jProvider, _) {
//                         return jProvider.isLoading == true
//                             ? Constant.circularProgressIndicator()
//                             : Consumer<LocationProvider>(
//                                 builder: (context, locProvider, _) {
//                                 return DefaultButton(
//                                   height: 45,
//                                   text: "Seek Quote",
//                                   onPress: () async {
//                                     // setState(() {
//                                     //   _seekQuoteLoading = true;
//                                     // });
//                                     //seekQuote
//                                     if (_formKey.currentState!.validate()) {
//                                       // ignore: avoid_print
//                                       print("valid");
//                                       bool res = await jobProvider.postSavedJob(
//                                           customerId:
//                                               int.parse(sp!.getString('id')!),
//                                           jobTitle: titleController.text
//                                               .trim()
//                                               .toString(),
//                                           jobDescription: descriptionController
//                                               .text
//                                               .trim()
//                                               .toString(),
//                                           budget: budgetController.text
//                                               .trim()
//                                               .toString(),
//                                           timeForCompletion:
//                                               selectedCompletion!,
//                                           location: locationController.text
//                                               .toString(),
//                                           locationLatitude:
//                                               locProvider.latitude,
//                                           locationLongitude:
//                                               locProvider.longitude,
//                                           materialPurchased:
//                                               materialChecked == true
//                                                   ? '1'
//                                                   : '0',
//                                           jobimages:
//                                               imagePickProvider.imageFile,
//                                           jobStatus: status['seekQuote']!,
//                                           context: context);
//                                       if (res == true) {
//                                         clearField();
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   QuoteResults(jobId: "60"),
//                                             ));
//                                       } else {
//                                         Constant.toastMsg(
//                                             msg: "Something Went Wrong",
//                                             backgroundColor: AppColor.red);
//                                       }

//                                       // try {
//                                       //   await jobProvider
//                                       //       .postJob(
//                                       //           customerId: int.parse(
//                                       //               sp!.getString('id')!),
//                                       //           jobTitle: titleController.text
//                                       //               .trim()
//                                       //               .toString(),
//                                       //           jobDescription:
//                                       //               descriptionController.text
//                                       //                   .trim()
//                                       //                   .toString(),
//                                       //           budget: budgetController.text
//                                       //               .trim()
//                                       //               .toString(),
//                                       //           timeForCompletion:
//                                       //               selectedCompletion!,
//                                       //           location: locationController
//                                       //               .text
//                                       //               .toString(),
//                                       //           locationLatitude:
//                                       //               locProvider.latitude,
//                                       //           locationLongitude:
//                                       //               locProvider.longitude,
//                                       //           materialPurchased:
//                                       //               materialChecked == true
//                                       //                   ? '1'
//                                       //                   : '0',
//                                       //           jobimages:
//                                       //               imagePickProvider.imageFile,
//                                       //           jobStatus: status['seekQuote']!,
//                                       //           context: context);
//                                       //            Navigator.push(
//                                       //           context,
//                                       //           MaterialPageRoute(
//                                       //             builder: (context) =>
//                                       //                 QuoteResults(
//                                       //                     jobId:
//                                       //                         "60"),
//                                       //           ));
//                                       //   //     .then((value) {
//                                       //   //        Navigator.push(
//                                       //   //         context,
//                                       //   //         MaterialPageRoute(
//                                       //   //           builder: (context) =>
//                                       //   //               QuoteResults(
//                                       //   //                   jobId:
//                                       //   //                       jProvider.jobId),
//                                       //   //         ));
//                                       //   //   // if (jProvider.jobId.isNotEmpty) {

//                                       //   //   //   clearField();
//                                       //   //   // }
//                                       //   //   return true;
//                                       //   // });
//                                       // } catch (e) {
//                                       //   Constant.toastMsg(
//                                       //       msg: "Something Went Wrong",
//                                       //       backgroundColor: AppColor.red);
//                                       // }
//                                       setState(() {
//                                         _seekQuoteLoading = false;
//                                       });
//                                     } else {
//                                       // ignore: avoid_print
//                                       print("in valid");
//                                       Constant.toastMsg(
//                                           msg:
//                                               "Please make sure all fields are filled in correctly",
//                                           backgroundColor: AppColor.red);
//                                     }
//                                   },
//                                   radius: 5,
//                                   backgroundColor: Colors.green,
//                                 );
//                               });
//                       }),
//                       Constant.kheight(height: 5),
//                       _postJobLoading == true
//                           ? Constant.circularProgressIndicator()
//                           : Consumer<LocationProvider>(
//                               builder: (context, locProvider, _) {
//                               return DefaultButton(
//                                 height: 45,
//                                 text: "Post Job",
//                                 onPress: () async {
//                                   setState(() {
//                                     _postJobLoading = true;
//                                   });
//                                   if (_formKey.currentState!.validate()) {
//                                     // ignore: avoid_print
//                                     print("valid");

//                                     await jobProvider
//                                         .postJob(
//                                             customerId:
//                                                 int.parse(sp!.getString('id')!),
//                                             jobTitle: titleController.text
//                                                 .trim()
//                                                 .toString(),
//                                             jobDescription:
//                                                 descriptionController.text
//                                                     .trim()
//                                                     .toString(),
//                                             budget: budgetController.text
//                                                 .trim()
//                                                 .toString(),
//                                             timeForCompletion:
//                                                 selectedCompletion!,
//                                             location: locationController.text
//                                                 .toString(),
//                                             locationLatitude:
//                                                 locProvider.latitude,
//                                             locationLongitude:
//                                                 locProvider.longitude,
//                                             materialPurchased:
//                                                 materialChecked == true
//                                                     ? '1'
//                                                     : '0',
//                                             jobimages:
//                                                 imagePickProvider.imageFile,
//                                             jobStatus: status['published']!,
//                                             context: context)
//                                         .then((value) {
//                                       clearField();
//                                       Constant.toastMsg(
//                                           msg: "Job Posted Sucessfully",
//                                           backgroundColor:
//                                               AppColor.primaryColor);
//                                     }).onError((error, stackTrace) {
//                                       Constant.toastMsg(
//                                           msg: error.toString(),
//                                           backgroundColor: AppColor.red);
//                                       return;
//                                     });
//                                   } else {
//                                     // ignore: avoid_print
//                                     print("in valid");
//                                     Constant.toastMsg(
//                                         msg:
//                                             "Please make sure all fields are filled in correctly",
//                                         backgroundColor: AppColor.red);
//                                   }
//                                   setState(() {
//                                     _postJobLoading = false;
//                                   });
//                                 },
//                                 radius: 5,
//                                 backgroundColor: AppColor.blackColor,
//                               );
//                             }),
//                       Constant.kheight(height: 5),
//                       _savePostLoading == true
//                           ? Constant.circularProgressIndicator()
//                           : Consumer<LocationProvider>(
//                               builder: (context, locProvider, _) {
//                               return DefaultButton(
//                                 height: 45,
//                                 text: "Save & Post Later",
//                                 onPress: () async {
//                                   setState(() {
//                                     _savePostLoading = true;
//                                   });
//                                   if (_formKey.currentState!.validate()) {
//                                     // ignore: avoid_print
//                                     print("valid");

//                                     await jobProvider
//                                         .postJob(
//                                             customerId:
//                                                 int.parse(sp!.getString('id')!),
//                                             jobTitle: titleController.text
//                                                 .trim()
//                                                 .toString(),
//                                             jobDescription:
//                                                 descriptionController.text
//                                                     .trim()
//                                                     .toString(),
//                                             budget: budgetController.text
//                                                 .trim()
//                                                 .toString(),
//                                             timeForCompletion:
//                                                 selectedCompletion!,
//                                             location: locationController.text
//                                                 .toString(),
//                                             locationLatitude:
//                                                 locProvider.latitude,
//                                             locationLongitude:
//                                                 locProvider.longitude,
//                                             materialPurchased:
//                                                 materialChecked == true
//                                                     ? '1'
//                                                     : '0',
//                                             jobimages:
//                                                 imagePickProvider.imageFile,
//                                             jobStatus: status['saved']!,
//                                             context: context)
//                                         .then((value) {
//                                       clearField();
//                                       Constant.toastMsg(
//                                           msg: "Job Saved Sucessfully",
//                                           backgroundColor:
//                                               AppColor.primaryColor);
//                                     }).onError((error, stackTrace) {
//                                       Constant.toastMsg(
//                                           msg: "Something Went Wrong",
//                                           backgroundColor: AppColor.red);
//                                       return;
//                                     });
//                                   } else {
//                                     // ignore: avoid_print
//                                     print("in valid");
//                                     Constant.toastMsg(
//                                         msg:
//                                             "Please make sure all fields are filled in correctly",
//                                         backgroundColor: AppColor.red);
//                                   }
//                                   setState(() {
//                                     _savePostLoading = false;
//                                   });
//                                 },
//                                 radius: 5,
//                                 backgroundColor: Colors.green,
//                               );
//                             }),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Column columnWidget({required Widget widgetOne, required Widget widgetTwo}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         widgetOne,
//         Constant.kheight(height: 5),
//         widgetTwo,
//       ],
//     );
//   }
// }
