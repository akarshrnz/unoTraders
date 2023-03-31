import 'package:codecarrots_unotraders/provider/profile_insights_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TraderBlockedScreen extends StatefulWidget {
  const TraderBlockedScreen({super.key});

  @override
  State<TraderBlockedScreen> createState() => _ProfileVisitScreenState();
}

class _ProfileVisitScreenState extends State<TraderBlockedScreen> {
  late ProfileInsightsProvider profileInsightsProvider;

  @override
  void initState() {
    profileInsightsProvider =
        Provider.of<ProfileInsightsProvider>(context, listen: false);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileInsightsProvider.clear();
      profileInsightsProvider.getBlockedTrader();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBarWidget(appBarTitle: "Blocked Trader"),
      body: Consumer<ProfileInsightsProvider>(builder: (context, provider, _) {
        return provider.isFetching
            ? AppConstant.circularProgressIndicator()
            : provider.visitorErrorMessage.isNotEmpty
                ? Center(
                    child: TextWidget(data: "Something Went Wrong"),
                  )
                : provider.blockedTraderModelList.isEmpty
                    ? Center(
                        child: TextWidget(data: "No Trader Blocked"),
                      )
                    : Column(
                        children: [
                          Flexible(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * .04,
                                  vertical: size.width * .01),
                              shrinkWrap: true,
                              itemCount: provider.blockedTraderModelList.length,
                              itemBuilder: (context, index) {
                                final data =
                                    provider.blockedTraderModelList[index];
                                DateTime date =
                                    DateTime.parse(data.blockedOn ?? "");
                                return Card(
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
                                              backgroundImage: NetworkImage(
                                                  data.profilePic ?? ""),
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
                                            TextWidget(
                                              data: data.name ?? "",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextWidget(
                                              data:
                                                  "${date.day}-${DateFormat.MMM().format(date)}-${date.year} ${DateFormat('hh:mm a').format(date)}",
                                            ),
                                          ],
                                        )),
                                        InkWell(
                                          onTap: () async {
                                            await profileInsightsProvider
                                                .blockUnBlockTrader(
                                                    index: index,
                                                    traderId:
                                                        data.traderId ?? 0,
                                                    status: 0);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 4),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: AppColor.green)),
                                            child: TextWidget(
                                              data: "unblock",
                                              style: TextStyle(
                                                  color: AppColor.green),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
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
