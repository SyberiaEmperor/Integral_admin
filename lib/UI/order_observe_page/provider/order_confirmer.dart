import 'package:flutter/cupertino.dart';
import 'package:integral_admin/models/order_updater.dart';
import 'package:integral_admin/services/requests.dart';

enum Status { executing, failed, success, idle }

class OrderConfirmerProvider with ChangeNotifier {
  Status status = Status.idle;
  final OrderConfirmer confirmer;

  OrderConfirmerProvider({
    required this.confirmer,
  });

  void confirm() async {
    status = Status.executing;
    notifyListeners();
    try {
      await confirmer.updateStatus();
      status = Status.success;
    } on RequestException {
      status = Status.failed;
    } finally {
      notifyListeners();
      status = Status.idle;
    }
  }
}
