import 'package:flutter/material.dart';
import 'package:integral_admin/UI/orders_page/widgets/order_tile.dart';
import 'package:integral_admin/UI/widgets/back_button.dart';

import 'package:integral_admin/entities/api/order_from_api.dart';
import 'package:integral_admin/services/singletone.dart';

class OrdersPage extends StatelessWidget {
  final List<OrderFromApi> microOrders;
  final VoidCallback update;
  OrdersPage({Key? key, required this.microOrders, required this.update})
      : super(key: key) {
    Singletone().update = update;
  }

  Widget body() {
    if (microOrders.isEmpty) {
      return const Center(
        child: Text('У Вас пока что нет заказов.'),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: List<Widget>.from(
            microOrders.map(
              (order) => OrderTile(microOrder: order),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0.0,
          leading: BackButtonLeading(),
        ),
        body: body(),
      ),
    );
  }
}
