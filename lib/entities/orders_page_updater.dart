import 'package:integral_admin/entities/api/order_from_api.dart';
import 'package:integral_admin/models/updater.dart';
import 'package:integral_admin/services/requests.dart';

class OrdersPageUpdater implements Updater<List<OrderFromApi>> {
  @override
  Future<List<OrderFromApi>> update() {
    return Requests.getAllOrders();
  }
}
