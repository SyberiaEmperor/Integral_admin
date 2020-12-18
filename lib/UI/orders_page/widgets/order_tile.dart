import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integral_admin/UI/order_observe_page/order_observe_page.dart';
import 'package:integral_admin/services/responsive_size.dart';

class OrderTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderObservePage()));
      },
      child: Container(
        height: ResponsiveSize.height(60),
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            border:
                Border(top: BorderSide(color: Theme.of(context).primaryColor))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: ResponsiveSize.width(10),
                right: ResponsiveSize.width(15),
              ),
              child: CircleAvatar(
                radius: ResponsiveSize.height(25),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Заказ#2151512',
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                      Text('21.01.2020',
                          style: Theme.of(context).accentTextTheme.bodyText1),
                    ],
                  ),
                  Text('Какой-то текст',
                      style: Theme.of(context).accentTextTheme.bodyText1),
                ],
              ),
            ),
            SizedBox(
              width: ResponsiveSize.width(15),
            )
          ],
        ),
      ),
    );
  }
}
