import 'package:codecarrots_unotraders/model/follow/follow_list.dart';
import 'package:codecarrots_unotraders/provider/current_user_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FollowList extends StatefulWidget {
  final String type;
  final String id;

  final bool isFollow;
  final String endPoints;
  const FollowList(
      {super.key,
      required this.isFollow,
      required this.endPoints,
      required this.type,
      required this.id});

  @override
  State<FollowList> createState() => _FollowListState();
}

class _FollowListState extends State<FollowList> {
  late ProfileProvider profileProvider;
  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileProvider.clearProgressIndicator();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          appBarTitle: widget.isFollow ? "Followers" : "Favorites"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<FollowListModel>>(
          future: widget.isFollow == true
              ? ProfileServices.getFollowersList(endPoints: widget.endPoints)
              : ProfileServices.getFavouriteList(endPoints: widget.endPoints),
          builder: (context, AsyncSnapshot<List<FollowListModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              if (snapshot.hasData) {
                List<FollowListModel> data = snapshot.data ?? [];
                return itemsCard(data);
              } else {
                return AppConstant.circularProgressIndicator();
              }
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<FollowListModel> data = snapshot.data ?? [];
                return itemsCard(data);
              } else if (snapshot.hasError) {
                return Center(
                  child: TextWidget(data: snapshot.error.toString()),
                );
              } else {
                return Center(
                  child: TextWidget(data: "No Data"),
                );
              }
            }
            return AppConstant.circularProgressIndicator();
          },
        ),
      ),
    );
  }

  ListView itemsCard(List<FollowListModel> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        FollowListModel item = data[index];
        DateTime date = DateTime.parse(item.createdAt!);
        return Card(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: AppColor.green,
                    radius: 31,
                    child: CircleAvatar(
                      backgroundColor: AppColor.whiteColor,
                      radius: 30,
                      backgroundImage: NetworkImage(item.profilePic ?? ""),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      data: item.name ?? "",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextWidget(
                        data:
                            "Following date: ${date.day} ${DateFormat.MMM().format(date)} ${date.year}",
                        style: TextStyle(fontSize: 17, color: Colors.grey)),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Consumer<CurrentUserProvider>(
                    builder: (context, snapshot, _) {
                  return snapshot.currentUserType == "customer"
                      ? InkWell(
                          onTap: () async {
                            if (widget.isFollow) {
                              await profileProvider.traderFollowUnfollow(
                                  traderId: item.traderId ?? 0);

                              if (widget.type == "customer") {
                                profileProvider.refreshCustomerProfile(
                                    userId: widget.id);
                              }

                              setState(() {});
                            } else {
                              await profileProvider.traderFavouriteUnfavourite(
                                  traderId: item.traderId ?? 0);
                              if (widget.type == "customer") {
                                profileProvider.refreshCustomerProfile(
                                    userId: widget.id);
                              }
                              setState(() {});
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 6),
                            alignment: Alignment.center,
                            height: 35,
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColor.green)),
                            child: TextWidget(data: "Remove"),
                          ),
                        )
                      : SizedBox();
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
