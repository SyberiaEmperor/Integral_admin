import 'package:flutter/material.dart';
import 'package:integral_admin/UI/orders_page/widgets/order_tile.dart';
import 'package:integral_admin/services/responsive_size.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: ResponsiveSize.height(40),
              width: ResponsiveSize.width(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).accentColor,
              ),
              child: Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OrderTile(),
            OrderTile(),
            OrderTile(),
            OrderTile(),
            OrderTile(),
            OrderTile(),
            OrderTile(),
            OrderTile(),
            OrderTile(),
          ],
        ),
      ),
    ));
  }
}
