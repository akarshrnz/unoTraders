import 'package:codecarrots_unotraders/model/add_review_model.dart';
import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/review/review_data.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_field.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flut_grouped_buttons/flut_grouped_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerReviewScreen extends StatefulWidget {
  final String endPoints;
  final String status;
  final bool? callCompleted;
  final String jobId;
  final String traderId;
  const CustomerReviewScreen({
    super.key,
    required this.jobId,
    required this.traderId,
    this.callCompleted,
    required this.endPoints,
    required this.status,
  });

  @override
  State<CustomerReviewScreen> createState() => _CustomerReviewScreenState();
}

class _CustomerReviewScreenState extends State<CustomerReviewScreen> {
  late JobProvider jobProvider;
  TextEditingController reviewController = TextEditingController();
  late List<bool> reliabilityIsChecked;
  late List<bool> _tidinessIsChecked;
  late List<bool> _responseIsChecked;
  late List<bool> _accuracyIsChecked;
  late List<bool> _pricingIsChecked;
  late List<bool> _overallIsChecked;
  late List<bool> _completedIsChecked;
  late List<bool> _recommendIsChecked;

  int? reliabilityValue;
  int? tidinessValue;
  int? responseValue;
  int? accuracyValue;
  int? pricingValue;
  int? overallValue;
  int? completedValue;
  int? recommendValues;
  String selectedDate = "";
  bool isLoading = false;
  FocusNode focus = FocusNode();
  FocusNode temp = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobProvider = Provider.of<JobProvider>(context, listen: false);
    reliabilityIsChecked = List<bool>.filled(ReviewData.review.length, false);
    _tidinessIsChecked = List<bool>.filled(ReviewData.review.length, false);
    _responseIsChecked = List<bool>.filled(ReviewData.review.length, false);
    _accuracyIsChecked = List<bool>.filled(ReviewData.review.length, false);
    _pricingIsChecked = List<bool>.filled(ReviewData.review.length, false);
    _overallIsChecked = List<bool>.filled(ReviewData.review.length, false);
    _completedIsChecked =
        List<bool>.filled(ReviewData.reviewQuestions.length, false);
    _recommendIsChecked =
        List<bool>.filled(ReviewData.reviewQuestions.length, false);
  }

  @override
  void dispose() {
    reviewController.dispose();
    focus.dispose();
    super.dispose();
    temp.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: AppColor.whiteColor,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                PngImages.arrowBack,
                width: MediaQuery.of(context).size.width * 0.06,
              )),
          centerTitle: true,
          title: TextWidget(
            data: 'Add a Review',
            style: TextStyle(color: AppColor.blackColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    AppConstant.kheight(height: size.width * .04),
                    textWidget(
                        text: "Was any work completed?",
                        fontSize: size.width * .037),
                    Container(
                      child: Wrap(
                        children: List.generate(
                            ReviewData.reviewQuestions.length,
                            (index) => feedbackBox(
                                  isQuestions: true,
                                  size: size,
                                  index: index,
                                  value: _completedIsChecked[index],
                                  onChanged: (value) {
                                    focus.unfocus();
                                    print(value);
                                    print(index.toString());

                                    if (index == 0) {
                                      if (value == false &&
                                          _completedIsChecked[0] == true) {
                                        setState(() {
                                          _completedIsChecked =
                                              List<bool>.filled(
                                                  ReviewData
                                                      .reviewQuestions.length,
                                                  false);
                                          _completedIsChecked[1] = true;
                                          completedValue = 1;
                                          print("compltedd>>>$completedValue");
                                        });
                                      } else {
                                        setState(() {
                                          _completedIsChecked =
                                              List<bool>.filled(
                                                  ReviewData
                                                      .reviewQuestions.length,
                                                  false);
                                          _completedIsChecked[0] = true;
                                          completedValue = 0;
                                          print("compltedd>>>$completedValue");
                                        });
                                      }
                                    } else {
                                      if (value == false &&
                                          _completedIsChecked[1] == true) {
                                        setState(() {
                                          _completedIsChecked =
                                              List<bool>.filled(
                                                  ReviewData
                                                      .reviewQuestions.length,
                                                  false);
                                          _completedIsChecked[0] = true;
                                          completedValue = 0;
                                          print("compltedd>>>$completedValue");
                                        });
                                      } else {
                                        setState(() {
                                          _completedIsChecked =
                                              List<bool>.filled(
                                                  ReviewData
                                                      .reviewQuestions.length,
                                                  false);
                                          _completedIsChecked[1] = true;
                                          completedValue = 1;
                                          print("compltedd>>>$completedValue");
                                        });
                                      }
                                    }

                                   
                                  },
                                )).toList(),
                      ),
                    ),
                    AppConstant.kheight(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: size.width * .01,
                        horizontal: size.width * .01,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.whiteColor,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0,
                                spreadRadius: .2)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextWidget(
                                data: selectedDate.isEmpty
                                    ? "Choose Date"
                                    : selectedDate),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: IconButton(
                                onPressed: () async {
                                  focus.unfocus();
                                  final date = await pickDate();
                                  if (date == null) return;
                                  // final time = await picktime();
                                  // if (time == null) return;

                                  final validFrom = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                  );
                                  // final amPm = DateFormat('hh:mm a').format(validFrom!);
                                  String dateRes =
                                      "${date.day}-${date.month}-${date.year}";

                                  setState(() {
                                    selectedDate = dateRes;
                                    print(selectedDate);
                                  });
                                },
                                icon: Icon(
                                  Icons.edit_calendar,
                                  color: AppColor.green,
                                )),
                          )
                        ],
                      ),
                    ),
                    AppConstant.kheight(height: 7),
                    TextFieldWidget(
                      focusNode: focus,
                      controller: reviewController,
                      hintText: "Review (150 character)",
                      maxLines: 7,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (p0) {
                        focus.unfocus();
                        FocusScope.of(context).requestFocus(temp);
                      },
                      // validate: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return "This field is required";
                      //   } else {
                      //     return null;
                      //   }
                      // }
                    ),
                    AppConstant.kheight(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0XFFF5F5F5),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0,
                                spreadRadius: .2)
                          ]),
                      padding: EdgeInsets.symmetric(
                        vertical: size.width * .01,
                      ),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.width * .02,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * .02,
                            ),
                            child: TextWidget(
                              data: "Reliability",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: size.width * .01,
                          ),
                          Wrap(
                            children: List.generate(
                                ReviewData.review.length,
                                (index) => feedbackBox(
                                      size: size,
                                      index: index,
                                      value: reliabilityIsChecked[index],
                                      onChanged: (value) {
                                        focus.unfocus();
                                        if (reliabilityIsChecked[index] == true)
                                          return;
                                        if (value == true &&
                                            reliabilityIsChecked
                                                .contains(true)) {
                                          reliabilityIsChecked =
                                              List<bool>.filled(
                                                  ReviewData.review.length,
                                                  false);
                                          setState(
                                            () {
                                              reliabilityIsChecked[index] =
                                                  value!;
                                              reliabilityValue =
                                                  ReviewData.reviewValues(
                                                      reviewtype: ReviewData
                                                          .review[index]);
                                            },
                                          );
                                          print("already true values");
                                        } else {
                                          setState(
                                            () {
                                              reliabilityIsChecked[index] =
                                                  value!;
                                              reliabilityValue =
                                                  ReviewData.reviewValues(
                                                      reviewtype: ReviewData
                                                          .review[index]);
                                              print(
                                                  reliabilityValue.toString());
                                            },
                                          );
                                        }
                                        print(reliabilityValue.toString());
                                      },
                                    )).toList(),
                          ),
                        ],
                      ),
                    ),
                    AppConstant.kheight(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0XFFF5F5F5),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0,
                                spreadRadius: .2)
                          ]),
                      padding: EdgeInsets.symmetric(
                        vertical: size.width * .01,
                      ),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.width * .02,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * .02,
                            ),
                            child: TextWidget(
                              data: "Tidiness or cleanliness",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: size.width * .01,
                          ),
                          Wrap(
                            children: List.generate(
                                ReviewData.review.length,
                                (index) => feedbackBox(
                                      size: size,
                                      index: index,
                                      value: _tidinessIsChecked[index],
                                      onChanged: (value) {
                                        focus.unfocus();
                                        if (_tidinessIsChecked[index] == true)
                                          return;
                                        if (value == true &&
                                            _tidinessIsChecked.contains(true)) {
                                          _tidinessIsChecked =
                                              List<bool>.filled(
                                                  ReviewData.review.length,
                                                  false);
                                          setState(
                                            () {
                                              _tidinessIsChecked[index] =
                                                  value!;
                                              tidinessValue =
                                                  ReviewData.reviewValues(
                                                      reviewtype: ReviewData
                                                          .review[index]);
                                              print(tidinessValue.toString());
                                            },
                                          );
                                          print("already true values");
                                        } else {
                                          setState(
                                            () {
                                              _tidinessIsChecked[index] =
                                                  value!;
                                              tidinessValue =
                                                  ReviewData.reviewValues(
                                                      reviewtype: ReviewData
                                                          .review[index]);
                                            },
                                          );
                                        }
                                        print(tidinessValue.toString());
                                      },
                                    )).toList(),
                          ),
                        ],
                      ),
                    ),
                    AppConstant.kheight(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0XFFF5F5F5),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0,
                                spreadRadius: .2)
                          ]),
                      padding: EdgeInsets.symmetric(
                        vertical: size.width * .01,
                      ),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.width * .02,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * .02,
                            ),
                            child: TextWidget(
                              data: "Response",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: size.width * .01,
                          ),
                          Wrap(
                            children: List.generate(
                                ReviewData.review.length,
                                (index) => feedbackBox(
                                      size: size,
                                      index: index,
                                      value: _responseIsChecked[index],
                                      onChanged: (value) {
                                        focus.unfocus();
                                        if (_responseIsChecked[index] == true)
                                          return;
                                        if (value == true &&
                                            _responseIsChecked.contains(true)) {
                                          _responseIsChecked =
                                              List<bool>.filled(
                                                  ReviewData.review.length,
                                                  false);
                                          setState(
                                            () {
                                              _responseIsChecked[index] =
                                                  value!;
                                              responseValue =
                                                  ReviewData.reviewValues(
                                                      reviewtype: ReviewData
                                                          .review[index]);
                                              print(responseValue.toString());
                                            },
                                          );
                                          print("already true values");
                                        } else {
                                          setState(
                                            () {
                                              _responseIsChecked[index] =
                                                  value!;
                                              responseValue =
                                                  ReviewData.reviewValues(
                                                      reviewtype: ReviewData
                                                          .review[index]);
                                              print(responseValue.toString());
                                            },
                                          );
                                        }
                                        print(responseValue.toString());
                                      },
                                    )).toList(),
                          ),
                        ],
                      ),
                    ),
                    AppConstant.kheight(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0XFFF5F5F5),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0,
                                spreadRadius: .2)
                          ]),
                      padding: EdgeInsets.symmetric(
                        vertical: size.width * .01,
                      ),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.width * .02,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * .02,
                            ),
                            child: TextWidget(
                              data: "Accuracy",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: size.width * .01,
                          ),
                          Wrap(
                            children: List.generate(
                                ReviewData.review.length,
                                (index) => feedbackBox(
                                      size: size,
                                      index: index,
                                      value: _accuracyIsChecked[index],
                                      onChanged: (value) {
                                        focus.unfocus();
                                        if (_accuracyIsChecked[index] == true)
                                          return;
                                        if (value == true &&
                                            _accuracyIsChecked.contains(true)) {
                                          _accuracyIsChecked =
                                              List<bool>.filled(
                                                  ReviewData.review.length,
                                                  false);
                                          setState(
                                            () {
                                              _accuracyIsChecked[index] =
                                                  value!;
                                              accuracyValue =
                                                  ReviewData.reviewValues(
                                                      reviewtype: ReviewData
                                                          .review[index]);
                                              print(accuracyValue.toString());
                                            },
                                          );
                                          print("already true values");
                                        } else {
                                          setState(
                                            () {
                                              _accuracyIsChecked[index] =
                                                  value!;
                                              accuracyValue =
                                                  ReviewData.reviewValues(
                                                      reviewtype: ReviewData
                                                          .review[index]);
                                            },
                                          );
                                        }
                                        print(accuracyValue.toString());
                                      },
                                    )).toList(),
                          ),
                        ],
                      ),
                    ),
                    AppConstant.kheight(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0XFFF5F5F5),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0,
                                spreadRadius: .2)
                          ]),
                      padding: EdgeInsets.symmetric(
                        vertical: size.width * .01,
                      ),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.width * .02,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * .02,
                            ),
                            child: TextWidget(
                              data: "Pricing and quotation",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: size.width * .01,
                          ),
                          Wrap(
                            children: List.generate(
                                ReviewData.review.length,
                                (index) => feedbackBox(
                                      size: size,
                                      index: index,
                                      value: _pricingIsChecked[index],
                                      onChanged: (value) {
                                        focus.unfocus();
                                        if (_pricingIsChecked[index] == true)
                                          return;
                                        if (value == true &&
                                            _pricingIsChecked.contains(true)) {
                                          _pricingIsChecked = List<bool>.filled(
                                              ReviewData.review.length, false);
                                          setState(
                                            () {
                                              _pricingIsChecked[index] = value!;
                                              pricingValue =
                                                  ReviewData.reviewValues(
                                                      reviewtype: ReviewData
                                                          .review[index]);
                                              print(pricingValue.toString());
                                            },
                                          );
                                          print("already true values");
                                        } else {
                                          setState(
                                            () {
                                              _pricingIsChecked[index] = value!;
                                              pricingValue =
                                                  ReviewData.reviewValues(
                                                      reviewtype: ReviewData
                                                          .review[index]);
                                            },
                                          );
                                        }
                                        print(pricingValue.toString());
                                      },
                                    )).toList(),
                          ),
                        ],
                      ),
                    ),
                    AppConstant.kheight(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0XFFF5F5F5),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0,
                                spreadRadius: .2)
                          ]),
                      padding: EdgeInsets.symmetric(
                        vertical: size.width * .01,
                      ),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.width * .02,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * .02,
                            ),
                            child: TextWidget(
                              data: "Overall Experience",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: size.width * .01,
                          ),
                          Wrap(
                            children: List.generate(
                                ReviewData.review.length,
                                (index) => feedbackBox(
                                      size: size,
                                      index: index,
                                      value: _overallIsChecked[index],
                                      onChanged: (value) {
                                        focus.unfocus();
                                        if (_overallIsChecked[index] == true)
                                          return;
                                        if (value == true &&
                                            _overallIsChecked.contains(true)) {
                                          _overallIsChecked = List<bool>.filled(
                                              ReviewData.review.length, false);
                                          setState(
                                            () {
                                              _overallIsChecked[index] = value!;
                                              overallValue =
                                                  ReviewData.reviewValues(
                                                      reviewtype: ReviewData
                                                          .review[index]);
                                              print(overallValue.toString());
                                            },
                                          );
                                          print("already true values");
                                        } else {
                                          setState(
                                            () {
                                              _overallIsChecked[index] = value!;
                                              overallValue =
                                                  ReviewData.reviewValues(
                                                      reviewtype: ReviewData
                                                          .review[index]);
                                              print(overallValue.toString());
                                            },
                                          );
                                        }
                                      },
                                    )).toList(),
                          ),
                        ],
                      ),
                    ),
                    AppConstant.kheight(height: size.width * .04),
                    textWidget(
                        text: "Do you recommend this traders to others?",
                        fontSize: size.width * .037),
                    Container(
                      child: Wrap(
                        children: List.generate(
                            ReviewData.reviewQuestions.length,
                            (index) => feedbackBox(
                                  isQuestions: true,
                                  size: size,
                                  index: index,
                                  value: _recommendIsChecked[index],
                                  onChanged: (value) {
                                    print(value);
                                    print(index.toString());
                                    if (index == 0) {
                                      focus.unfocus();
                                      if (value == false &&
                                          _recommendIsChecked[0] == true) {
                                        setState(() {
                                          _recommendIsChecked =
                                              List<bool>.filled(
                                                  ReviewData
                                                      .reviewQuestions.length,
                                                  false);
                                          _recommendIsChecked[1] = true;
                                          recommendValues = 1;
                                          print("compltedd>>>$recommendValues");
                                        });
                                      } else {
                                        setState(() {
                                          _recommendIsChecked =
                                              List<bool>.filled(
                                                  ReviewData
                                                      .reviewQuestions.length,
                                                  false);
                                          _recommendIsChecked[0] = true;
                                          recommendValues = 0;
                                          print("compltedd>>>$recommendValues");
                                        });
                                      }
                                    } else {
                                      if (value == false &&
                                          _recommendIsChecked[1] == true) {
                                        setState(() {
                                          _recommendIsChecked =
                                              List<bool>.filled(
                                                  ReviewData
                                                      .reviewQuestions.length,
                                                  false);
                                          _recommendIsChecked[0] = true;
                                          recommendValues = 0;
                                          print("compltedd>>>$recommendValues");
                                        });
                                      } else {
                                        setState(() {
                                          _recommendIsChecked =
                                              List<bool>.filled(
                                                  ReviewData
                                                      .reviewQuestions.length,
                                                  false);
                                          _recommendIsChecked[1] = true;
                                          recommendValues = 1;
                                          print("compltedd>>>$recommendValues");
                                        });
                                      }
                                    }

                                    // if (value == true &&
                                    //     _recommendIsChecked.contains(true)) {
                                    //   _recommendIsChecked = List<bool>.filled(
                                    //       ReviewData.reviewQuestions.length,
                                    //       false);
                                    //   setState(
                                    //     () {
                                    //       _recommendIsChecked[index] = value!;
                                    //       recommendValues =
                                    //           ReviewData.reviewQuestionsValues(
                                    //               reviewtype: ReviewData
                                    //                   .reviewQuestions[index]);
                                    //       print(recommendValues.toString());
                                    //     },
                                    //   );
                                    //   print("already true values");
                                    // } else {
                                    //   setState(
                                    //     () {
                                    //       _recommendIsChecked[index] = value!;
                                    //       recommendValues =
                                    //           ReviewData.reviewQuestionsValues(
                                    //               reviewtype: ReviewData
                                    //                   .reviewQuestions[index]);
                                    //       print(recommendValues.toString());
                                    //     },
                                    //   );
                                    // }
                                  },
                                )).toList(),
                      ),
                    ),
                    AppConstant.kheight(height: 10),
                    isLoading == true
                        ? AppConstant.circularProgressIndicator()
                        : DefaultButton(
                            onPress: () async {
                              final sharedPrefs =
                                  await SharedPreferences.getInstance();
                              String id = sharedPrefs.getString('id')!;
                              String userType =
                                  sharedPrefs.getString('userType')!;

                              setState(() {
                                isLoading = true;
                              });

                              if (reliabilityValue == null ||
                                  tidinessValue == null ||
                                  responseValue == null ||
                                  accuracyValue == null ||
                                  pricingValue == null ||
                                  overallValue == null ||
                                  completedValue == null ||
                                  selectedDate.isEmpty ||
                                  reviewController.text.isEmpty ||
                                  recommendValues == null) {
                                AppConstant.toastMsg(
                                    msg: "Please fill all fields",
                                    backgroundColor: AppColor.red);
                              } else {
                                int reliability = reliabilityValue! + 1;
                                int tidiness = tidinessValue! + 1;
                                int response = responseValue! + 1;
                                int accuracy = accuracyValue! + 1;
                                int pricing = pricingValue! + 1;
                                int overall = overallValue! + 1;
                                print(widget.jobId);
                                print(widget.traderId);
                                print("was any");
                                print(completedValue.toString());
                                print("reliabilityValue.toString()");
                                print(reliability.toString());
                                print("tid.toString()");
                                print(tidiness.toString());
                                print("resp.toString()");
                                print(response.toString());
                                print("accuracy.toString()");
                                print(accuracy.toString());
                                print("price.toString()");
                                print(pricing.toString());
                                print("overall.toString()");
                                print(overall.toString());
                                print("recoment any");
                                print(recommendValues.toString());
                                print("date any");
                                print(selectedDate.toString());

                                AddReviewModel add = AddReviewModel(
                                    workCompleted:
                                        completedValue == 0 ? "Yes" : "No",
                                    serviceDate: selectedDate,
                                    reliability: reliability.toString(),
                                    cleanliness: tidiness.toString(),
                                    response: response.toString(),
                                    accuracy: accuracy.toString(),
                                    quotation: pricing.toString(),
                                    overallExperience: overall.toString(),
                                    recommend:
                                        recommendValues == 0 ? "Yes" : "No",
                                    customerId: int.parse(id),
                                    review: reviewController.text.trim(),
                                    serviceId: int.parse(widget.jobId),
                                    traderId: int.parse(widget.traderId));

                                print(add.toJson());

                                bool res =
                                    await ProfileServices.addReview(add: add);
                                if (res == true) {
                                  if (widget.endPoints.isEmpty &&
                                      widget.status.isEmpty) {
                                  } else {
                                    jobProvider.callJobRefresh(
                                        endPoints: widget.endPoints,
                                        status: widget.status);
                                  }
                                }
                                if (res == true) {
                                  if (!mounted) return;
                                  Navigator.pop(context);
                                }
                              }
                              setState(() {
                                isLoading = false;
                              });
                            },
                            radius: 10,
                            text: "Submit",
                            backgroundColor: AppColor.green,
                            width: MediaQuery.of(context).size.width),
                    AppConstant.kheight(height: 10),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Container feedbackBox(
      {bool? isQuestions,
      required Size size,
      required int index,
      required bool? value,
      required void Function(bool?)? onChanged}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .02,
      ),
      width: size.width * .3,
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
          ),
          SizedBox(
            width: size.width * .001,
          ),
          Flexible(
              child: TextWidget(
                  data: isQuestions == null
                      ? ReviewData.review[index]
                      : ReviewData.reviewQuestions[index])),
        ],
      ),
    );
  }

  Widget textWidget({required String text, required double fontSize}) =>
      TextWidget(
        data: text,
        style: TextStyle(color: AppColor.blackColor, fontSize: fontSize),
      );

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100));
}
