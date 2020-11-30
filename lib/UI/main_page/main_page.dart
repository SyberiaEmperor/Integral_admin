import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integral_admin/UI/dish_create_page/dish_create_page.dart';
import 'package:integral_admin/UI/main_page/widgets/categories.dart';
import 'package:integral_admin/UI/main_page/widgets/dish_tile.dart';
import 'package:integral_admin/UI/main_page/widgets/market_title.dart';
import 'package:integral_admin/UI/main_page/widgets/search.dart';
import 'package:integral_admin/UI/orders_page/orders_page.dart';
import 'package:integral_admin/models/cart.dart';
import 'package:integral_admin/models/dish.dart';
import 'package:integral_admin/services/responsive_size.dart';

class MainPage extends StatelessWidget {
  List<Dish> dishes = [
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DishCreateScreen()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0.0,
          leading: Padding(
            padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrdersPage()));
              },
              child: Container(
                  height: ResponsiveSize.height(40),
                  width: ResponsiveSize.width(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).accentColor,
                  ),
                  child: Icon(
                    Icons.description,
                    size: 20,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [
            //UpperButtons(),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        MarketTitle(),
                      ],
                    ),
                  ),
                  SliverAppBar(
                    elevation: 0.0,
                    stretch: true,
                    collapsedHeight: ResponsiveSize.height(115),
                    expandedHeight: ResponsiveSize.height(115),
                    backgroundColor: Theme.of(context).backgroundColor,
                    flexibleSpace: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Search(),
                        SizedBox(height: ResponsiveSize.height(24)),
                        Categories(
                          Category.values,
                          selectedCategory: 3,
                        ),
                        SizedBox(height: ResponsiveSize.height(26)),
                      ],
                    ),
                    pinned: true,
                    centerTitle: true,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(dishesCards(dishes)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
