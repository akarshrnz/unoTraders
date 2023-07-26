import 'package:codecarrots_unotraders/provider/location_provider.dart';
import 'package:codecarrots_unotraders/screens/dashboard/dashboard.dart';
import 'package:codecarrots_unotraders/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  late LocationProvider provider;
  bool isServices = true;

  @override
  void initState() {
    provider = Provider.of<LocationProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.requestPermissionAndStoreLocation();
      // provider.assignCurrentLocation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (context, locationProvider, _) {
      return locationProvider.permissionAllowed
          ? Dashboard()
          : Scaffold(
              backgroundColor: Colors.white,
              body: locationProvider.isLoading
                  ? Center(child: AppConstant.circularProgressIndicator())
                  : locationProvider.openSetting && locationProvider.retryButton
                      ? Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                await provider
                                    .requestPermissionAndStoreLocation();
                              },
                              child: Text("Retry")),
                        )
                      : Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                await provider
                                    .requestPermissionAndStoreLocation();
                              },
                              child: Text("Rquest Location Permission")),
                        ),
            );
    });
  }
}
