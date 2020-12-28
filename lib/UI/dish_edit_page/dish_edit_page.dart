import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:integral_admin/UI/dish_edit_page/widgets/button_bar.dart';
import 'package:integral_admin/blocs/dish_edit_bloc/dishedit_bloc.dart';

import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/services/images.dart';
import 'package:integral_admin/services/responsive_size.dart';
import 'package:integral_admin/UI/widgets/tag_controller/tag_controller.dart';

import 'widgets/picture_and_price.dart';

class DishEditScreen extends StatelessWidget {
  final Dish _dish;
  DisheditBloc bloc;

  final TextEditingController price = TextEditingController();
  final TextEditingController descpription = TextEditingController();
  final TextEditingController name = TextEditingController();
  Set<Category> cats;

  Uint8List image;

  DishEditScreen(this._dish, {Key key}) : super(key: key) {
    price.text = _dish.price.toString();
    descpription.text = _dish.description;
    name.text = _dish.name;
    cats = Set.from(_dish.categoriesSet);
    bloc = DisheditBloc(_dish);
  }
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
                  color: Theme.of(context).accentColor,
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: Colors.white,
                )),
          ),
        ),
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
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.height),
                  PictureAndPrice(
                    priceController: price,
                    dishPrice: _dish.price,
                    picUrl: _dish.url,
                    img: image,
                    picChanged: (newPic) {
                      image = newPic;
                    },
                  ),
                  SizedBox(height: 20.height),
                  Text(
                    'Описание:\n\n',
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
      bottomNavigationBar: BottomButtonBar(
        leftFieldCallback: () => print('left'),
        rightFieldCallback: () => print('Right'),
      ),
    );
  }
}
