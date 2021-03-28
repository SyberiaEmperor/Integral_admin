import 'package:integral_admin/entities/api/order_from_api.dart';
import 'package:integral_admin/models/updater.dart';
import 'package:integral_admin/services/requests.dart';

class FullOrderUpdater implements Updater<FullOrder> {
  final int orderId;

  FullOrderUpdater(this.orderId);
  @override
  Future<FullOrder> update() async {
    return Requests.getOrderById(orderId);
  }
}
