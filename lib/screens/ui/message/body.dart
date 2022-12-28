import 'package:codecarrots_unotraders/screens/ui/message/single_person_message.dart';
import 'package:flutter/material.dart';

import '../../../utils/color.dart';
import '../../../utils/png.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
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
          'Chat',
          style: TextStyle(color: AppColor.blackColor),
        ),
      ),
      body: Column(
        children: [
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
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search Chats',
                      labelStyle: TextStyle(color: AppColor.blackColor),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const SinglePersonMessage()));
                    },
                    child: Card(
                      elevation: 10.0,
                      shadowColor: Colors.grey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: AppColor.secondaryColor,
                                child: Icon(Icons.person),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Shanu Legacit',style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text('Hello,How are you?',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('10:09 AM',style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                                CircleAvatar(
                                  radius: MediaQuery.of(context).size.width * 0.04,
                                  backgroundColor: AppColor.secondaryColor,
                                  child: Text('2',style: const TextStyle(color: AppColor.whiteColor),),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
