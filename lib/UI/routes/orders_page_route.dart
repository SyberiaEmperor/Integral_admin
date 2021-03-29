import 'package:flutter/material.dart';
import 'package:integral_admin/UI/orders_page/orders_page.dart';
import 'package:integral_admin/UI/widgets/screen_with_updater.dart';
import 'package:integral_admin/entities/api/order_from_api.dart';
import 'package:integral_admin/entities/orders_page_updater.dart';
import 'package:integral_admin/services/requests.dart';

class OrdersPageRoute extends MaterialPageRoute {
  OrdersPageRoute({
    updatePeriod = const Duration(
      milliseconds: Requests.TIMEOUT,
    ),
  }) : super(
          builder: (context) => ScreenWithUpdater<List<OrderFromApi>>(
            updatePeriod: updatePeriod,
            updater: OrdersPageUpdater(),
            bodyBuilder: (context, orders, _, __) =>
                OrdersPage(microOrders: orders),
          ),
        );
}
