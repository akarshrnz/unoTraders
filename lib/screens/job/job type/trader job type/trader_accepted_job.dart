import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/provider/trader_job_info_provider.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/trader%20job%20type/trader_job_card.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../utils/color.dart';
import '../../../../utils/png.dart';

class AcceptedJob extends StatefulWidget {
  const AcceptedJob({Key? key}) : super(key: key);

  @override
  _LiveJobState createState() => _LiveJobState();
}

class _LiveJobState extends State<AcceptedJob> {
  TextEditingController serachcontroller = TextEditingController();
  late TraderInfoProvider infoProvider;

  late JobProvider jobProvider;
  @override
  void initState() {
    infoProvider = Provider.of<TraderInfoProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      infoProvider.traderJobTypeByStatus(
          url: Url.traderJobAcceptReject, status: 'accepted');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("accepted >>");
    jobProvider = Provider.of<JobProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    print(size.width * .1);
    return Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: AppColor.whiteColor,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                PngImages.arrowBack,
                width: MediaQuery.of(context).size.width * 0.06,
              )),
          centerTitle: true,
          title: TextWidget(
            data: 'Accepted Jobs',
            style: TextStyle(color: AppColor.blackColor),
          ),
          // actions: [
          //   SearchBarAnimation(
          //     searchBoxWidth: size.width * .97,
          //     textEditingController: serachcontroller,
          //     isOriginalAnimation: true,
          //     enableKeyboardFocus: true,
          //     onFieldSubmitted: (_) {
          //       // ignore: avoid_print
          //       print("submitter");
          //       return null;
          //     },
          //     onExpansionComplete: () {
          //       debugPrint('do something just after searchbox is opened.');
          //     },
          //     onCollapseComplete: () {
          //       serachcontroller.clear();
          //       debugPrint('do something just after searchbox is closed.');
          //     },
          //     onPressButton: (isSearchBarOpens) {
          //       debugPrint(
          //           'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
          //     },
          //     trailingWidget: const Icon(
          //       Icons.search,
          //       size: 30,
          //       color: AppColor.green,
          //     ),
          //     secondaryButtonWidget: const Icon(
          //       Icons.close,
          //       size: 20,
          //       color: AppColor.green,
          //     ),
          //     buttonWidget: const Icon(
          //       Icons.search,
          //       size: 30,
          //       color: AppColor.green,
          //     ),
          //   ),
          // ],
        ),
        body: Consumer<TraderInfoProvider>(builder: (context, provider, _) {
          return provider.traderJobLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : provider.traderJobErrorMessage.isNotEmpty
                  ? Center(child: TextWidget(data: "No data"))
                  : provider.traderJobList.isEmpty
                      ? Center(child: TextWidget(data: "No data"))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.traderJobList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ChangeNotifierProvider.value(
                              value: provider.traderJobList[index],
                              child: const TraderJobCard(),
                            );
                          },
                        );
        }));
  }
}
