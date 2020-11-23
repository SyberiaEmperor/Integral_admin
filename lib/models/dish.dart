import 'package:flutter/material.dart';

class Dish {
  final String id;
  final String name;
  final String description;
  final Set<Category> _categories;
  final String url;
  final int price;

  List<String> get categories => _categories.map((e) => e.asString).toList();

  Dish(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required Set<Category> categories,
      @required this.url,
      @required this.price})
      : _categories = categories;

  static Dish testDish() {
    return Dish(
      categories: {
        Category.starter,
        Category.plate,
        Category.sauce,
        Category.salad,
        Category.drinks,
        Category.bread
      },
      description:
          "Восхитительное блюдо! Пальчики оближешь и попросишь ещё этих мягких французских булочек, да выпьешь чаю. Нужно ещё больше букв, потому опишу я наш проект: Два приложения. В одном ты контролируешь блюда, в другом же - делаешь заказы, смотришь, что там и как, какие блюда есть, а каких нет.",
      id: "1",
      name: "Тестовое блюдо",
      price: 1000,
      url:
          "https://www.koolinar.ru/all_image/recipes/130/130352/recipe_be413881-ec26-47e2-ac5e-ffc284f1586a_large.jpg",
    );
  }

  static Dish testDish2() {
    return Dish(
      categories: {
        Category.starter,
        Category.plate,
        Category.sauce,
      },
      description:
          "Восхитительное блюдо! Пальчики оближешь и попросишь ещё этих мягких французских булочек, да выпьешь чаю. Нужно ещё больше букв, потому опишу я наш проект: Два приложения. В одном ты контролируешь блюда, в другом же - делаешь заказы, смотришь, что там и как, какие блюда есть, а каких нет.",
      id: "2",
      name: "Тестовое блюдо 2",
      price: 100,
      url: "https://chudo-povar.com/images/makarony-s-syrom-recept-s-foto.jpg",
    );
  }

  static Dish testDish3() {
    return Dish(
      categories: {
        Category.starter,
      },
      description:
          "Восхитительное блюдо! Пальчики оближешь и попросишь ещё этих мягких французских булочек, да выпьешь чаю. Нужно ещё больше букв, потому опишу я наш проект: Два приложения. В одном ты контролируешь блюда, в другом же - делаешь заказы, смотришь, что там и как, какие блюда есть, а каких нет.",
      id: "3",
      name: "Тестовое блюдо 3",
      price: 111,
      url:
          "https://www.koolinar.ru/all_image/recipes/144/144768/recipe_72eb979e-cfe7-47ba-852f-1a06e4618e49_large.jpg",
    );
  }

  factory Dish.fromData(Map<String, dynamic> data) {
    Set<Category> categories =
        data["catedories"].map((number) => Category.values[number]).toList();
    return Dish(
      categories: categories,
      description: data['description'],
      url: data['url'],
      id: data['id'],
      name: data['name'],
      price: data['price'],
    );
  }
}

enum Category {
  starter,
  plate,
  salad,
  drinks,
  bread,
  sauce,
}

extension str on Category {
  String get asString {
    switch (this) {
      case Category.starter:
        return "Первые блюда";
      case Category.plate:
        return "Вторые блюда";
      case Category.drinks:
        return "Напитки";
      case Category.bread:
        return "Хлеб";
      case Category.sauce:
        return "Соусы";
      case Category.salad:
        return "Салаты";
    }
    throw FormatException("Incorrect input data");
  }
}
