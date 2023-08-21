import 'package:flutter/material.dart';

import '../../../utils/color.dart';
import '../../../utils/png.dart';

class SinglePersonMessage extends StatefulWidget {
  const SinglePersonMessage({Key? key}) : super(key: key);

  @override
  _SinglePersonMessageState createState() => _SinglePersonMessageState();
}

class _SinglePersonMessageState extends State<SinglePersonMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: AppColor.whiteColor,
        titleSpacing: 0.0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(PngImages.arrowBack)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            CircleAvatar(
              backgroundColor: AppColor.secondaryColor,
              child: Icon(Icons.person),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Shanu Legacit',
                style: TextStyle(color: AppColor.blackColor),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.grey.withOpacity(0.03),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Hi'),
                  ),
                ),
                Card(
                  color: Colors.grey.withOpacity(0.03),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Hello, How are you?'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Card(
                      color: AppColor.secondaryColor,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Hi'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Card(
                      color: AppColor.secondaryColor,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Hello, How are you?'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.send,color: AppColor.secondaryColor,),
                        hintText: ' Write Something',
                        labelStyle: TextStyle(color: AppColor.blackColor),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
