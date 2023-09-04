import 'package:codecarrots_unotraders/provider/job_provider.dart';

import 'package:codecarrots_unotraders/screens/job/job%20type/trader%20job%20type/trader_all_job_card.dart';
import 'package:codecarrots_unotraders/screens/widgets/text_widget.dart';

import 'package:codecarrots_unotraders/utils/color.dart';

import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class TraderJobQuoteRequests extends StatefulWidget {
  const TraderJobQuoteRequests({Key? key}) : super(key: key);

  @override
  State<TraderJobQuoteRequests> createState() => _TraderJobQuoteRequestsState();
}

class _TraderJobQuoteRequestsState extends State<TraderJobQuoteRequests> {
  late JobProvider jobProvider;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      jobProvider = Provider.of<JobProvider>(context, listen: false);
      jobProvider.clear();

      jobProvider.fetchAllJobQuoteRequests();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            data: 'Jobs Quote Requests',
            style: const TextStyle(color: AppColor.blackColor),
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.all(5.0),
          //     child: InkWell(
          //       onTap: () async {
          //         showDialog(
          //             context: context,
          //             builder: (context) => const SearchJobBazaar(
          //                   isJob: true,
          //                 ));
          //       },
          //       child: Container(
          //         margin: const EdgeInsets.all(5),
          //         height: 35,
          //         width: 40,
          //         decoration: BoxDecoration(
          //             color: AppColor.green,
          //             border: Border.all(color: AppColor.primaryColor),
          //             borderRadius: BorderRadius.circular(10)),
          //         child: const SizedBox(
          //           child: Icon(
          //             Icons.search,
          //             color: AppColor.whiteColor,
          //           ),
          //         ),
          //       ),
          //     ),
          //   )

          //   // Padding(
          //   //   padding: const EdgeInsets.all(8.0),
          //   //   child: Image.asset(
          //   //     PngImages.search,
          //   //     width: MediaQuery.of(context).size.width * 0.06,
          //   //   ),
          //   // ),
          // ],
        ),
        body: Consumer<JobProvider>(
          builder: (context, jProvider, child) {
            return jProvider.isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : jProvider.errorMessage.isNotEmpty
                    ? Center(
                        child: TextWidget(data: 'No Jobs'),
                      )
                    : ListView.builder(
                        itemCount: jProvider.allJobList.length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                            value: jProvider.allJobList[index],
                            child: const TraderJobViewCard(),
                          );
                        },
                      );
          },
        )

        // FutureBuilder<List<FetchJobModel>>(
        //     future: JobServices.fetchAllJob(),
        //     builder: (context, AsyncSnapshot<List<FetchJobModel>> snapshot) {
        //       switch (snapshot.connectionState) {
        //         case ConnectionState.waiting:
        //           return const Center(
        //             child: CircularProgressIndicator(),
        //           );
        //         case ConnectionState.done:
        //         default:
        //           if (snapshot.hasError) {
        //           } else if (snapshot.hasData) {
        //             return Form(
        //               key: _formKey,
        //               child: ListView.builder(
        //                 shrinkWrap: true,
        //                 itemCount: snapshot.data!.length,
        //                 itemBuilder: (BuildContext context, int index) {
        //                   return ChangeNotifierProvider.value(
        //                     value: snapshot.data![index],
        //                     child: const TraderJobViewCard(),
        //                   );
        //                 },
        //               ),
        //             );
        //           } else {
        //             return const Center(child: TextWidget(data:"No data"));
        //           }
        //       }
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }),
        );
  }

  Future _buildPopupDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextWidget(data: 'Get a Quote'),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: AppColor.secondaryColor,
                  ))
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Name',
                        labelText: 'Name',
                        labelStyle: const TextStyle(color: AppColor.blackColor),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: AppColor.blackColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: AppColor.blackColor),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: 'Phone',
                          labelText: 'Phone',
                          labelStyle:
                              const TextStyle(color: AppColor.blackColor),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: AppColor.blackColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: AppColor.blackColor),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Category',
                          labelText: 'Category',
                          labelStyle:
                              const TextStyle(color: AppColor.blackColor),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: AppColor.blackColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: AppColor.blackColor),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Sub Category',
                          labelText: 'Sub Category',
                          labelStyle:
                              const TextStyle(color: AppColor.blackColor),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: AppColor.blackColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: AppColor.blackColor),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Title',
                          labelText: 'Title',
                          labelStyle:
                              const TextStyle(color: AppColor.blackColor),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: AppColor.blackColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: AppColor.blackColor),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextFormField(
                      minLines: 5,
                      maxLines: 10,
                      decoration: InputDecoration(
                          hintText: 'Description',
                          labelText: 'Description',
                          labelStyle:
                              const TextStyle(color: AppColor.blackColor),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: AppColor.blackColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: AppColor.blackColor),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: 'Budget',
                          labelText: 'Budget',
                          labelStyle:
                              const TextStyle(color: AppColor.blackColor),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: AppColor.blackColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: AppColor.blackColor),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: 'Time for Completion',
                          labelText: 'Time for Completion',
                          labelStyle:
                              const TextStyle(color: AppColor.blackColor),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: AppColor.blackColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: AppColor.blackColor),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.image,
                          color: AppColor.secondaryColor,
                        ),
                        hintText: 'Add Photo',
                        labelText: 'Add Photo',
                        labelStyle: const TextStyle(color: AppColor.blackColor),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: AppColor.blackColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: AppColor.blackColor),
                        )),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  color: AppColor.secondaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: TextWidget(
                    data: 'Send Quotation',
                    style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
