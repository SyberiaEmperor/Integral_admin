import 'package:flutter/material.dart';
import 'package:integral_admin/UI/orders_page/widgets/order_tile.dart';
import 'package:integral_admin/UI/widgets/back_button.dart';
import 'package:integral_admin/blocs/update_bloc/update_bloc.dart';
import 'package:integral_admin/entities/api/order_from_api.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  final List<OrderFromApi> microOrders;
  final VoidCallback update;
  OrdersPage({Key? key, required this.microOrders, required this.update})
      : super(key: key);
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
      ),
    );
  }
}
