import 'dart:io';

import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/receipt/image_view.dart';
import 'package:codecarrots_unotraders/screens/receipt/receipt_popup.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  late ProfileProvider receptProvider;

  @override
  void initState() {
    receptProvider = Provider.of<ProfileProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      receptProvider.getReceiptList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(appBarTitle: "Receipt"),
      body: Consumer<ProfileProvider>(builder: (context, provider, _) {
        return provider.qrLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColor.green,
                ),
              )
            : provider.qrError.isNotEmpty
                ? Center(
                    child: TextWidget(data: provider.errorMessage),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * .03,
                            vertical: size.width * .02),
                        child: addReceipt(size),
                      ),
                      Flexible(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * .03,
                          ),
                          separatorBuilder: (context, index) =>
                              AppConstant.kheight(height: size.width * .03),
                          itemCount: provider.receiptList.length,
                          itemBuilder: (context, index) {
                            final receipt = provider.receiptList[index];
                            DateTime date = DateTime.parse(receipt.createdAt!);
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: ImageViewScreen(
                                          url: receipt.receiptImage!,
                                        )));
                              },
                              child: Card(
                                shadowColor: AppColor.blackColor,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.only(
                                            right: 10, top: 10, bottom: 10),
                                        margin: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        height: 130,
                                        width: 130,
                                        child: receipt.receiptImage == null ||
                                                receipt.receiptImage!.isEmpty
                                            ? Center(
                                                child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.broken_image,
                                                    color: Colors.grey,
                                                  ),
                                                  TextWidget(data: "No image")
                                                ],
                                              ))
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                child: ImgFade.fadeImage(
                                                    url: receipt.receiptImage!),
                                              )),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextWidget(
                                          data: receipt.title ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: AppColor.blackColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        TextWidget(
                                          data:
                                              "${date.day} ${DateFormat.MMM().format(date)} ${date.year}, ${DateFormat('hh:mm a').format(date)}",
                                          style: const TextStyle(
                                              color: AppColor.green),
                                        ),
                                        ReadMoreText(
                                          receipt.remarks ?? "",
                                          readMoreIconColor: AppColor.green,
                                          numLines: 2,
                                          readMoreAlign: Alignment.centerLeft,
                                          style: TextStyle(
                                              fontSize: size.width * .033),
                                          readMoreTextStyle: TextStyle(
                                              fontSize: size.width * .033,
                                              color: Colors.green),
                                          readMoreText: 'Read More',
                                          readLessText: 'Read Less',
                                        ),
                                        AppConstant.kheight(
                                            height: size.width * .03),
                                        DefaultButton(
                                            width: size.width * .06,
                                            borderSide: BorderSide(
                                                color: AppColor.red, width: 1),
                                            backgroundColor:
                                                AppColor.whiteColor,
                                            height: size.width * .06,
                                            childWidget: Row(
                                              children: [
                                                Icon(
                                                  Icons.delete_forever_outlined,
                                                  color: AppColor.red,
                                                ),
                                                AppConstant.kWidth(width: 4),
                                                TextWidget(
                                                  data: "Delete",
                                                  style: TextStyle(
                                                      color:
                                                          AppColor.blackColor),
                                                )
                                              ],
                                            ),
                                            text: "",
                                            onPress: () async {
                                              await receptProvider
                                                  .removeReceipt(
                                                      index: index,
                                                      receiptId: receipt.id
                                                          .toString());
                                            },
                                            radius: size.width * .04),
                                        AppConstant.kheight(
                                            height: size.width * .01),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          shrinkWrap: true,
                        ),
                      )
                    ],
                  );
      }),
    );
  }

  Row addReceipt(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DefaultButton(
            width: size.width * .06,
            height: size.width * .07,
            childWidget: Row(
              children: [
                Icon(Icons.add_circle),
                AppConstant.kWidth(width: 4),
                TextWidget(data: "Add Receipt")
              ],
            ),
            text: "",
            onPress: () async {
              await showDialog(
                context: context,
                builder: (context) => const ReceiptPopUp(),
              );
            },
            radius: size.width * .01)
      ],
    );
  }
}
