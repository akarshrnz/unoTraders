import 'dart:io';
import 'package:codecarrots_unotraders/model/fetch_job_model.dart';
import 'package:codecarrots_unotraders/model/request_job_quote_model.dart';
import 'package:codecarrots_unotraders/model/trader_request_more_details_model.dart';
import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/provider/trader_job_info_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
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

class QuoteRequestPopUp extends StatefulWidget {
  final bool? isRequestMoreDetails;
  final FetchJobModel jobDetails;
  const QuoteRequestPopUp({
    this.isRequestMoreDetails,
    super.key,
    required this.jobDetails,
  });

  @override
  State<QuoteRequestPopUp> createState() => _QuotePopUpState();
}

class _QuotePopUpState extends State<QuoteRequestPopUp> {
  bool isLoading = false;
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
                    TextWidget(
                      data: widget.jobDetails.title ?? "",
                      style: const TextStyle(
                          fontSize: 20,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                widget.isRequestMoreDetails != null
                    ? SizedBox()
                    : AppConstant.kheight(height: 10),
                widget.isRequestMoreDetails != null
                    ? SizedBox()
                    : TextFieldWidget(
                        controller: priceController,
                        hintText: "Quote Price",
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (p0) {
                          reasonFocus.unfocus();
                          FocusScope.of(context).requestFocus(reasonFocus);
                        },
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        }),
                AppConstant.kheight(height: 10),
                TextFieldWidget(
                    focusNode: reasonFocus,
                    controller: reasonController,
                    hintText: widget.isRequestMoreDetails != null
                        ? "Request More Details"
                        : "Reason",
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
                AppConstant.kheight(height: 10),
                widget.isRequestMoreDetails != null
                    ? Consumer<JobProvider>(builder: (context, provider, _) {
                        return isLoading == true
                            ? const Center(child: CircularProgressIndicator())
                            : DefaultButton(
                                height: 50,
                                text: "Send Request",
                                onPress: () async {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  final userinfo =
                                      await SharedPreferences.getInstance();
                                  final id = userinfo.getString('id');
                                  // print(userinfo.getString('id'));
                                  // print(userinfo.getString('userType'));
                                  // print(userinfo.getString('userName'));

                                  if (reasonController.text
                                      .toString()
                                      .isNotEmpty) {
                                    TraderReqMoreModel req = TraderReqMoreModel(
                                      jobQuoteId: 0,
                                      traderId: int.parse(id ?? "0"),
                                      requestDetails:
                                          reasonController.text.toString(),
                                      jobId: widget.jobDetails.id,
                                      jobQuoteDetailsId: 0,
                                      userId: int.parse(
                                        widget.jobDetails.userId ?? "",
                                      ),
                                      userType: "customer",
                                    );

                                    bool res = await jProvider
                                        .sendRequestMoreDetails(request: req);
                                    if (res == true) {
                                      if (!mounted) return;
                                      Navigator.pop(context);
                                      // AppConstant.toastMsg(
                                      //   msg: "Jobquote requested successfully",
                                      //   backgroundColor: AppColor.green);
                                    }
                                    //     .then((value) {
                                    //   Navigator.pop(context);
                                    //   // Constant.toastMsg(
                                    //   //     msg: "Jobquote requested successfully",
                                    //   //     backgroundColor: AppColor.green);
                                    //   return;
                                    // });
                                  } else {
                                    // ignore: avoid_print
                                    print("in valid");
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                radius: 5,
                                backgroundColor: Colors.green,
                              );
                      })
                    : Consumer<JobProvider>(builder: (context, provider, _) {
                        return isLoading == true
                            ? const Center(child: CircularProgressIndicator())
                            : DefaultButton(
                                height: 50,
                                text: "Send",
                                onPress: () async {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  final userinfo =
                                      await SharedPreferences.getInstance();
                                  // print(userinfo.getString('id'));
                                  // print(userinfo.getString('userType'));
                                  // print(userinfo.getString('userName'));

                                  if (_formKey.currentState!.validate()) {
                                    RequestJobQuoteModel req =
                                        RequestJobQuoteModel(
                                            quotePrice:
                                                priceController.text.toString(),
                                            quoteReason: reasonController.text
                                                .toString(),
                                            jobId: widget.jobDetails.id,
                                            userId: int.parse(widget
                                                .jobDetails.userId
                                                .toString()),
                                            userType: 'provider',
                                            name:
                                                userinfo.getString('userName'),
                                            traderId: int.parse(userinfo
                                                .getString('id')
                                                .toString()));
                                    print(" valid");
                                    // await Future.delayed(Duration(seconds: 10));
                                    // Navigator.pop(context);

                                    bool res = await jProvider.sendQuoteReq(
                                        request: req);
                                    if (res == true) {
                                      if (!mounted) return;
                                      Navigator.pop(context);
                                      // AppConstant.toastMsg(
                                      //   msg: "Jobquote requested successfully",
                                      //   backgroundColor: AppColor.green);
                                    }
                                    //     .then((value) {
                                    //   Navigator.pop(context);
                                    //   // Constant.toastMsg(
                                    //   //     msg: "Jobquote requested successfully",
                                    //   //     backgroundColor: AppColor.green);
                                    //   return;
                                    // });
                                  } else {
                                    // ignore: avoid_print
                                    print("in valid");
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
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
