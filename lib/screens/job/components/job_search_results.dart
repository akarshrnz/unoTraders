import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/trader%20job%20type/trader_all_job_card.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';
import 'package:codecarrots_unotraders/utils/circular_progress.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class JobSearchResults extends StatelessWidget {
  final String query;
  final double latitude;
  final double longitude;
  final int distance;
  const JobSearchResults(
      {super.key,
      required this.query,
      required this.latitude,
      required this.longitude,
      required this.distance});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBarWidget(
        appBarTitle: "Jobs",
        // trailing: PopupMenuButton<int>(
        //     icon: const FaIcon(
        //       FontAwesomeIcons.filter,
        //       size: 17,
        //       color: AppColor.green,
        //     ),
        //     itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
        //           new PopupMenuItem<int>(
        //               value: 1, child: new Text('Most Rcent')),
        //           new PopupMenuItem<int>(value: 2, child: new Text('Lowest')),
        //           new PopupMenuItem<int>(value: 3, child: new Text('Oldest')),
        //           new PopupMenuItem<int>(value: 4, child: new Text('Highest'))
        //         ],
        //     onSelected: (int value) {
        //       print(latitude.toString());
        //       print(longitude.toString());
        //       print(distance.toString());
        //       print(query);

        //       print(value.toString());

        //       jobProvider.searchBazaarProduct(
        //           distance: distance,
        //           latitude: latitude,
        //           longitude: longitude,
        //           query: query,
        //           sortBy: value);
        //     }),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Consumer<JobProvider>(builder: (context, provider, _) {
                    return provider.searchingLoading
                        ? SizedBox(
                            width: size.width,
                            height: size.height,
                            child: Center(child: CircularProgress.indicator()))
                        : provider.searchError == true
                            ? SizedBox(
                                width: size.width,
                                height: size.height,
                                child: Center(
                                    child: Text(provider.searchErrorMessage
                                        .toString())),
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 10,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: provider.jobSearchList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: ChangeNotifierProvider.value(
                                      value: provider.jobSearchList[index],
                                      child: TraderJobViewCard(),
                                    ),
                                  );
                                },
                              );
                  })
                ]),
          )
        ],
      ),
    );
  }
}
