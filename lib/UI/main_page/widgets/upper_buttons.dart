import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integral_admin/services/responsive_size.dart';

class UpperButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveSize.height(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: ResponsiveSize.width(15)),
            child: Container(
              height: ResponsiveSize.height(50),
              width: ResponsiveSize.width(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).accentColor,
              ),
              child: Icon(
                Icons.description,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: ResponsiveSize.width(15)),
            child: Container(
              height: ResponsiveSize.height(50),
              width: ResponsiveSize.width(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).accentColor,
              ),
              child: Icon(
                Icons.shopping_cart,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
