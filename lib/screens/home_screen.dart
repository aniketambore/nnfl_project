import 'package:flutter/material.dart';
import 'package:nnfl_project/utils/colors.dart';
import 'package:nnfl_project/widgets/button_plain_with_icon.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Face Mask Detection"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/mask.gif",
                ),
                ButtonPlainWithIcon(
                  color: lightening_yellow,
                  textColor: wood_smoke,
                  icon: Icons.masks,
                  text: "Live camera",
                  callback: () {},
                ),
                SizedBox(
                  height: 16,
                ),
                ButtonPlainWithIcon(
                  color: carribean_green,
                  textColor: wood_smoke,
                  icon: Icons.image,
                  text: "From Gallery",
                  callback: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
