import 'package:codecarrots_unotraders/screens/job/job%20status/customer%20job%20view/review/review_data.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flut_grouped_buttons/flut_grouped_buttons.dart';
import 'package:flutter/material.dart';

class CustomerReviewScreen extends StatefulWidget {
  const CustomerReviewScreen({super.key});

  @override
  State<CustomerReviewScreen> createState() => _CustomerReviewScreenState();
}

class _CustomerReviewScreenState extends State<CustomerReviewScreen> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
          title: const Text(
            'Add a Review',
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
                    Constant.kheight(height: size.width * .04),
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
                                    if (value == true &&
                                        _completedIsChecked.contains(true)) {
                                      _completedIsChecked = List<bool>.filled(
                                          ReviewData.reviewQuestions.length,
                                          false);
                                      setState(
                                        () {
                                          _completedIsChecked[index] = value!;
                                          completedValue =
                                              ReviewData.reviewQuestionsValues(
                                                  reviewtype: ReviewData
                                                      .reviewQuestions[index]);
                                          print(completedValue.toString());
                                        },
                                      );
                                      print("already true values");
                                    } else {
                                      setState(
                                        () {
                                          _completedIsChecked[index] = value!;
                                          completedValue =
                                              ReviewData.reviewQuestionsValues(
                                                  reviewtype: ReviewData
                                                      .reviewQuestions[index]);
                                          print(completedValue.toString());
                                        },
                                      );
                                    }
                                  },
                                )).toList(),
                      ),
                    ),
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
                            child: const Text(
                              "Reliability",
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
                                              print(
                                                  reliabilityValue.toString());
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
                                      },
                                    )).toList(),
                          ),
                        ],
                      ),
                    ),
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
                            child: const Text(
                              "Tidiness or cleanliness",
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
                                              print(tidinessValue.toString());
                                            },
                                          );
                                        }
                                      },
                                    )).toList(),
                          ),
                        ],
                      ),
                    ),
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
                            child: const Text(
                              "Response",
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
                                      },
                                    )).toList(),
                          ),
                        ],
                      ),
                    ),
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
                            child: const Text(
                              "Accuracy",
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
                                              print(accuracyValue.toString());
                                            },
                                          );
                                        }
                                      },
                                    )).toList(),
                          ),
                        ],
                      ),
                    ),
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
                            child: const Text(
                              "Pricing and quotation",
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
                                              print(pricingValue.toString());
                                            },
                                          );
                                        }
                                      },
                                    )).toList(),
                          ),
                        ],
                      ),
                    ),
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
                            child: const Text(
                              "Overall Experiance",
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
                    Constant.kheight(height: size.width * .04),
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
                                    if (value == true &&
                                        _recommendIsChecked.contains(true)) {
                                      _recommendIsChecked = List<bool>.filled(
                                          ReviewData.reviewQuestions.length,
                                          false);
                                      setState(
                                        () {
                                          _recommendIsChecked[index] = value!;
                                          recommendValues =
                                              ReviewData.reviewQuestionsValues(
                                                  reviewtype: ReviewData
                                                      .reviewQuestions[index]);
                                          print(recommendValues.toString());
                                        },
                                      );
                                      print("already true values");
                                    } else {
                                      setState(
                                        () {
                                          _recommendIsChecked[index] = value!;
                                          recommendValues =
                                              ReviewData.reviewQuestionsValues(
                                                  reviewtype: ReviewData
                                                      .reviewQuestions[index]);
                                          print(recommendValues.toString());
                                        },
                                      );
                                    }
                                  },
                                )).toList(),
                      ),
                    ),
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
              child: Text(isQuestions == null
                  ? ReviewData.review[index]
                  : ReviewData.reviewQuestions[index])),
        ],
      ),
    );
  }

  Text textWidget({required String text, required double fontSize}) => Text(
        text,
        style: TextStyle(color: AppColor.blackColor, fontSize: fontSize),
      );
}
