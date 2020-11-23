import 'package:flutter/material.dart';
import 'package:integral_admin/services/responsive_size.dart';

class OrderObservePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: ResponsiveSize.height(40),
              width: ResponsiveSize.width(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).accentColor,
              ),
              child: Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "ЗАКАЗ #11111111",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              "Цена 1500р",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              "Дата 21.01.2020",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              "Статус НЕИЗВЕСТНО",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: Column(
          children: [
            Center(
              child: FlatButton(
                onPressed: () {},
                child: Text("Заказ выполнен"),
              ),
            ),
            Center(
              child: FlatButton(
                onPressed: () {},
                child: Text("Отменить заказ"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
