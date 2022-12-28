import 'package:codecarrots_unotraders/model/provider_profile_model.dart';
import 'package:codecarrots_unotraders/screens/profile/traders/trader_profile.dart';
import 'package:codecarrots_unotraders/screens/profile/traders/trader_profile_visit.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';

class ListTraders extends StatelessWidget {
  final String id;
  final String category;
  const ListTraders({super.key, required this.id, required this.category});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(appBarTitle: category),
      body: Column(
        children: [
          Flexible(
            child: FutureBuilder<List<ProviderProfileModel>>(
                future: ProfileServices.getProviderProfile(id: id),
                builder: (context,
                    AsyncSnapshot<List<ProviderProfileModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            snapshot.data == null ? 0 : snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .02,
                                vertical: size.width * .02),
                            width: size.width,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: TraderProfileVisit(
                                          id: data.id.toString(),
                                          category: category,
                                        )));
                              },
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.all(size.width * .02),
                                          child: CircleAvatar(
                                            radius: size.width * .1,
                                            backgroundColor: AppColor.green,
                                            child: CircleAvatar(
                                              radius: size.width * .09,
                                              backgroundImage: NetworkImage(
                                                data.profilePic!,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: size.width * .03,
                                                bottom: size.width * .03),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                title(
                                                    text: data.name!,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                Row(
                                                  children: [
                                                    title(
                                                        text: data.rating!,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        maxLines: 1),
                                                    Constant.kWidth(
                                                        width:
                                                            size.width * .01),
                                                    Expanded(
                                                        child: Container(
                                                      child: title(
                                                          text: "reviews",
                                                          color: AppColor.green,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ))
                                                  ],
                                                ),
                                                title(
                                                    text: data.completedWorks!,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: size.width * .1,
                                      color: AppColor.blackColor,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          bottomButton(
                                            icon: Icons.chat,
                                            label: "Message",
                                            onPressed: () {
                                              // ignore: avoid_print
                                              print("pressed");
                                            },
                                          ),
                                          verticaldivider(size),
                                          bottomButton(
                                            icon: Icons.phone,
                                            label: "Phone",
                                            onPressed: () {
                                              // ignore: avoid_print
                                              print("pressed");
                                            },
                                          ),
                                          verticaldivider(size),
                                          bottomButton(
                                            icon: Icons.request_quote,
                                            label: "Get a Quote",
                                            onPressed: () {
                                              // ignore: avoid_print
                                              print("pressed");
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      const Center(child: Text("Document does not exist"));
                    }
                  } else {
                    return Constant.circularProgressIndicator();
                  }

                  return Constant.circularProgressIndicator();
                }),
          )
        ],
      ),
    );
  }

  SizedBox verticaldivider(Size size) {
    return SizedBox(
        height: size.width * .07,
        child: const VerticalDivider(
          color: AppColor.whiteColor,
          width: 2,
        ));
  }

  ElevatedButton bottomButton(
      {required IconData icon,
      required String label,
      required Function() onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppColor.green,
      ),
      label: Text(label),
      style: ElevatedButton.styleFrom(backgroundColor: AppColor.blackColor),
    );
  }

  Widget title(
      {required String text,
      required double fontSize,
      required FontWeight fontWeight,
      int? maxLines,
      Color? color}) {
    return Text(
      text,
      maxLines: maxLines ?? 2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? AppColor.blackColor),
    );
  }
}
