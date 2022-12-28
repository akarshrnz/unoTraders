import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? appBarTitle;
  final IconData? icon;
  Widget? leading;

  final Widget? trailing;
   AppBarWidget({
    Key? key,
    this.appBarTitle,
    this.leading,
    this.icon,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: leading??InkWell(
          onTap: () => Navigator.pop(context),
          child: Image.asset(PngImages.arrowBack)),
      // leading: IconButton(
      //     onPressed: () => Navigator.pop(context),
      //     icon: const Icon(
      //       Icons.arrow_back_ios,
      //       color: AppColor.primaryColor,
      //     )),
      elevation: 1,
      iconTheme: const IconThemeData(color: AppColor.primaryColor),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                5,
              ),
              bottomRight: Radius.circular(5))),
      backgroundColor: AppColor.whiteColor,
      title: Text(appBarTitle ?? "",
          style: const TextStyle(
            color: AppColor.blackColor,
          )),
      actions: [trailing == null ? const SizedBox() : trailing!],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
