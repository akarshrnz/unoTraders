import 'package:codecarrots_unotraders/model/report_feed-model.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TraderReportPopup extends StatefulWidget {
  final int postId;

  const TraderReportPopup({
    super.key,
    required this.postId,
  });

  @override
  State<TraderReportPopup> createState() => _BazaarPopUpState();
}

class _BazaarPopUpState extends State<TraderReportPopup> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  late ProfileProvider profileProvider;
  late FocusNode reasonFocus;

  late FocusNode tempFocus;
  late TextEditingController reasonController;

  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    initialize();

    super.initState();
  }

  initialize() async {
    tempFocus = FocusNode();
    reasonFocus = FocusNode();

    reasonController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    tempFocus.dispose();
    reasonFocus.dispose();

    reasonController.dispose();
  }

  clearField() {
    reasonController.clear();

    reasonFocus.unfocus();
  }

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
              data: "Report",
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
              focusNode: reasonFocus,
              controller: reasonController,
              hintText: "Describe reason to report!",
              maxLines: 7,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (p0) {
                reasonFocus.unfocus();
                // FocusScope.of(context).requestFocus(descriptionFocus);
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
        AppConstant.kheight(height: 10),
        isLoading == true
            ? SizedBox(
                width: size.width,
                child: AppConstant.circularProgressIndicator())
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .02),
                child: DefaultButton(
                    text: "Report",
                    onPress: () async {
                      reasonFocus.unfocus();
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });

                        final sharedPrefs =
                            await SharedPreferences.getInstance();
                        String id = sharedPrefs.getString('id') ?? "";

                        String userType =
                            sharedPrefs.getString('userType') ?? "";
                        print(id);
                        print(userType);
                        print(widget.postId);
                        print(reasonController.text.trim());
                        ReportFeedModel report = ReportFeedModel(
                            userId: int.tryParse(id),
                            userType: userType,
                            traderPostId: widget.postId,
                            reason: reasonController.text.trim());
                        print(report.toJson());

                        bool? res =
                            await profileProvider.reportFeeds(report: report);

                        // if (res == true) {
                        //   clearField();
                        //   if (!mounted) return;
                        //   Navigator.of(context).pop();
                        // } else {}
                        // clearField();
                        if (!mounted) return;
                        Navigator.of(context).pop();
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
              )
      ]),
    ));
  }
}
