import 'package:integral_admin/models/dish_controller.dart';
import 'package:integral_admin/services/requests.dart';

import 'dish.dart';

class TestDishController implements DishController {
  List<Dish> _dishes = [
    Dish.testDish(),
    Dish.testDish2(),
    Dish.testDish3(),
    Dish.testDish(),
    Dish.testDish2(),
    Dish.testDish3(),
    Dish.testDish(),
    Dish.testDish2(),
    Dish.testDish3()
  ];

  @override
  List<Dish> search(String text) {
    List<Dish> result = [];

    for (var dish in _dishes) {
      if (result.contains(dish)) continue;

      if (dish.name.toLowerCase().contains(text)) {
        result.add(dish);
      } else if (dish.description.toLowerCase().contains(text)) {
        result.add(dish);
      } else if (dish.categories
          .any((element) => element.toLowerCase().contains(text))) {
        result.add(dish);
      }
    }

    return result;
  }

  @override
  List<Dish> byCategory(Category category) {
    if (category == Category.all) {
      return _dishes;
    }
    return _dishes.where((dish) => dish.containsCategory(category)).toList();
  }

  @override
  Future<void> updateDishes() async {
    _dishes = await Requests.getDishes();
  }
}
