import 'package:codecarrots_unotraders/model/add_wishlist_model.dart';
import 'package:codecarrots_unotraders/model/wishlist_model.dart';
import 'package:codecarrots_unotraders/provider/message_provider.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/bazaar_detail.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/components/bazaar_items.dart';
import 'package:codecarrots_unotraders/screens/Bazaar/components/search_bazaar_job.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';
import 'package:codecarrots_unotraders/services/helper/url.dart';
import 'package:codecarrots_unotraders/utils/circular_progress.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';

import 'package:codecarrots_unotraders/screens/Bazaar/components/bazaar_pop_up.dart';
import 'package:codecarrots_unotraders/screens/widgets/app_bar.dart';

import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/img_fade.dart';
import 'package:flutter/material.dart';
import '../../../provider/location_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:location/location.dart';

import 'package:intl/intl.dart';

class BazaarScreen extends StatefulWidget {
  const BazaarScreen({super.key});

  @override
  State<BazaarScreen> createState() => _BazaarScreenState();
}

class _BazaarScreenState extends State<BazaarScreen> {
  late BazaarProvider provider;
  late MessageProvider messageProvider;
  @override
  void initState() {
    super.initState();
    messageProvider = Provider.of<MessageProvider>(context, listen: false);
    provider = Provider.of<BazaarProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // locationProvider = Provider.of<LocationProvider>(context, listen: false);

      // locationProvider.initalizeLocation();
      // locationProvider.clearAll();
      messageProvider.clearLoading();
      provider.intialValue();
      provider.clearBazaar();
      provider.fetchBazaarProducts();
      provider.fetchCategory();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(appBarTitle: "Bazaar"),
      body: Column(
        children: [
          Flexible(
            child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  //header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 7),
                    child: headerSection(context, size),
                  ),
                  //body section
                  Consumer<BazaarProvider>(builder: (context, provider, _) {
                    return provider.bazaarProductsList.isEmpty &&
                            provider.error == false
                        ? SizedBox(
                            width: size.width,
                            height: size.height / 1.2,
                            child: Center(child: CircularProgress.indicator()))
                        : provider.error == true
                            ? Center(
                                child: TextWidget(
                                    data: provider.errorMessage.toString()))
                            :
                            //  provider.uploading
                            //     ? SizedBox(
                            //         width: size.width,
                            //         height: size.height / 1.2,
                            //         child: Center(
                            //             child: CircularProgress.indicator()))
                            //     :
                            ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 10,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: provider.bazaarProductsList.length,
                                itemBuilder: (context, index) {
                                  // DateTime date = DateTime.parse(provider
                                  //     .bazaarProductsList[index].createdAt!);

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: ChangeNotifierProvider.value(
                                      value: provider.bazaarProductsList[index],
                                      child: const BazaarItems(),
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

  Row headerSection(BuildContext context, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => const BazaarPopUp(),
            );
            // then((value) {
            //   provider.intialValue();
            //   provider.fetchBazaarProducts();
            //   provider.fetchCategory();
            //   setState(() {});
            //   return;
            // });
          },
          child: Container(
            margin: const EdgeInsets.only(right: 5),
            alignment: Alignment.center,
            height: 35,
            width: 150,
            decoration: BoxDecoration(
                border: Border.all(color: AppColor.primaryColor),
                borderRadius: BorderRadius.circular(20)),
            child: TextWidget(data: "Sell at Bazaar Now"),
          ),
        ),
        Flexible(
          child: InkWell(
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (context) => SearchJobBazaar(
                        isJob: false,
                      ));
              //   Location location = Location();
              // bool _serviceEnabled;
              // PermissionStatus _permissionGranted;
              // LocationData _locationData;

              // _serviceEnabled = await location.serviceEnabled();
              // if (!_serviceEnabled) {
              //   _serviceEnabled = await location.requestService();
              //   if (!_serviceEnabled) {
              //     return;
              //   }
              // }

              // _permissionGranted = await location.hasPermission();
              // if (_permissionGranted == PermissionStatus.denied) {
              //   _permissionGranted = await location.requestPermission();
              //   if (_permissionGranted != PermissionStatus.granted) {
              //     return;
              //   }
              // }

              // _locationData = await location.getLocation();
              // showDialog(
              //     context: context, builder: (context) =>  SerachBazaar());
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              height: 35,
              width: 40,
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  border: Border.all(color: AppColor.primaryColor),
                  borderRadius: BorderRadius.circular(10)),
              child: const SizedBox(
                child: Icon(
                  Icons.search,
                  color: AppColor.whiteColor,
                ),
              ),
            ),
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.all(5),
        //   margin: const EdgeInsets.only(right: 5),
        //   alignment: Alignment.center,
        //   height: 35,
        //   width: 40,
        //   decoration: BoxDecoration(
        //       color: AppColor.blackColor,
        //       borderRadius: BorderRadius.circular(10)),
        //   child: const FaIcon(
        //     FontAwesomeIcons.arrowDownShortWide,
        //     color: AppColor.whiteColor,
        //     size: 18,
        //   ),
        // ),
      ],
    );
  }
}
