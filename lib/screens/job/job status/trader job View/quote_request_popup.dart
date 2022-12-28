import 'dart:io';
import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
import 'package:codecarrots_unotraders/model/request_job_quote_model.dart';
import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/provider/trader_job_info_provider.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/main.dart';
import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/bazaar_screen.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuoteRequestPopUp extends StatefulWidget {
  final FetchJobModel jobDetails;
  const QuoteRequestPopUp({
    super.key,
    required this.jobDetails,
  });

  @override
  State<QuoteRequestPopUp> createState() => _QuotePopUpState();
}

class _QuotePopUpState extends State<QuoteRequestPopUp> {
  TextEditingController priceController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  FocusNode reasonFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  late TraderInfoProvider jProvider;

  @override
  void initState() {
    jProvider = Provider.of<TraderInfoProvider>(context, listen: false);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  void dispose() {
    priceController.dispose();

    reasonController.dispose();

    reasonFocus.dispose();

    super.dispose();
  }

  clearField() {
    priceController.clear();

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
        Flexible(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(),
                    Text(
                      widget.jobDetails.title ?? "",
                      style: const TextStyle(
                          fontSize: 20,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Constant.kheight(height: 10),
                TextFieldWidget(
                    controller: priceController,
                    hintText: "Quote Price",
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (p0) {
                      reasonFocus.unfocus();
                      FocusScope.of(context).requestFocus(reasonFocus);
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    }),
                Constant.kheight(height: 10),
                TextFieldWidget(
                    focusNode: reasonFocus,
                    controller: reasonController,
                    hintText: "Reason",
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (p0) {
                      reasonFocus.unfocus();
                    },
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    }),
                Constant.kheight(height: 10),
                Consumer<JobProvider>(builder: (context, provider, _) {
                  return provider.sendingReq == true
                      ? const Center(child: CircularProgressIndicator())
                      : DefaultButton(
                          height: 50,
                          text: "Send",
                          onPress: () async {
                            final userinfo =
                                await SharedPreferences.getInstance();
                            // print(userinfo.getString('id'));
                            // print(userinfo.getString('userType'));
                            // print(userinfo.getString('userName'));

                            if (_formKey.currentState!.validate()) {
                              RequestJobQuoteModel req = RequestJobQuoteModel(
                                  quotePrice: priceController.text.toString(),
                                  quoteReason: reasonController.text.toString(),
                                  jobId: widget.jobDetails.id,
                                  userId: int.parse(
                                      widget.jobDetails.userId.toString()),
                                  userType: 'provider',
                                  name: userinfo.getString('userName'),
                                  traderId: int.parse(
                                      userinfo.getString('id').toString()));
                              print(" valid");

                              await jProvider
                                  .sendQuoteReq(request: req)
                                  .then((value) {
                                Navigator.pop(context);
                                // Constant.toastMsg(
                                //     msg: "Jobquote requested successfully",
                                //     backgroundColor: AppColor.green);
                                return;
                              });
                            } else {
                              // ignore: avoid_print
                              print("in valid");
                            }
                          },
                          radius: 5,
                          backgroundColor: Colors.green,
                        );
                })
              ],
            ),
          ),
        )
      ]),
    ));
  }
}
