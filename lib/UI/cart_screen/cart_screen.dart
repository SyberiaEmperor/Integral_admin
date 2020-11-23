import 'package:flutter/material.dart';
import 'package:integral_admin/UI/cart_screen/widgets/dish_tile.dart';
import 'package:integral_admin/models/cart.dart';
import 'package:integral_admin/services/responsive_size.dart';

class CartScreen extends StatelessWidget {
  final Cart _cart;

  const CartScreen(this._cart);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          actions: [
            UnconstrainedBox(
              child: GestureDetector(
                onTap: () {
                  print("<<<Exit tapped.>>>");
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: ResponsiveSize.width(40),
                  height: ResponsiveSize.width(40),
                  decoration: BoxDecoration(
                    color: Color(0xffFF6077),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFFFF6077),
                      width: 0.5,
                    ),
                  ),
                  child: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                    size: 19,
                  ),
                ),
              ),
            ),
          ],
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Заказ",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "Количество позиций: ${_cart.totalCount} ",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 6,
              ),
              Expanded(
                child: ListView(
                  children: _cart.dishes.entries
                      .map((pair) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: DishTile(
                                dish: pair.key,
                                count: pair.value,
                                inc: () {
                                  print("inced");
                                },
                                dec: () {
                                  print("deced");
                                }),
                          ))
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Итого:',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText2.color,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .fontFamily,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "1.000.000 руб.",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        print("<<<Order>>>");
                      },
                      child: Container(
                        width: ResponsiveSize.width(200),
                        height: ResponsiveSize.width(52),
                        decoration: BoxDecoration(
                          color: Color(0xffFFDB60),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular((10)),
                              bottomLeft: Radius.circular((10))),
                        ),
                        child: Center(
                          child: Text(
                            'Заказать',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color,
                              fontSize: 18.width,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
