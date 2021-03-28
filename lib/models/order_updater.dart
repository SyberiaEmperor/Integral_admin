import 'package:integral_admin/entities/api/order_from_api.dart';

abstract class OrderConfirmer {
  Future<FullOrder> updateStatus(int orderId);
}
