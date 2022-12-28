import 'package:flutter/material.dart';

import '../../utils/color.dart';
import '../../utils/png.dart';

class TraderJob extends StatefulWidget {
  const TraderJob({Key? key}) : super(key: key);

  @override
  _JobState createState() => _JobState();
}

class _JobState extends State<TraderJob> {
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
            child: Image.asset(PngImages.arrowBack,width: MediaQuery.of(context).size.width * 0.06,)),
        centerTitle: true,
        title: const Text(
          'Jobs',
          style: TextStyle(color: AppColor.blackColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(PngImages.search,width: MediaQuery.of(context).size.width * 0.06,),
          ),
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shadowColor: AppColor.blackColor,
              elevation: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    PngImages.bazaar,
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Job Title Here',
                              style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Image.asset(PngImages.dollar),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(right: 8.0),
                                              child: Text(
                                                '1000',
                                                style: TextStyle(
                                                    color: AppColor.whiteColor,
                                                    fontWeight: FontWeight.w500,),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Posted: 25 Jan 2022,11.00PM',
                                      style: TextStyle(
                                          color: AppColor.secondaryColor,
                                          fontWeight: FontWeight.w500,
                                        fontSize: MediaQuery.of(context).size.width * 0.028,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              'Description',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.04,
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    color: AppColor.secondaryColor
                                  )),
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'More Details',
                                    style: TextStyle(
                                        color: AppColor.blackColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: MediaQuery.of(context).size.width * 0.03),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            GestureDetector(
                              onTap: (){
                                _buildPopupDialog(context);
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.04,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                    color: AppColor.secondaryColor,
                                    borderRadius: BorderRadius.circular(20.0),
                                    ),
                                child: Center(
                                  child: Center(
                                    child: Text(
                                      'Quote',
                                      style: TextStyle(
                                          color: AppColor.whiteColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: MediaQuery.of(context).size.width * 0.03),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },),
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
              const Text('Get a Quote'),
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Category',
                          labelText: 'Category',
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Sub Category',
                          labelText: 'Sub Category',
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Title',
                          labelText: 'Title',
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.image,color: AppColor.secondaryColor,),
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
              padding: const EdgeInsets.only(left: 20.0,right: 20.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  color: AppColor.secondaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    'Send Quotation',
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