import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
import 'package:visit_bangladesh/common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton(
      {@required String assetName,
      @required String text,
      Color color,
      Color textColor,
      VoidCallback onPressed})
      : assert(text != null),
        assert(assetName != null),super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(assetName),
              Text(
                text,
                style: TextStyle(
                    color: textColor,
                    fontSize: 18, fontWeight: FontWeight.bold,
                   ),
              ),
              Opacity(
                opacity: 0.0,
                child: Image.asset(assetName),
              ),
            ],
          ),
          color: color,
          onPressed: onPressed,
        );
}
