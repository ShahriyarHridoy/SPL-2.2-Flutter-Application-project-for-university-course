import 'package:flutter/cupertino.dart';
import 'package:visit_bangladesh/all_side_bar/pages/myaccountspage.dart';

class Routes {
  Routes._();
  static const String profile= '/profilepage';

  static final routes = <String, WidgetBuilder>{
    profile: (BuildContext context) => AccountPage(),
  };
}