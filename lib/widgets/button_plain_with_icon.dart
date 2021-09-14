import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nnfl_project/utils/colors.dart';

class ButtonPlainWithIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback callback;
  final Color color;
  final Color textColor;
//  ButtonPlainWithIcon(this.text, this.icon, this.callback, this.isPrefix,
//      this.isSuffix, this.color, this.textColor, this.size);
  ButtonPlainWithIcon(
      {required this.text,
      required this.icon,
      required this.callback,
      required this.color,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 8, right: 24),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width,
        child: RaisedButton(
          padding: EdgeInsets.all(16),
          color: color,
          onPressed: callback,
          textColor: textColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  icon,
                  color: trout,
                ),
              ),
              Text(
                text,
                style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
              ),
              SizedBox()
            ],
          ),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(16.0)),
        ),
      ),
    );
  }
}
