import 'package:cached_network_image/cached_network_image.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ImgFade {
  static Widget errorImage({required double height, required double width}) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.broken_image,
            color: Colors.grey,
          ),
          Text("No image")
        ],
      )),
    );
  }

  static Widget fadeImage(
      {required String url, double? width, double? height, BoxFit? fit}) {
    return ImageFade(
      // whenever the image changes, it will be loaded, and then faded in:
      image: CachedNetworkImageProvider(url),
      // NetworkImage(url),

      // slow fade for newly loaded images:
      duration: const Duration(milliseconds: 900),

      // if the image is loaded synchronously (ex. from memory), fade in faster:
      syncDuration: const Duration(milliseconds: 150),

      // supports most properties of Image:
      alignment: Alignment.center,
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
      // shown behind everything:
      placeholder: Shimmer(
        child: Container(
          color: const Color(0xFFCFCDCA),
          alignment: Alignment.center,
          child: const Icon(
            Icons.photo,
            color: Colors.white30,
          ),
        ),
      ),

      // shows progress while loading an image:
      loadingBuilder: (context, progress, chunkEvent) => Center(
          child: CircularProgressIndicator(
              value: progress, color: AppColor.primaryColor)),

      // displayed when an error occurs:
      errorBuilder: (context, error) => Container(
        color: const Color(0xFF6F6D6A),
        alignment: Alignment.center,
        child: const Icon(
          Icons.warning,
          color: Colors.black26,
        ),
      ),
    );
  }
}
