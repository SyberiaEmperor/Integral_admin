import 'package:flutter/cupertino.dart';
import 'package:integral_admin/UI/order_observe_page/widgets/order_dish_tile.dart';
import 'package:integral_admin/entities/order_dish.dart';
import 'package:integral_admin/services/responsive_size.dart';

class DishOrderList extends StatelessWidget {
  final List<OrderDish> dishes;

  const DishOrderList({Key? key, required this.dishes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: dishes
          .map((e) => Padding(
              padding: EdgeInsets.only(top: 10.height),
              child: DishOrderTile(orderDish: e)))
          .toList(),
    );
  }
}
