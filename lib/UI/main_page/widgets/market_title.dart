import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integral_admin/services/responsive_size.dart';

class MarketTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      margin: EdgeInsets.only(
          left: ResponsiveSize.width(15), bottom: ResponsiveSize.height(35)),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: ResponsiveSize.height(25),
            backgroundImage: AssetImage('assets/integral.jpg'),
          ),
          SizedBox(width: ResponsiveSize.width(7)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: ResponsiveSize.width(189),
                height: ResponsiveSize.height(20),
                child: Text(
                  "Общественное питание",
                  style: Theme.of(context).accentTextTheme.bodyText1,
                ),
              ),
              SizedBox(
                height: ResponsiveSize.height(5),
              ),
              Container(
                width: ResponsiveSize.width(112),
                height: ResponsiveSize.height(20),
                child: Text(
                  "Интеграл",
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
