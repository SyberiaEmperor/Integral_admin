import 'package:integral_admin/services/requests.dart';

class Dish {
  final String id;
  final String name;
  final String description;
  final Set<Category> _categories;
  final String? url;
  final bool visible;
  final int price;

  List<String> get categories => _categories.map((e) => e.asString).toList();

  bool containsCategory(Category category) {
    return _categories.contains(category);
  }

  Dish(
      {required this.id,
      required this.name,
      required this.description,
      required Set<Category> categories,
      required this.url,
      required this.visible,
      required this.price})
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
      visible: true,
      description:
          'Восхитительное блюдо! Пальчики оближешь и попросишь ещё этих мягких французских булочек, да выпьешь чаю. Нужно ещё больше букв, потому опишу я наш проект: Два приложения. В одном ты контролируешь блюда, в другом же - делаешь заказы, смотришь, что там и как, какие блюда есть, а каких нет.',
      id: '1',
      name: 'Тестовое блюдо',
      price: 1000,
      url:
          'https://www.koolinar.ru/all_image/recipes/130/130352/recipe_be413881-ec26-47e2-ac5e-ffc284f1586a_large.jpg',
    );
  }

  static Dish testDish2() {
    return Dish(
      categories: {
        Category.starter,
        Category.plate,
        Category.sauce,
      },
      visible: false,
      description:
          'Восхитительное блюдо! Пальчики оближешь и попросишь ещё этих мягких французских булочек, да выпьешь чаю. Нужно ещё больше букв, потому опишу я наш проект: Два приложения. В одном ты контролируешь блюда, в другом же - делаешь заказы, смотришь, что там и как, какие блюда есть, а каких нет.',
      id: '2',
      name: 'Тестовое блюдо 2',
      price: 100,
      url: 'https://chudo-povar.com/images/makarony-s-syrom-recept-s-foto.jpg',
    );
  }

  static Dish testDish3() {
    return Dish(
      categories: {
        Category.starter,
      },
      description:
          'Восхитительное блюдо! Пальчики оближешь и попросишь ещё этих мягких французских булочек, да выпьешь чаю. Нужно ещё больше букв, потому опишу я наш проект: Два приложения. В одном ты контролируешь блюда, в другом же - делаешь заказы, смотришь, что там и как, какие блюда есть, а каких нет.',
      id: '3',
      visible: true,
      name: 'Тестовое блюдо 3',
      price: 111,
      url:
          'https://www.koolinar.ru/all_image/recipes/144/144768/recipe_72eb979e-cfe7-47ba-852f-1a06e4618e49_large.jpg',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'categories': (_categories.map((e) => e.index).toList()),
      'picture': url != null
          ? ((url!.length > 100) ? 'data:image/jpeg;base64,' + url! : url)
          : null,
    };
  }

  factory Dish.fromData(Map<String, dynamic> data) {
    Set<Category> categories = Set<Category>.from(
        data['categories'].map((number) => Category.values[number]));
    return Dish(
      categories: categories,
      description: data['description'],
      url: Requests.BASE_URI + data['picture']['url'],
      id: data['id'].toString(),
      name: data['name'],
      visible: data['visible'],
      price: data['price'],
    );
  }
}

enum Category {
  all,
  starter,
  plate,
  salad,
  drinks,
  bread,
  sauce,
}

extension Str on Category {
  String get asString {
    switch (this) {
      case Category.all:
        return 'Все';
      case Category.starter:
        return 'Первые блюда';
      case Category.plate:
        return 'Вторые блюда';
      case Category.drinks:
        return 'Напитки';
      case Category.bread:
        return 'Хлеб';
      case Category.sauce:
        return 'Соусы';
      case Category.salad:
        return 'Салаты';
    }
  }
}

extension CategoriesExt on Category {
  static List<Category> get excludeAll {
    return Category.values.sublist(1);
  }
}
