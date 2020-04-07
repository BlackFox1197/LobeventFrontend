import 'package:auditergy_flutter/ui/pages/dashboard/employees/employee_dashboard_card_widget.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/market/market_item_dashboard_card_widget.dart';
import 'package:flutter/material.dart';

import 'package:auditergy_flutter/ui/utils/raw_data.dart';
import 'package:auditergy_flutter/ui/widgets/ticket_cards.dart';

class MarketPage extends StatefulWidget {
  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Stack(
      children: [
        CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).size.width > 1300 ? 4 : 3,
                childAspectRatio:
                    MediaQuery.of(context).size.width < 1300 ? 0.6 : 0.65,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildListDelegate(
                [
                  MarketItemDashboardCardWidget(),
                  MarketItemDashboardCardWidget(),
                  MarketItemDashboardCardWidget(),
                ],
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.lightBlue,
              tooltip: "Add Employee",
            ),
          ),
        ),
      ],
    );
  }
}
