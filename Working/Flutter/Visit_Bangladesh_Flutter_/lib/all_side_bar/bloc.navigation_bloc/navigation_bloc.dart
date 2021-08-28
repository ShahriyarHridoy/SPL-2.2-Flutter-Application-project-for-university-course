import 'package:bloc/bloc.dart';
import 'package:visit_bangladesh/all_side_bar/currency_converter_feature/currency_convert.dart';
import 'package:visit_bangladesh/all_side_bar/pages/emergency_contract.dart';
import 'package:visit_bangladesh/all_side_bar/pages/my_places.dart';
import 'package:visit_bangladesh/all_side_bar/weather_feature/weatherPage.dart';
import '../pages/myaccountspage.dart';
import '../pages/add_tourist_place.dart';
import '../pages/homepage.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyAccountClickedEvent,
  EmergencyContractClickedEvent,
  MyOrdersClickedEvent,
  WeatherCheckClickedEvent,
  CurrencyConvertCheckClickedEvent,
  MyPlacesCheckClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  //NavigationStates get initialState => MyAccountsPage();
  NavigationBloc() : super(HomePage());


  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {

      case NavigationEvents.EmergencyContractClickedEvent:
        yield EmergencyContract();
        break;
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield AccountPage();
        break;
      case NavigationEvents.WeatherCheckClickedEvent:
        yield Weather_Page();
        break;
      case NavigationEvents.CurrencyConvertCheckClickedEvent:
        yield CurrencyConvert();
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        yield AddTouristPlace();
        break;
      case NavigationEvents.MyPlacesCheckClickedEvent:
        yield MyPlace();
        break;
     /* case NavigationEvents.FormCheckClickedEvent:
        yield FormPage();
        break;*/
    }
  }
}