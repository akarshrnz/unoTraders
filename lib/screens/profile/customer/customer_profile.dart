import 'package:codecarrots_unotraders/provider/location_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/profile/customer/edit_customer_profile.dart';
import 'package:codecarrots_unotraders/services/helper/api_services_url.dart';
import 'package:codecarrots_unotraders/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../utils/color.dart';
import '../../../utils/png.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key}) : super(key: key);

  @override
  _TraderProfileState createState() => _TraderProfileState();
}

class _TraderProfileState extends State<CustomerProfile> {
  late ProfileProvider profileProvider;
  Future<void>? getCustomerProfile;
  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    fetchProfie(profileProvider);
  }

  fetchProfie(ProfileProvider profileProvider) {
    profileProvider.clear();
    getCustomerProfile =
        profileProvider.getCustomerProfile(userId: ApiServicesUrl.id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(color: AppColor.blackColor),
        ),
      ),
      body: Consumer<ProfileProvider>(
          builder: (context, ProfileProvider provider, _) {
        return provider.isLoading == true
            ? Constant.circularProgressIndicator()
            : provider.errorMessage.isNotEmpty
                ? const Center(child: Text("Something Went Wrong"))
                : provider.customerProfile == null
                    ? const Center(child: Text("Customer Data does not exist"))
                    : SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * .02),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            provider
                                                        .customerProfile!
                                                        .profilePic!
                                                        .isNotEmpty ==
                                                    true
                                                ? CircleAvatar(
                                                    radius: size.width * 0.08,
                                                    child: CircleAvatar(
                                                      radius:
                                                          size.width * 0.075,
                                                      backgroundColor:
                                                          AppColor.whiteColor,
                                                      child: CircleAvatar(
                                                        radius:
                                                            size.width * 0.07,
                                                        backgroundImage:
                                                            NetworkImage(provider
                                                                .customerProfile!
                                                                .profilePic!),
                                                      ),
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    radius: size.width * 0.08,
                                                    child: Image.asset(
                                                      PngImages.profile,
                                                    )),

                                            Container(
                                              margin: EdgeInsets.all(
                                                  size.width * 0.02),
                                              height: size.width * 0.07,
                                              width: size.width * 0.07,
                                              decoration: BoxDecoration(
                                                  color: AppColor.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          size.width * 0.02)),
                                              child: IconButton(
                                                  // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                                  icon: FaIcon(
                                                    FontAwesomeIcons
                                                        .penToSquare,
                                                    color: AppColor.whiteColor,
                                                    size: size.width * 0.04,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditCustomerProfile(
                                                                  customerProfile:
                                                                      provider
                                                                          .customerProfile!),
                                                        ));
                                                  }),
                                            )
                                            // Row(
                                            //   mainAxisAlignment: MainAxisAlignment.start,
                                            //   children: [
                                            //     Column(
                                            //       children: const [
                                            //         Icon(
                                            //           Icons.badge,
                                            //           color: AppColor.secondaryColor,
                                            //         ),
                                            //         Text('ID: 23456788'),
                                            //       ],
                                            //     ),
                                            //     const Padding(
                                            //       padding: EdgeInsets.all(8.0),
                                            //       child: Icon(
                                            //         Icons.qr_code,
                                            //         color: AppColor.blackColor,
                                            //       ),
                                            //     )
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    provider
                                                        .customerProfile!.name!,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                      'ID: ${provider.customerProfile!.username}'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 20),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Column(
                              //         crossAxisAlignment: CrossAxisAlignment.start,
                              //         children: const [
                              //           Text(
                              //             'Akarsh',
                              //             style: TextStyle(fontWeight: FontWeight.bold),
                              //           ),
                              //           Text('ID: 23456788'),
                              //         ],
                              //       ),

                              //     ],
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            border: Border.all(
                                              color: AppColor.secondaryColor,
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Row(
                                            children: [
                                              Constant.kWidth(
                                                  width: size.width * .02),
                                              Icon(
                                                Icons.groups,
                                                size: size.width * .09,
                                                color: AppColor.green,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Follow',
                                                    style: TextStyle(
                                                      color:
                                                          AppColor.blackColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    '15,000',
                                                    style: TextStyle(
                                                        color:
                                                            AppColor.blackColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            border: Border.all(
                                              color: AppColor.secondaryColor,
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Constant.kWidth(
                                                  width: size.width * .01),
                                              Icon(
                                                Icons.favorite,
                                                size: size.width * .06,
                                                color: AppColor.secondaryColor,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Favourite',
                                                    style: TextStyle(
                                                      color:
                                                          AppColor.blackColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    '10',
                                                    style: TextStyle(
                                                        color:
                                                            AppColor.blackColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                      color: AppColor.blackColor,
                                    ),
                                    Constant.kWidth(width: size.width * .02),
                                    Text(
                                        '+${provider.customerProfile!.countryCode ?? ''} ${provider.customerProfile!.mobile ?? ""}'),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.phone_in_talk,
                                      color: AppColor.blackColor,
                                    ),
                                    Constant.kWidth(width: size.width * .02),
                                    Text(
                                        '+${provider.customerProfile!.countryCode ?? ''} ${provider.customerProfile!.mobile ?? ""}'),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.envelope,
                                      color: AppColor.blackColor,
                                    ),
                                    Constant.kWidth(width: size.width * .02),
                                    Text(provider.customerProfile!.email ?? ""),
                                  ],
                                ),
                              ),
                              // const Divider(
                              //   color: Colors.grey,
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Row(
                              //     children:  [
                              //       const FaIcon(
                              //         FontAwesomeIcons.globe,
                              //         color: AppColor.blackColor,

                              //       ),Constant.kWidth(width: size.width*.02),
                              //       Text('www.sonymangottil.com'),
                              //     ],
                              //   ),
                              // ),
                              // const Divider(
                              //   color: Colors.grey,
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Row(
                              //     children:  [
                              //       const FaIcon(
                              //         FontAwesomeIcons.clock,
                              //         color: AppColor.blackColor,

                              //       ),Constant.kWidth(width: size.width*.02),
                              //       Text('12:00 AM - 12:00 PM'),
                              //     ],
                              //   ),
                              // ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.locationDot,
                                      color: AppColor.blackColor,
                                    ),
                                    Constant.kWidth(width: size.width * .02),
                                    Text(provider.customerProfile!.location ??
                                        ""),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      );
      }),
    );
  }
}
