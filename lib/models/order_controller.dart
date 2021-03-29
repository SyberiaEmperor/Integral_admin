import 'package:integral_admin/entities/api/order_from_api.dart';

abstract class OrderController {
  Future<FullOrder> updateStatus();
  Future<void> deleteOrder();
}
