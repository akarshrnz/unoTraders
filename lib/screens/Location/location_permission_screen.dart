import 'package:codecarrots_unotraders/provider/home_provider.dart';
import 'package:codecarrots_unotraders/provider/location_provider.dart';
import 'package:codecarrots_unotraders/screens/dashboard/dashboard.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  late LocationProvider provider;
  late HomeProvider homeProvider;
  bool isServices = true;

  @override
  void initState() {
    provider = Provider.of<LocationProvider>(context, listen: false);
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.requestPermissionAndStoreLocation();
      homeProvider.clearHome();
      // provider.assignCurrentLocation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (context, locationProvider, _) {
      return locationProvider.permissionAllowed
          ? const Dashboard()
          : Scaffold(
              backgroundColor: Colors.white,
              body: locationProvider.isLoading
                  ? Center(child: AppConstant.circularProgressIndicator())
                  : locationProvider.openSetting && locationProvider.retryButton
                      ? Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(150, 50)),
                              onPressed: () async {
                                await provider
                                    .requestPermissionAndStoreLocation();
                              },
                              child: const Text(
                                "Retry",
                                style: TextStyle(fontSize: 18),
                              )),
                        )
                      : Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(300, 50),
                                  maximumSize: const Size(300, 50)),
                              onPressed: () async {
                                await provider
                                    .requestPermissionAndStoreLocation();
                              },
                              // ignore: prefer_const_constructors
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Icon(Icons.location_on_outlined),
                                  Text("Request Location Permission",
                                      style: TextStyle(fontSize: 18)),
                                ],
                              )),
                        ),
            );
    });
  }
}
