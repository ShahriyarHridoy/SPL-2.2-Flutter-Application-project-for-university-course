import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:visit_bangladesh/all_side_bar/bloc.navigation_bloc/navigation_bloc.dart';

class CurrencyConvert extends StatefulWidget with NavigationStates {
  @override
  _CurrencyConvertState createState() => _CurrencyConvertState();
}

class _CurrencyConvertState extends State<CurrencyConvert> {
  bool num1 = false;
  bool from = false;
  bool end = false;
  double rate1;
  double rate2;
  double result1 = 0;
  double result2 = 0;
  TextEditingController controller = TextEditingController();
  String dropvalue, tovalue;
  final key = GlobalKey<ScaffoldState>();
  final list = [
    "BDT",
    "NPR",
    "CNY",
    "INR",
    "USD",
    "EUR",
    "JPY",
    "BGN",
    "CZK",
    "DKK",
    "GBP",
    "HUF",
    "PLN",
    "SEK",
    "CHF",
    "AUD",
    "BRL",
    "CAD",
    "CNY",
    "RUB",
    "HKD",
    "NOK",
    "ILS",
    "KRW",
    "NZD",
    "PHP",
    "ZAR",
    "THB",
    "SGD",
    "RON",
    "HRK",
    "ISK",
    "IDR",
    "TRY",
    "MXN"
  ];



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 1000,
        //padding: EdgeInsets.all(10),
        child: Material(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(height: 70, width: 100,),
              Image.asset(
                "assets/images/currency_exchange_logo.png",
                fit: BoxFit.cover,
              ),
              Text(
                "Welcome",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Amount",
                        labelText: "Enter currency Amount",
                      ),
                      onChanged: (value) {
                        setState(() {
                          num1 = true;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: dropvalue,
                      hint: Text("From"),
                      items: list.map((String value) {
                        return new DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropvalue = value;
                          from = true;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: tovalue,
                      hint: Text("To"),
                      items: list.map((String value) {
                        return new DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          tovalue = value;
                          end = true;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      child: Text(
                        "Convert",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (num1 == true && from == true && end == true) {



                          final response2 = await http.get(Uri.parse(
                              "https://api.exchangerate.host/convert?from=$dropvalue&to=$tovalue"));
                          if (response2.statusCode == 200) {
                            Map<String, dynamic> jsonrate2 =
                            jsonDecode(response2.body);
                            print("33333333333333333333");

                            print("/////////////////////////////////");
                            print(jsonrate2);

                            print("1st rate ");
                            print(rate1);
                            rate2= jsonrate2["info"]["rate"];
                            print(rate2);
                            print("33333333333333333333");
                            result1 = rate1 * (double.parse(controller.text));
                            result2 = rate2 * (double.parse(controller.text));
                            print(result1);
                            print(result2);
                          }

                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(32.0))),
                                  contentPadding: EdgeInsets.only(top: 10.0),
                                  content: SingleChildScrollView(
                                    child: Container(
                                      height: 150.0,
                                      width: 300.0,
                                      child: Center(child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Center(
                                                child: Text(
                                                  "Rate",
                                                  style: TextStyle(fontSize: 24.0),
                                                ),
                                              )
                                              /*Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Icon(
                                                Icons.star_border,
                                                color: Color(0xff00bfa5),
                                                size: 30.0,
                                              ),
                                              Icon(
                                                Icons.star_border,
                                                color: Color(0xff00bfa5),
                                                size: 30.0,
                                              ),
                                              Icon(
                                                Icons.star_border,
                                                color: Color(0xff00bfa5),
                                                size: 30.0,
                                              ),
                                              Icon(
                                                Icons.star_border,
                                                color: Color(0xff00bfa5),
                                                size: 30.0,
                                              ),
                                              Icon(
                                                Icons.star_border,
                                                color: Color(0xff00bfa5),
                                                size: 30.0,
                                              ),
                                            ],
                                          ),*/
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Divider(
                                            color: Colors.grey,
                                            height: 4.0,
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 30.0, right: 30.0),
                                            child: Center(
                                                child: Container(
                                                  height: 30,
                                                  child: Text("Total : $result2 $tovalue"),
                                                )
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 30.0, right: 30.0),
                                            child: Center(
                                                child: Container(
                                                  height: 30,
                                                  child: Text("Exchange rate is $rate2"),
                                                )
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                        ],
                                      ),),
                                    ),
                                  ),
                                  actions: [
                                    InkWell(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 20.0, bottom: 20.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xff00bfa5),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(32.0),
                                              bottomRight: Radius.circular(32.0)),
                                        ),
                                        child: Text("Close"),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Enter missing fields"),
                            action: SnackBarAction(
                                label: "OK",
                                onPressed:
                                Scaffold.of(context).hideCurrentSnackBar),
                          ));
                        }
                      },
                      color: Colors.purple[800],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
