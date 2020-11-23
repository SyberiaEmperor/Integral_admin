import 'package:flutter/material.dart';
import 'package:integral_admin/models/dish.dart';
import 'package:integral_admin/services/responsive_size.dart';

typedef _IncrementCallback = Function();
typedef _DecrementCallback = Function();

class DishTile extends StatelessWidget {
  final Dish dish;
  final int count;
  final _IncrementCallback inc;
  final _DecrementCallback dec;

  const DishTile(
      {@required this.dish,
      @required this.count,
      @required this.inc,
      @required this.dec});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: GestureDetector(
        onTap: () {
          print("Tapped");
        },
        child: Container(
          width: ResponsiveSize.width(330),
          height: ResponsiveSize.height(120),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ResponsiveSize.height(10)),
              gradient: LinearGradient(colors: [
                Theme.of(context).backgroundColor,
                Theme.of(context).accentColor
              ])),
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
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              OverContainerContent(dish),
              Align(
                alignment: Alignment(0.988, 0),
                child: CountField(
                  count: count,
                  inc: inc,
                  dec: dec,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountField extends StatelessWidget {
  final int count;
  final _IncrementCallback inc;
  final _DecrementCallback dec;

  const CountField(
      {@required this.count, @required this.inc, @required this.dec});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: inc,
          child: Icon(
            Icons.add,
            size: 24,
            color: Colors.white,
          ),
        ),
        Text(
          count.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        GestureDetector(
          onTap: dec,
          child: Icon(
            Icons.remove,
            size: 24,
            color: Colors.white,
          ),
        ),
      ],
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
            backgroundImage: NetworkImage(dish.url),
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
                "${dish.price}Р",
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
