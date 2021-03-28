import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:integral_admin/UI/routes/order_observe_route.dart';
import 'package:integral_admin/entities/api/order_from_api.dart';
import 'package:integral_admin/services/responsive_size.dart';

class OrderTile extends StatelessWidget {
  final OrderFromApi microOrder;

  const OrderTile({Key? key, required this.microOrder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          OrderObserveRoute(microOrder.id),
        );
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
                        'Заказ#${microOrder.id}',
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                      Text(
                        '${microOrder.creationDate}\n${microOrder.creationTime}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).accentTextTheme.bodyText1,
                      ),
                    ],
                  ),
                  Text(
                    'Какой-то текст',
                    style: Theme.of(context).accentTextTheme.bodyText1,
                  ),
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
