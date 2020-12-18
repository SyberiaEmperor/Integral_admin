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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Интеграл',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: ResponsiveSize.height(5),
                ),
                Text(
                  'Общественное питание',
                  style: Theme.of(context).accentTextTheme.bodyText1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
