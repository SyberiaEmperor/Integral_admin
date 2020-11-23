import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:integral_admin/UI/dish_screen/widgets/tag_field.dart';
import 'package:integral_admin/models/dish.dart';
import 'package:integral_admin/services/responsive_size.dart';

class DishEditScreen extends StatelessWidget {
  final Dish _dish;

  final TextEditingController price = TextEditingController();
  final TextEditingController descpription = TextEditingController();

  bool first = true;

  DishEditScreen(this._dish, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (first) {
      price.text = _dish.price.toString();
      descpription.text = _dish.description;

      first = !first;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).canvasColor,
        actions: [
          RawMaterialButton(
            onPressed: null,
            child: Icon(Icons.shopping_basket),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Center(
                    child: Text(
                      _dish.name,
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                  SizedBox(height: 20.height),
                  _PictureAndPrice(
                    priceController: price,
                    dishPrice: _dish.price,
                    picUrl: _dish.url,
                  ),
                  SizedBox(height: 20.height),
                  Text(
                    "Описание:\n\n",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 20.height),
                  Container(
                    child: TextField(
                      maxLines: 10,
                      minLines: 1,
                      controller: descpription,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.height),
                  Wrap(
                    children: _dish.categories.map((e) => TagField(e)).toList(),
                  ),
                ],
              ),
            ),
            _ButtonBar(
              leftFieldCallback: () => print("left"),
              rightFieldCallback: () => print("Right"),
            ),
          ],
        ),
      ),
    );
  }
}

class _PictureAndPrice extends StatelessWidget {
  final String picUrl;
  final int dishPrice;

  final TextEditingController priceController;

  const _PictureAndPrice({
    @required this.picUrl,
    @required this.dishPrice,
    this.priceController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: double.infinity,
        height: 281.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: CachedNetworkImageProvider(picUrl),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey[100], width: 0),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Цена", style: TextStyle(fontSize: 15)),
            Container(
              height: 75,
              width: 200,
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  suffix: Text("Руб."),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

class _ButtonBar extends StatelessWidget {
  final void Function() leftFieldCallback;
  final void Function() rightFieldCallback;

  const _ButtonBar(
      {@required this.leftFieldCallback, @required this.rightFieldCallback});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RawMaterialButton(
          onPressed: leftFieldCallback,
          child: Text("Левая хуйня"),
        ),
        RawMaterialButton(
          onPressed: rightFieldCallback,
          child: Text("Правая хуйня"),
          fillColor: Colors.blue,
        ),
      ],
    );
  }
}
