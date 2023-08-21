import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewScreen extends StatelessWidget {
  final String url;
  const ImageViewScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
        loadingBuilder: (context, event) =>
            AppConstant.circularProgressIndicator(),
        imageProvider: NetworkImage(url),
      ),
    );
  }
}
