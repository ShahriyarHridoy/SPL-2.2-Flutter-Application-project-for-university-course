import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({
    this.child,
    this.color,
    this.borderRadius: 16,
    this.height: 50.0,
    this.onPressed,
  }) : assert(borderRadius != null);
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      // ignore: deprecated_member_use
      child: RaisedButton(
        child: child,
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        onPressed: onPressed,
      ),
    );
  }
}

/*
RaisedButton(
child: Text("Sign in Google", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
color: Colors.deepOrange[400],
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.all(Radius.circular(16.0))
),
onPressed: (){ print("button pressed");},
);*/

/*Container(
            color: Colors.orange,
            child: SizedBox(
              height: 100.0,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.red[400],
            child: SizedBox(
              height: 100.0,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.indigo[400],
            child: SizedBox(
              height: 100.0,
            ),
          ),*/
