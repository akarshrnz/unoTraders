import 'package:flutter/material.dart';

class ProfileDocument extends StatelessWidget {
  const ProfileDocument({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [],
    );
  }
}
