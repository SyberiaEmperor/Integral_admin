import 'package:integral_admin/entities/api/order_from_api.dart';
import 'package:integral_admin/models/order_updater.dart';
import 'package:integral_admin/services/requests.dart';

class DioOrderConfirmer implements OrderConfirmer {
  final int orderId;

  DioOrderConfirmer(this.orderId);
  @override
  Future<FullOrder> updateStatus() async {
    return Requests.confirmOrder(orderId);
  }
}
