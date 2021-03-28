import 'package:flutter/material.dart';
import 'package:integral_admin/UI/order_observe_page/order_observe_page.dart';
import 'package:integral_admin/UI/order_observe_page/provider/order_confirmer.dart';
import 'package:integral_admin/UI/widgets/screen_with_updater.dart';
import 'package:integral_admin/entities/api/order_from_api.dart';
import 'package:integral_admin/entities/full_order_updater.dart';
import 'package:integral_admin/services/dio_order_confirmer.dart';
import 'package:integral_admin/services/requests.dart';
import 'package:provider/provider.dart';

class OrderObserveRoute extends MaterialPageRoute {
  OrderObserveRoute(
    int orderId, {
    updatePeriod = const Duration(
      milliseconds: Requests.TIMEOUT,
    ),
  }) : super(builder: (context) {
          OrderConfirmerProvider provider =
              OrderConfirmerProvider(confirmer: DioOrderConfirmer(orderId));
          return ScreenWithUpdater<FullOrder>(
            updatePeriod: updatePeriod,
            updater: FullOrderUpdater(orderId),
            bodyBuilder: (ctx, order) => ChangeNotifierProvider.value(
              value: provider,
              child: OrderObservePage(
                order: order,
              ),
            ),
          );
        });
}
