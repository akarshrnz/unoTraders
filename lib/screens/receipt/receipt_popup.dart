import 'package:codecarrots_unotraders/model/receipt%20model/add_receipt_model.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/receipt/receipt_screen.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'dart:io';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReceiptPopUp extends StatefulWidget {
  final bool? fromHome;
  const ReceiptPopUp({
    super.key,
    this.fromHome,
  });

  @override
  State<ReceiptPopUp> createState() => _ReceiptPopUpState();
}

class _ReceiptPopUpState extends State<ReceiptPopUp> {
  File? imageFile;
  late ProfileProvider receptProvider;
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  //TextEditingController locationController = TextEditingController();

  FocusNode titleFocus = FocusNode();
  FocusNode priceFocus = FocusNode();
  FocusNode remarksFocus = FocusNode();

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    receptProvider = Provider.of<ProfileProvider>(context, listen: false);

    super.initState();
  }

  _getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    clearField();
    priceController.dispose();
    titleController.dispose();
    remarksController.dispose();
    // locationController.dispose();

    titleFocus.dispose();
    priceFocus.dispose();
    remarksFocus.dispose();

    super.dispose();
  }

  clearField() {
    imageFile = null;
    priceController.clear();
    titleController.clear();
    remarksController.clear();

    titleFocus.unfocus();
    priceFocus.unfocus();
    remarksFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final bazaarProvider = Provider.of<BazaarProvider>(context, listen: false);
    // final imagePickProvider =
    //     Provider.of<ImagePickProvider>(context, listen: false);

    return AlertDialog(
        content: Form(
      key: _formKey,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Flexible(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListView(
              shrinkWrap: true,
              children: [
                //heading

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    TextWidget(
                      data: "Add Receipt",
                      style: const TextStyle(
                          fontSize: 20,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        child: IconButton(
                            onPressed: () {
                              clearField();

                              Navigator.pop(context);
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.circleXmark,
                              color: Colors.green,
                            )))
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                //body
                AppConstant.kheight(height: 8),

                //sub category

                AppConstant.kheight(height: 10),
                TextFieldWidget(
                    focusNode: titleFocus,
                    controller: titleController,
                    hintText: "Title",
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (p0) {
                      titleFocus.unfocus();
                      FocusScope.of(context).requestFocus(priceFocus);
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    }),
                AppConstant.kheight(height: 10),
                TextFieldWidget(
                    focusNode: priceFocus,
                    controller: priceController,
                    hintText: "Price",
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (p0) {
                      priceFocus.unfocus();
                      FocusScope.of(context).requestFocus(remarksFocus);
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    }),
                AppConstant.kheight(height: 10),
                TextFieldWidget(
                    focusNode: remarksFocus,
                    controller: remarksController,
                    hintText: "Remarks",
                    maxLines: 9,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (p0) {
                      remarksFocus.unfocus();
                      FocusScope.of(context).unfocus();
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    }),
                AppConstant.kheight(height: 10),

                imageFile == null
                    ? const SizedBox()
                    : Container(
                        alignment: Alignment.center,
                        width: size.width,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Image.file(
                                imageFile!,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 1,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      imageFile = null;
                                    });
                                  },
                                  icon: const Icon(Icons.cancel_outlined)),
                            )
                          ],
                        ),
                      ),
                imageFile == null
                    ? const SizedBox()
                    : AppConstant.kheight(height: 10),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            _getFromGallery();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)),
                            height: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.images,
                                  color: Colors.green,
                                ),
                                AppConstant.kWidth(width: 10),
                                TextWidget(data: "Upload"),
                              ],
                            ),
                          ),
                        )),
                    AppConstant.kWidth(width: 5),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            _getFromCamera();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)),
                            height: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.qr_code_scanner,
                                  color: AppColor.green,
                                ),
                                AppConstant.kWidth(width: 10),
                                TextWidget(data: "Scan"),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),

                AppConstant.kheight(height: 10),
                isLoading == true
                    ? Center(child: AppConstant.circularProgressIndicator())
                    : DefaultButton(
                        height: 50,
                        text: "Submit",
                        onPress: () async {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            isLoading = true;
                          });

                          if (_formKey.currentState!.validate()) {
                            if (imageFile == null) {
                              AppConstant.toastMsg(
                                  backgroundColor: AppColor.red,
                                  msg: "Please add receipt");
                            } else {
                              final sharedPrefs =
                                  await SharedPreferences.getInstance();
                              String id = sharedPrefs.getString('id')!;
                              String endPoint =
                                  sharedPrefs.getString('userType')!;
                              AddReceiptModel receiptModel = AddReceiptModel(
                                  receiptImage: imageFile,
                                  remarks:
                                      remarksController.text.trim().toString(),
                                  title: titleController.text.trim().toString(),
                                  userId: int.parse(id));
                              // ignore: avoid_print
                              print("valid");
                              bool res = await receptProvider.addReceipt(
                                  fromHome: widget.fromHome,
                                  receipt: receiptModel);
                              print("result is $res");
                              if (res == true) {
                                clearField();

                                if (widget.fromHome != null) {
                                  if (!mounted) return;
                                  await Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ReceiptScreen()));
                                }
                              }
                            }
                          } else {
                            // ignore: avoid_print
                            print("in valid");
                          }
                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        radius: 5,
                        backgroundColor: Colors.green,
                      )
              ],
            ),
          ),
        )
      ]),
    ));
  }
}
