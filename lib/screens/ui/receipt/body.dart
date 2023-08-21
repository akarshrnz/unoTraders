import 'package:flutter/material.dart';

import '../../../utils/color.dart';
import '../../../utils/png.dart';

class Receipt extends StatefulWidget {
  const Receipt({Key? key}) : super(key: key);

  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
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
            child: Image.asset(PngImages.arrowBack)),
        centerTitle: true,
        title: const Text(
          'Receipts',
          style: TextStyle(color: AppColor.blackColor),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    _buildPopupDialog(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    // width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      color: AppColor.secondaryColor,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(Icons.add_circle,color: AppColor.whiteBtnColor,),
                          Text(
                            'Add Receipt',
                            style: TextStyle(
                              color: AppColor.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
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
                                children: const [
                                  Text(
                                    'Receipts Title Here',
                                    style: TextStyle(
                                        color: AppColor.blackColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '25 Jan 2022,11.00PM',
                                    style: TextStyle(
                                        color: AppColor.secondaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Description',
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *0.04,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.04,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: Colors.red,
                                    )),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.delete_outline_outlined,color: Colors.red,size: MediaQuery.of(context).size.width * 0.05,),
                                      Center(
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                              color: AppColor.blackColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: MediaQuery.of(context).size.width * 0.03),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },),
          ),
        ],
      ),
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
              const Text('Add Receipts'),
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
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
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Price',
                        labelText: 'Price',
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
                      hintText: 'Remarks',
                      labelText: 'Remarks',
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
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: AppColor.blackColor
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.image,color: AppColor.secondaryColor,),
                            Text('Upload'),
                          ],
                        )
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: AppColor.blackColor
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.settings_overscan,color: AppColor.secondaryColor,),
                              Text('Scan'),
                            ],
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                    'Submit',
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