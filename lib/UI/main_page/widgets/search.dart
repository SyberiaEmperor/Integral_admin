import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integral_admin/services/responsive_size.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: ResponsiveSize.width(15), left: ResponsiveSize.width(15)),
      width: ResponsiveSize.width(345),
      height: ResponsiveSize.height(45),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 1, top: 3),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ResponsiveSize.height(5))),
          enabledBorder: InputBorder.none,
          prefixIcon: Container(
            margin: EdgeInsets.only(
                right: ResponsiveSize.width(15),
                left: ResponsiveSize.width(11)),
            width: ResponsiveSize.width(20),
            height: ResponsiveSize.height(20),
            child: Icon(
              Icons.search,
              color: Theme.of(context).cursorColor,
            ),
          ),
          hintText: 'Поиск',
          hintStyle: Theme.of(context).accentTextTheme.bodyText1,
          fillColor: Theme.of(context).primaryColor,
          filled: true,
        ),
      ),
    );
  }
}
