import 'package:flutter/material.dart';

Widget employeeTableCard(
    BuildContext context, Map<String, dynamic> tableObject) {
  return Card(
    elevation: 2.0,
    child: Column(children: [
      Container(
        width: MediaQuery.of(context).size.width < 1300
            ? MediaQuery.of(context).size.width - 100
            : MediaQuery.of(context).size.width - 330,
        padding: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
        child: Table(
          columnWidths: <int, TableColumnWidth>{
            0: FixedColumnWidth((MediaQuery.of(context).size.width / 3)),
            1: FixedColumnWidth((MediaQuery.of(context).size.width / 3)),
          },
          children: [
            TableRow(decoration: BoxDecoration(), children: [
              Container(
                padding: EdgeInsets.all(18),
                child: Text(
                  "Key",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(18),
                child: Text(
                  "Value",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width < 1300
            ? MediaQuery.of(context).size.width - 100
            : MediaQuery.of(context).size.width - 330,
        // padding: EdgeInsets.all(32),
        child: Table(
            columnWidths: <int, TableColumnWidth>{
              0: FixedColumnWidth((MediaQuery.of(context).size.width / 3)),
              1: FixedColumnWidth((MediaQuery.of(context).size.width / 3)),
            },
            children: List<TableRow>.generate(tableObject.keys.length, (i) {
              return TableRow(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 0.5, color: Colors.grey))),
                  children: [
                    Container(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        tableObject.keys.first.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        tableObject[tableObject.keys.first].toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                    )
                  ]);
            })),
      ),
    ]),
  );
}
