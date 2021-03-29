import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/entities/order_dish.dart';
import 'package:integral_admin/services/responsive_size.dart';

class DishOrderTile extends StatelessWidget {
  final OrderDish orderDish;

  const DishOrderTile({Key? key, required this.orderDish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: GestureDetector(
        onTap: () {
          print('Tapped');
        },
        child: Container(
          width: ResponsiveSize.width(330),
          height: ResponsiveSize.height(120),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1.0, 2.0),
                blurRadius: 3.0,
              )
            ],
            borderRadius: BorderRadius.circular(ResponsiveSize.height(10)),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).backgroundColor,
                Theme.of(context).accentColor
              ],
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  width: ResponsiveSize.width(280),
                  height: ResponsiveSize.height(120),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ResponsiveSize.height(10)),
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
              ),
              OverContainerContent(orderDish.dish),
              Align(
                alignment: Alignment(0.955, 0),
                child: Text(
                  orderDish.quantity.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18.height,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OverContainerContent extends StatelessWidget {
  final Dish dish;
  OverContainerContent(this.dish);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: ResponsiveSize.height(15.08),
            bottom: ResponsiveSize.height(16.92),
          ),
          child: CircleAvatar(
            radius: 44,
            backgroundImage: NetworkImage(dish.url!),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: ResponsiveSize.width(103),
              child: Text(
                dish.name,
                style: Theme.of(context).accentTextTheme.bodyText2,
              ),
            ),
            SizedBox(height: ResponsiveSize.height(6)),
            Container(
              width: ResponsiveSize.width(100),
              height: ResponsiveSize.height(16),
              child: Text(
                dish.description,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).accentTextTheme.bodyText1,
              ),
            ),
            SizedBox(height: ResponsiveSize.height(16)),
            Container(
              width: ResponsiveSize.width(61),
              child: Text(
                '${dish.price}Р',
                style: Theme.of(context).accentTextTheme.bodyText2,
              ),
            ),
          ],
        ),
        SizedBox(width: ResponsiveSize.width(45.5)),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(),
        ),
      ],
    );
  }
}
