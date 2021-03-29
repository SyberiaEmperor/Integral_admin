import 'package:integral_admin/entities/api/order_from_api.dart';
import 'package:integral_admin/models/order_controller.dart';
import 'package:integral_admin/services/requests.dart';

class DioOrderController implements OrderController {
  final int orderId;

  DioOrderController(this.orderId);
  @override
  Future<FullOrder> updateStatus() async {
    return Requests.confirmOrder(orderId);
  }

  @override
  Future<void> deleteOrder() {
    throw UnimplementedError();
  }
}
