import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ReviewCircleWidget extends StatelessWidget {
  final String rating;
  final String title;
  final Color backgroundColor;
  const ReviewCircleWidget({
    super.key,
    required this.rating,
    required this.title,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: backgroundColor,
            child: Center(
              child: TextWidget(
                  data: rating,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 5),
              child: TextWidget(
                data: title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
