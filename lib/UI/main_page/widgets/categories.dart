import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/services/responsive_size.dart';

class Categories extends StatelessWidget {
  final Category selectedCategory;
  final List<Category> categories;
  final void Function(Category) onSelect;

  const Categories(
      {@required this.categories,
      @required this.selectedCategory,
      @required this.onSelect,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
            separatorBuilder: (context, index) =>
                SizedBox(width: ResponsiveSize.width(15)),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onSelect(categories[index]);
                },
                child: Container(
                  height: ResponsiveSize.height(47),
                  child: Center(
                    child: Text(
                      categories[index].asString,
                      style: (selectedCategory.index == index)
                          ? theme.accentTextTheme.bodyText2
                          : theme.accentTextTheme.bodyText1,
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
