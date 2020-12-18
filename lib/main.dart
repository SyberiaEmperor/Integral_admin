import 'package:flutter/material.dart';
import 'package:integral_admin/services/responsive_size.dart';

import 'UI/main_page/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        ResponsiveSize.init(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width);
        return Theme(
          isMaterialAppTheme: true,
          data: ThemeData(
            primaryColor: Color(0xffF5F7FA),
            backgroundColor: Color(0xffFFFFFF),
            accentColor: Color(0xddFA7022),
            cursorColor: Color(0xff435D6B),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontFamily: 'Poppins',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                fontSize: ResponsiveSize.height(35.0),
              ),
            ),
            primaryTextTheme: TextTheme(
              bodyText1: TextStyle(
                fontFamily: 'Poppins',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                fontSize: ResponsiveSize.height(18.0),
              ),
            ),
            accentTextTheme: TextTheme(
              bodyText1: TextStyle(
                fontFamily: 'Poppins',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
                fontSize: ResponsiveSize.height(13.0),
                color: Color(0xff667C8A),
              ),
              bodyText2: TextStyle(
                fontFamily: 'Poppins',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                fontSize: ResponsiveSize.height(13.0),
                color: Colors.black,
              ),
            ),
          ),
          child: child,
        );
      },
      title: 'Integral',
      theme: ThemeData(),
      home: Builder(builder: (context) {
        return MainPage();
      }),
    );
  }
}
