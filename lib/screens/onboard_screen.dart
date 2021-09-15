import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nnfl_project/screens/home_screen.dart';
import 'package:nnfl_project/utils/colors.dart';

class OnboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/medical-mask.png",
                        height: 340,
                        width: 310,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, top: 12.0, bottom: 4.0),
                    child: Text(
                      "NNFL Project",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 21,
                          color: selago,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, top: 4.0, bottom: 12.0),
                    child: Text(
                      "Face Mask Detection",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 44,
                          color: foam,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24.0, top: 8, right: 24),
                    child: ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        padding: EdgeInsets.all(16),
                        color: persian_blue,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        textColor: white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Get Started",
                              style: TextStyle(
                                  fontSize: 21.0, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(Icons.arrow_forward_ios),
                            )
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(16.0)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
