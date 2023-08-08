import 'package:codecarrots_unotraders/provider/profile_insights_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileVisitScreen extends StatefulWidget {
  const ProfileVisitScreen({super.key});

  @override
  State<ProfileVisitScreen> createState() => _ProfileVisitScreenState();
}

class _ProfileVisitScreenState extends State<ProfileVisitScreen> {
  late ProfileInsightsProvider profileInsightsProvider;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    profileInsightsProvider =
        Provider.of<ProfileInsightsProvider>(context, listen: false);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileInsightsProvider.clear();
      profileInsightsProvider.getProfileVisitors(
          endPoints: Url.getProfileVisitors);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 300) {
        profileInsightsProvider.getProfileVisitors(
            endPoints: Url.getProfileVisitors);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBarWidget(appBarTitle: "Profile Visits"),
      body: Consumer<ProfileInsightsProvider>(builder: (context, provider, _) {
        return provider.isVisitorLoading
            ? AppConstant.circularProgressIndicator()
            : provider.ProfileVisitorsModelList.isEmpty &&
                    provider.visitorErrorMessage.isNotEmpty
                ? Center(
                    child: TextWidget(data: provider.visitorErrorMessage),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          controller: _scrollController,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * .04,
                              vertical: size.width * .01),
                          shrinkWrap: true,
                          itemCount: provider.ProfileVisitorsModelList.length,
                          itemBuilder: (context, index) {
                            final data =
                                provider.ProfileVisitorsModelList[index];
                            DateTime date =
                                DateTime.parse(data.createdAt ?? "");
                            return Column(
                              children: [
                                Card(
                                  color: AppColor.whiteColor,
                                  elevation: .5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 29,
                                          backgroundColor: Colors.grey[100],
                                          child: CircleAvatar(
                                            radius: 28,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              radius: 23,
                                              backgroundColor:
                                                  AppColor.whiteColor,
                                              backgroundImage: AssetImage(
                                                  "assets/logo/app_icon.png"),
                                            ),
                                          ),
                                        ),
                                        AppConstant.kWidth(width: 5),
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(data: data.name ?? ""),
                                            TextWidget(
                                              data:
                                                  "${date.day}-${DateFormat.MMM().format(date)}-${date.year}  ${DateFormat('hh:mm a').format(date)}",
                                            ),
                                            TextWidget(
                                                data: "Visited your profile"),
                                          ],
                                        )),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 4),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: AppColor.green)),
                                          child: TextWidget(
                                            data: data.userType ?? "",
                                            style: TextStyle(
                                                color: AppColor.green),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                index ==
                                            provider.ProfileVisitorsModelList
                                                    .length -
                                                1 &&
                                        provider.isFetching &&
                                        provider.hasNext &&
                                        provider
                                            .ProfileVisitorsModelList.isNotEmpty
                                    ? SizedBox(
                                        height: 90,
                                        child: AppConstant
                                            .circularProgressIndicator())
                                    : SizedBox()
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
      }),
    );
  }
}
