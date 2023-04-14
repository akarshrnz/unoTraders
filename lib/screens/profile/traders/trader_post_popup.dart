import 'dart:io';
import 'package:codecarrots_unotraders/model/Feeds/trader_feed_model.dart';
import 'package:codecarrots_unotraders/model/add_post.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/main.dart';
import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/bazaar_screen.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../provider/location_provider.dart';

class TraderPostPopUp extends StatefulWidget {
  final TraderFeedModel? traderPost;
  final String userid;
  const TraderPostPopUp({
    this.traderPost,
    super.key,
    required this.userid,
  });

  @override
  State<TraderPostPopUp> createState() => _BazaarPopUpState();
}

class _BazaarPopUpState extends State<TraderPostPopUp> {
  late LocationProvider locationProvider;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  late ImagePickProvider imagePickProvider;
  late ProfileProvider profileProvider;
  late FocusNode postTitleFocus;
  late FocusNode descriptionFocus;
  late FocusNode tempFocus;
  late TextEditingController postTitleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    imagePickProvider = Provider.of<ImagePickProvider>(context, listen: false);
    initialize();

    super.initState();
  }

  initialize() async {
    tempFocus = FocusNode();
    postTitleFocus = FocusNode();
    descriptionFocus = FocusNode();
    postTitleController = TextEditingController(
        text: widget.traderPost == null ? "" : widget.traderPost!.title ?? "");
    descriptionController = TextEditingController(
        text: widget.traderPost == null
            ? ""
            : widget.traderPost!.postContent ?? "");
    if (widget.traderPost != null) {
      if (widget.traderPost!.postImages != null &&
          widget.traderPost!.postImages!.isNotEmpty) {
        await imagePickProvider
            .networkImageToFile(widget.traderPost!.postImages);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    imagePickProvider.images = [];
    imagePickProvider.imageFile = [];
    tempFocus.dispose();
    postTitleFocus.dispose();
    descriptionFocus.dispose();
    postTitleController.dispose();
    descriptionController.dispose();
  }

  clearField() {
    postTitleController.clear();
    descriptionController.clear();
    imagePickProvider.clearImage();
    postTitleFocus.unfocus();
    descriptionFocus.unfocus();
  }

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     locationProvider = Provider.of<LocationProvider>(context, listen: false);
  //     locationProvider.initializeLocation();
  //     locationProvider.clearAll();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
        content: Form(
      key: _formKey,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            TextWidget(
              data: "Add Post",
              style: TextStyle(
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .02),
          child: TextFieldWidget(
              focusNode: postTitleFocus,
              controller: postTitleController,
              hintText: "Post Title",
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (p0) {
                postTitleFocus.unfocus();
                FocusScope.of(context).requestFocus(descriptionFocus);
              },
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return "This field is required";
                } else {
                  return null;
                }
              }),
        ),
        AppConstant.kheight(height: size.width * .017),
        //description
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .02),
          child: TextFieldWidget(
              focusNode: descriptionFocus,
              controller: descriptionController,
              hintText: "Product",
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (p0) {
                descriptionFocus.unfocus();
              },
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return "This field is required";
                } else {
                  return null;
                }
              }),
        ),
        //add photo

        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .02),
          child:
              Consumer<ImagePickProvider>(builder: (context, imageProvider, _) {
            return imageProvider.imageFile.isEmpty == true
                ? AppConstant.kheight(height: 10)
                : Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    height: imageProvider.imageFile.isEmpty == true ? 0 : 170,
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
                      itemCount: imageProvider.imageFile.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Image.file(
                                  imageProvider.imageFile[index],
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
                                      imageProvider.removeImage(index);
                                    },
                                    icon: const Icon(Icons.cancel_outlined)),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
          }),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .02),
          child: SizedBox(
            height: 50,
            width: size.width,
            child: ElevatedButton.icon(
              label: TextWidget(
                data: "Choose Images",
                style: TextStyle(color: Colors.grey[700]),
              ),
              onPressed: () {
                FocusScope.of(context).requestFocus(tempFocus);
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
        ),
        AppConstant.kheight(height: size.width * .017),
        //post button
        isLoading == true
            ? AppConstant.circularProgressIndicator()
            : Consumer<ImagePickProvider>(builder: (context, provider, _) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .02),
                  child: DefaultButton(
                      text: "Post",
                      onPress: () async {
                        final sharedPrefs =
                            await SharedPreferences.getInstance();
                        String id = sharedPrefs.getString('id')!;
                        String userType = sharedPrefs.getString('userType')!;
                        print("post");

                        if (_formKey.currentState!.validate() &&
                            provider.imageFile.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });
                          print("post 556");

                          AddPostModel postModel = AddPostModel(
                              postTitle:
                                  postTitleController.text.trim().toString(),
                              postContent:
                                  descriptionController.text.trim().toString(),
                              postImages: provider.imageFile,
                              traderId: int.parse(id));

                          bool? res;
                          if (widget.traderPost == null) {
                            print("null");
                            res = await profileProvider.addPost(
                                addPost: postModel, endPoints: "add-post");
                          } else {
                            print("not null");
                            int postId = widget.traderPost!.id!;
                            print("not null $postId");
                            res = await profileProvider.addUpdatePost(
                                postId: postId,
                                addPost: postModel,
                                endPoints: "update-post");
                          }

                          if (res == true) {
                            clearField();
                            profileProvider.getTraderFeeds(
                                userType: 'trader', userId: widget.userid);
                          }
                        } else {
                          AppConstant.toastMsg(
                              msg: "Please fill all the Fields",
                              backgroundColor: AppColor.red);
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      radius: size.width * .01),
                );
              }),
      ]),
    ));
  }
}
