import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:integral_admin/UI/cart_screen/cart_screen.dart';
import 'package:integral_admin/UI/widgets/tag_controller/tag_controller.dart';

import 'package:integral_admin/models/cart.dart';
import 'package:integral_admin/models/dish.dart';
import 'package:integral_admin/services/images.dart';
import 'package:integral_admin/services/responsive_size.dart';

class DishCreateScreen extends StatefulWidget {
  DishCreateScreen({Key key}) : super(key: key);

  @override
  _DishCreateScreenState createState() => _DishCreateScreenState();
}

class _DishCreateScreenState extends State<DishCreateScreen> {
  final TextEditingController price = TextEditingController();

  final TextEditingController descpription = TextEditingController();

  final TextEditingController name = TextEditingController();

  Uint8List image = null;

  Set<Category> cats = {};

  bool first = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).backgroundColor,
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
                  //color: Theme.of(context).accentColor,
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black,
                )),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartScreen(Cart.test())));
              },
              child: Container(
                  height: ResponsiveSize.height(40),
                  width: ResponsiveSize.width(35),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    //color: Theme.of(context).accentColor,
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 20,
                    color: Colors.black,
                  )),
            ),
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
                    child: Container(
                      width: 300,
                      child: TextField(
                        controller: name,
                        decoration: InputDecoration(
                          hintText: "Название",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.height),
                  _PictureAndPrice(
                    priceController: price,
                    img: image,
                  ),
                  SizedBox(height: 20.height),
                  Text(
                    "Описание:\n\n",
                    style: Theme.of(context).primaryTextTheme.bodyText1,
                  ),
                  //SizedBox(height: 20.height),
                  Container(
                    child: TextField(
                      style: Theme.of(context).accentTextTheme.bodyText1,
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
                  TagController(
                    categories: cats,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _ButtonBar(
        leftFieldCallback: () => print("left"),
        rightFieldCallback: () => print("Right"),
      ),
    );
  }
}

class _PictureAndPrice extends StatefulWidget {
  final TextEditingController priceController;
  Uint8List img;

  _PictureAndPrice({
    this.priceController,
    this.img,
  });

  @override
  __PictureAndPriceState createState() => __PictureAndPriceState();
}

class __PictureAndPriceState extends State<_PictureAndPrice> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () async {
          widget.img = await Images.getImage();
          setState(() {});
        },
        child: Container(
          width: double.infinity,
          height: 281.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: widget.img == null
                  ? AssetImage('assets/no_image.jpg')
                  : MemoryImage(widget.img),
            ),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color: Colors.blueGrey[100], width: 0),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Цена:", style: Theme.of(context).primaryTextTheme.bodyText1),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              height: 75,
              width: 200,
              child: TextField(
                style: Theme.of(context).primaryTextTheme.bodyText1,
                controller: widget.priceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  suffix: Text("Руб.",
                      style: Theme.of(context).primaryTextTheme.bodyText1),
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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 200,
          child: GestureDetector(
            onTap: null,
            child: Container(
                height: ResponsiveSize.height(70),
                width: ResponsiveSize.width(60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: Theme.of(context).accentColor,
                ),
                child: Icon(
                  Icons.check,
                  size: 20,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }
}