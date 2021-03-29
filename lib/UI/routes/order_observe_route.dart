import 'package:flutter/material.dart';

import 'package:integral_admin/UI/order_observe_page/order_observe_page.dart';
import 'package:integral_admin/UI/widgets/screen_with_updater.dart';

import 'package:integral_admin/entities/api/order_from_api.dart';
import 'package:integral_admin/entities/full_order_updater.dart';
import 'package:integral_admin/services/dio_order_controller.dart';

import 'package:integral_admin/services/requests.dart';

class OrderObserveRoute extends MaterialPageRoute {
  OrderObserveRoute(
    int orderId, {
    updatePeriod = const Duration(
      milliseconds: Requests.TIMEOUT,
    ),
  }) : super(
          builder: (context) {
            return ScreenWithUpdater<FullOrder>(
              updatePeriod: updatePeriod,
              confirmer: DioOrderController(orderId),
              updater: FullOrderUpdater(orderId),
              bodyBuilder: (ctx, order, confirm, delete, _) => OrderObservePage(
                  confirm: confirm, order: order, delete: delete),
            );
          },
        );
}
