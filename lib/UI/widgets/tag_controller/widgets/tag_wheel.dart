import 'package:flutter/material.dart';
import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/services/responsive_size.dart';

class Modal {
  static Category? category;

  static Future<Category?> mainBottomSheet(
      BuildContext context, Set<Category> cats) {
    void mapToType(int index) {
      category = cats.toList()[index];
      print(category);
    }

    category = cats.isNotEmpty ? cats.toList().first : null;

    return showModalBottomSheet<Category?>(
        enableDrag: true,
        backgroundColor: Theme.of(context).backgroundColor,
        context: context, //
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: ResponsiveSize.height(200),
                child: ListWheelScrollView.useDelegate(
                  physics: BouncingScrollPhysics(),
                  diameterRatio: 1.5,
                  itemExtent: ResponsiveSize.height(40),
                  useMagnifier: true,
                  magnification: 1.5,
                  onSelectedItemChanged: mapToType,
                  childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        print(category);
                        return Container(
                          width: ResponsiveSize.width(100),
                          height: ResponsiveSize.height(40),
                          child: Center(
                            child: Text(
                              cats.toList()[index].asString,
                              style: TextStyle(
                                fontSize: 12.height,
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: cats.length),
                ),
              ),
              GestureDetector(
                onTap: () {
                  var tempCur = category;
                  Navigator.pop(context, tempCur);
                },
                child: Container(
                  width: ResponsiveSize.width(200),
                  height: ResponsiveSize.height(50),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(ResponsiveSize.height(10)),
                    ),
                  ),
                  child: Center(
                      child: Text(
                    'Выбрать',
                    style: TextStyle(color: Theme.of(context).backgroundColor),
                  )),
                ),
              ),
            ],
          );
        });
  }
}
