import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomerBlockedScreen extends StatelessWidget {
  const CustomerBlockedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(appBarTitle: "Customer Blocked"),
      body: Center(
        child: TextWidget(data: "No Data"),
      ),
    );
  }
}
