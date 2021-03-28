import 'package:integral_admin/resources/app_strings.dart';

import '../dish.dart';

class OrderToApi {
  final double totalPrice;
  final List<OrderItemToApi> items;

  OrderToApi({required this.totalPrice, required this.items});

  factory OrderToApi.fromCart(Map<Dish, int> dishes, double totalPrice) {
    List<OrderItemToApi> items = [];
    dishes.forEach(
      (
        dish,
        quantity,
      ) {
        items.add(OrderItemToApi(dishId: dish.id, quantity: quantity));
      },
    );
    return OrderToApi(items: items, totalPrice: totalPrice);
  }

  Map<String, dynamic> toJson() {
    return {
      ApiStrings.TOTAL_PRICE: totalPrice,
      ApiStrings.ORDER_DISHES: List.from(items.map((item) => item.toJson())),
    };
  }
}

class OrderItemToApi {
  final int quantity;
  final String dishId;

  OrderItemToApi({required this.quantity, required this.dishId});

  Map<String, int> toJson() {
    return {
      ApiStrings.QUANTITY: quantity,
      ApiStrings.DISH_ID: int.parse(dishId),
    };
  }
}
