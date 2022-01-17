import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  int duration = 0;
  Widget goToPage;

  SplashPage({ this.goToPage, this.duration });

  @override 
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2 ), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => this.goToPage)
      );
      });
    //});
    return Scaffold(
      body: Container(
        color: Color(0xFF80C038),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                    'assets/images/travel-background.jpg',
                    fit: BoxFit.cover),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                strokeWidth: 10,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withOpacity(0.5)),
              ),
            ),
            )
          ],
        )
      )
    );
  }
}

/*class IconFont extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Visit Bangladesh',
      style: TextStyle(
      color: Colors.white,
        fontSize: 100,
        fontFamily: 'orilla'
    ),);
  }
}*/
