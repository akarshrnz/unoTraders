import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QrCodePopUp extends StatelessWidget {
  final String url;
  QrCodePopUp({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.width * .5,
            child: SvgPicture.network(
              url,
              fit: BoxFit.fill,
            )));
  }
}
