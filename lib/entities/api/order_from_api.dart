import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/entities/order_dish.dart';
import 'package:integral_admin/resources/app_strings.dart';

class OrderFromApi {
  final int id;
  final String orderQueue;
  final double total;
  final DateTime createdAt;

  ///Returns hours and minutes of it's creation in hh:mm format
  String get creationTime =>
      '${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}';

  ///Return date of it's creation in dd.mm.yyyy format
  String get creationDate =>
      '${createdAt.day.toString().padLeft(2, '0')}.${createdAt.month.toString().padLeft(2, '0')}.${createdAt.year}';

  OrderFromApi(
      {required this.id,
      required this.orderQueue,
      required this.total,
      required this.createdAt});

  OrderFromApi.copy(OrderFromApi order)
      : id = order.id,
        orderQueue = order.orderQueue,
        total = order.total,
        createdAt = order.createdAt;

  factory OrderFromApi.fromJson(Map<String, dynamic> data) {
    int id = data[ApiStrings.ID];
    String orderQueue = data[ApiStrings.ORDER_QUEUE] ?? '';
    double total = double.parse(data[ApiStrings.TOTAL_PRICE] ?? '-42');
    DateTime createdAt = DateTime.parse(data[ApiStrings.CREATED_AT]);
    return OrderFromApi(
        createdAt: createdAt, id: id, total: total, orderQueue: orderQueue);
  }

  @override
  String toString() =>
      '{id: $id, orderQueue: $orderQueue, total: $total, createdAt: $createdAt}';
}

class FullOrder extends OrderFromApi {
  final List<OrderDish> dishes;

  FullOrder({required OrderFromApi order, required this.dishes})
      : super.copy(order);

  @override
  factory FullOrder.fromJson(Map<String, dynamic> data) {
    var order = OrderFromApi.fromJson(data);
    List<dynamic> orderDishesData =
        List.castFrom(data[ApiStrings.ORDER_DISHES]);
    var dish = OrderDish.fromJson(orderDishesData.first);
    List<OrderDish> dishes = orderDishesData.map(
      (orderDish) {
        return OrderDish.fromJson(orderDish);
      },
    ).toList();
    return FullOrder(order: order, dishes: dishes);
  }

  factory FullOrder.testOrder() {
    var orderDishes = [
      OrderDish(dish: Dish.testDish(), quantity: 5),
      OrderDish(dish: Dish.testDish2(), quantity: 3),
      OrderDish(dish: Dish.testDish3(), quantity: 1),
    ];

    OrderFromApi order = OrderFromApi(
        id: 1,
        createdAt: DateTime.now(),
        orderQueue: "НЕИЗВЕСТНО",
        total: 100.5);

    return FullOrder(
      order: order,
      dishes: orderDishes,
    );
  }
}
