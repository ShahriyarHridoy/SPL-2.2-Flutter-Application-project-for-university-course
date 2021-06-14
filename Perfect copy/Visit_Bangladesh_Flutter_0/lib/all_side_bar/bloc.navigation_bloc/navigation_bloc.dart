import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:visit_bangladesh/all_side_bar/pages/logoutpage.dart';
import 'package:visit_bangladesh/all_side_bar/sidebar/sidebar.dart';
import 'package:visit_bangladesh/authentication/landing_page.dart';
import 'package:visit_bangladesh/authentication/sign_in/sign_in_page.dart';
import '../pages/myaccountspage.dart';
import '../pages/myorderspage.dart';

import '../pages/homepage.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyAccountClickedEvent,
  MyOrdersClickedEvent,
  LogoutClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  //NavigationStates get initialState => MyAccountsPage();
  NavigationBloc() : super(HomePage());


  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield MyAccountsPage();
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        yield MyOrdersPage();
        break;
      /*case NavigationEvents.LogoutClickedEvent:
        yield LogoutPage(onSignOut: () {  },);
        break;*/
    }
  }
}