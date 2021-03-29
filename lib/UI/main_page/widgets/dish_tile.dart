import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integral_admin/UI/dish_edit_page/dish_edit_page.dart';
import 'package:integral_admin/blocs/main_page_bloc/mainpage_bloc.dart';
import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/models/dish_edit_modes.dart';
import 'package:integral_admin/services/responsive_size.dart';

class DishTile extends StatelessWidget {
  final Dish dish;

  const DishTile(this.dish);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: GestureDetector(
        onTap: () async {
          bool status = await (Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DishEditScreen<DishChange>.edit(dish),
            ),
          ) as Future<bool>);
          if (status) {
            BlocProvider.of<MainPageBloc>(context).add(Update());
          }
        },
        child: Container(
          //color: Colors.black,
          width: ResponsiveSize.width(330),
          height: ResponsiveSize.height(120),
          child: Stack(
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: ResponsiveSize.width(280),
                  height: ResponsiveSize.height(120),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ResponsiveSize.height(10)),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: ResponsiveSize.height(15.08),
                      bottom: ResponsiveSize.height(16.92),
                    ),
                    child: Container(
                        //margin:
                        //EdgeInsets.only(right: ResponsiveSize.width(11.9)),
                        width: ResponsiveSize.width(100.83),
                        height: ResponsiveSize.height(88),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(dish.url!),
                        )),
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
                    child: Container(
                      width: ResponsiveSize.width(56),
                      height: ResponsiveSize.height(40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(ResponsiveSize.height(10)),
                            bottomRight:
                                Radius.circular(ResponsiveSize.height(10))),
                        color: Theme.of(context).accentColor,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: ResponsiveSize.height(20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> dishesCards(List<Dish> dishes) {
  List<Widget> items = [];

  for (var dish in dishes) {
    items.add(Padding(
      padding: EdgeInsets.only(
        //right: ResponsiveSize.width(17.58),
        left: ResponsiveSize.width(20),
      ),
      child: DishTile(dish),
    ));
    items.add(SizedBox(height: 10));
  }

  return items;
}
