import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:flutter/material.dart';

import '../../utils/png.dart';
import 'login.dart';

class LoginSelection extends StatelessWidget {
  const LoginSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColor.gradientColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColor.whiteColor,
              radius: MediaQuery.of(context).size.width * 0.25,
              child: Image.asset(PngImages.logo,width: MediaQuery.of(context).size.width * 0.3,),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: AppColor.whiteBtnColor,
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.25),
              ),
              child: MaterialButton(onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginScreen()));
              },child: Padding(
                padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(PngImages.arrow),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                    Text('Trader Login',style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),),
                  ],
                ),
              ),),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: AppColor.whiteBtnColor,
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.25),
              ),
              child: MaterialButton(onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginScreen()));
              },child: Padding(
                padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(PngImages.arrow),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                    Text('Customer Login',style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),),
                  ],
                ),
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
