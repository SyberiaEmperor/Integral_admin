import 'package:flutter/material.dart';
import 'package:integral_admin/UI/order_observe_page/widgets/order_dish_tile_list.dart';
import 'package:integral_admin/UI/widgets/back_button.dart';
import 'package:integral_admin/entities/api/order_from_api.dart';
import 'package:integral_admin/services/responsive_size.dart';

class OrderObservePage extends StatelessWidget {
  final FullOrder order;
  final VoidCallback confirm;

  const OrderObservePage({Key? key, required this.order, required this.confirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle nameStyle =
        Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 25.height);
    TextStyle valueStyle =
        Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 25.height);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: NameValueMapOrderBox(
          name: 'Заказ:',
          value: '#${order.id}',
          nameStyle: nameStyle,
          valueStyle: valueStyle,
          alignment: MainAxisAlignment.start,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        leading: BackButtonLeading(),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NameValueMapOrderBox(
              name: 'Цена:',
              value: order.total.toStringAsFixed(0) + ' руб.',
              nameStyle: nameStyle,
              valueStyle: valueStyle,
            ),
            NameValueMapOrderBox(
              name: 'Дата:',
              value: order.creationDate,
              nameStyle: nameStyle,
              valueStyle: valueStyle,
            ),
            NameValueMapOrderBox(
              name: 'Статус:',
              value: order.orderQueue,
              nameStyle: nameStyle,
              valueStyle: valueStyle,
            ),
            Expanded(
              child: DishOrderList(
                dishes: order.dishes,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BottomButton(
            text: 'Подтвердить оплату',
            color: Colors.green,
            action: confirm,
          ),
          BottomButton(
            text: 'Отменить заказ',
            color: Colors.red,
            action: () => print('Отмена!'),
          ),
        ],
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final VoidCallback action;
  final String text;
  final Color color;

  const BottomButton({
    Key? key,
    required this.action,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.height),
      child: GestureDetector(
        onTap: action,
        child: Container(
          alignment: Alignment.center,
          height: 50.height,
          width: 150.width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.circular((10)),
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context)
                .accentTextTheme
                .bodyText2!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class NameValueMapOrderBox extends StatelessWidget {
  final String name;
  final String value;

  final TextStyle nameStyle;
  final TextStyle valueStyle;

  final MainAxisAlignment alignment;

  const NameValueMapOrderBox({
    Key? key,
    required this.name,
    required this.value,
    required this.nameStyle,
    required this.valueStyle,
    this.alignment = MainAxisAlignment.spaceBetween,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.width),
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          Text(name, style: nameStyle),
          SizedBox(
            width: 20.width,
          ),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}
