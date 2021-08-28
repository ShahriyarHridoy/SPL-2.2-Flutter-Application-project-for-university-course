import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visit_bangladesh/all_side_bar/bloc.navigation_bloc/navigation_bloc.dart';

class EmergencyContract extends StatelessWidget with NavigationStates {
  String url;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          height: 800,
          //margin: EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 60,
                width: 50,
              ),
              Center(
                  child: Text(
                'Emergency Contract List',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 20,
                width: 50,
              ),
              Flexible(
                child: DataTable(
                  columnSpacing: 5,
                  columns: [
                    DataColumn(
                        label: Text('ID',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Name',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Click here',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Police, Fire Service, Ambulance Service')),
                      DataCell(
                        ElevatedButton.icon(
                            icon: Icon(Icons.phone),
                            label: Text('Call'),
                            onPressed: () {
                              url = "tel:999}";
                              _callNumber();
                            }),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('2')),
                      DataCell(Text('Various government service')),
                      DataCell(
                        ElevatedButton.icon(
                            icon: Icon(Icons.phone),
                            label: Text('Call'),
                            onPressed: () {
                              url = "tel:333}";
                              _callNumber();
                            }),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('3')),
                      DataCell(Text('Women and Children are abused')),
                      DataCell(
                        ElevatedButton.icon(
                            icon: Icon(Icons.phone),
                            label: Text('Call'),
                            onPressed: () {
                              url = "tel:109}";
                              _callNumber();
                            }),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('4')),
                      DataCell(Text('Dudok Helpline')),
                      DataCell(
                        ElevatedButton.icon(
                            icon: Icon(Icons.phone),
                            label: Text('Call'),
                            onPressed: () {
                              url = "tel:106}";
                              _callNumber();
                            }),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('5')),
                      DataCell(Text('Disaster Warning in advances')),
                      DataCell(
                        ElevatedButton.icon(
                            icon: Icon(Icons.phone),
                            label: Text('Call'),
                            onPressed: () {
                              url = "tel:1090}";
                              _callNumber();
                            }),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('6')),
                      DataCell(Text('Bangladesh Police Helpdesk')),
                      DataCell(
                        ElevatedButton.icon(
                            icon: Icon(Icons.phone),
                            label: Text('Call'),
                            onPressed: () {
                              url = "tel:100}";
                              _callNumber();
                            }),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('7')),
                      DataCell(Text('RAB Helpdesk')),
                      DataCell(
                        ElevatedButton.icon(
                            icon: Icon(Icons.phone),
                            label: Text('Call'),
                            onPressed: () {
                              url = "tel:101}";
                              _callNumber();
                            }),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('8')),
                      DataCell(Text('Fire Service Hotline')),
                      DataCell(
                        ElevatedButton.icon(
                            icon: Icon(Icons.phone),
                            label: Text('Call'),
                            onPressed: () {
                              url = "tel:102}";
                              _callNumber();
                            }),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('9')),
                      DataCell(Text('National Identy Card')),
                      DataCell(
                        ElevatedButton.icon(
                            icon: Icon(Icons.phone),
                            label: Text('Call'),
                            onPressed: () {
                              url = "tel:105}";
                              _callNumber();
                            }),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('10')),
                      DataCell(Text('Government Legal Assistance')),
                      DataCell(
                        ElevatedButton.icon(
                            icon: Icon(Icons.phone),
                            label: Text('Call'),
                            onPressed: () {
                              url = "tel:16403}";
                              _callNumber();
                            }),
                      ),
                    ]),
                  ],
                ),
              )
            ],
          )),
    );
  }

  _callNumber() async {
    //set the number here
    print("call test ----------------------");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch ${url}';
    }
  }
}
