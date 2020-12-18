import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integral_admin/models/dish.dart';
import 'package:integral_admin/services/responsive_size.dart';

class Categories extends StatelessWidget {
  final int selectedCategory;
  final List<Category> categories;

  const Categories(this.categories, {Key key, this.selectedCategory = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) =>
              SizedBox(width: ResponsiveSize.width(15)),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: categories.length + 2,
          itemBuilder: (context, index) {
            if (index == 0 || index == categories.length + 1) {
              return SizedBox(
                width: ResponsiveSize.width(1),
              );
            }

            return Container(
              height: ResponsiveSize.height(47),
              child: Center(
                child: Text(
                  categories[index - 1].asString,
                  style: (selectedCategory == index - 1)
                      ? theme.accentTextTheme.bodyText2
                      : theme.accentTextTheme.bodyText1,
                ),
              ),
            );
          }),
    );
  }
}
