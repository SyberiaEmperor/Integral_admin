import 'package:flutter/material.dart';
import 'package:integral_admin/UI/orders_page/widgets/order_tile.dart';
import 'package:integral_admin/UI/widgets/back_button.dart';
import 'package:integral_admin/entities/api/order_from_api.dart';

class OrdersPage extends StatelessWidget {
  final List<OrderFromApi> microOrders;

  const OrdersPage({Key? key, required this.microOrders}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        leading: BackButtonLeading(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List<Widget>.from(
            microOrders.map(
              (order) => OrderTile(microOrder: order),
            ),
          ),
        ),
      ),
    ));
  }
}
