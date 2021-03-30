import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:integral_admin/UI/dish_edit_page/widgets/button_bar.dart';
import 'package:integral_admin/UI/dish_edit_page/widgets/delete_alert.dart';
import 'package:integral_admin/blocs/dish_edit_bloc/dishedit_bloc.dart';

import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/entities/gallery_image_controller.dart';
import 'package:integral_admin/models/dish_edit_modes.dart';
import 'package:integral_admin/resources/app_strings.dart';
import 'package:integral_admin/services/responsive_size.dart';
import 'package:integral_admin/UI/widgets/tag_controller/tag_controller.dart';

import 'widgets/picture_and_price.dart';

class DishEditScreen<Mode extends DishEditMode> extends StatefulWidget {
  final Dish? _dish;

  DishEditScreen._(this._dish, {Key? key}) : super(key: key);

  factory DishEditScreen.edit(Dish dish) {
    return DishEditScreen<Mode>._(dish);
  }

  factory DishEditScreen.create() {
    return DishEditScreen<Mode>._(null);
  }

  @override
  _DishEditScreenState<Mode> createState() => _DishEditScreenState<Mode>();
}

class _DishEditScreenState<Mode extends DishEditMode>
    extends State<DishEditScreen<Mode>> {
  final TextEditingController price = TextEditingController();

  final TextEditingController descpription = TextEditingController();

  final TextEditingController name = TextEditingController();

  final GalleryImageController imageController = GalleryImageController();

  late final DisheditBloc? _bloc;

  late Set<Category> cats;

  @override
  void initState() {
    super.initState();

    if (Mode == DishChange) {
      _setValues(widget._dish!);
    } else {
      cats = Set<Category>();
    }
    _bloc = DisheditBloc<Mode>(widget._dish);
  }

  String? url;

  Uint8List? image;

  bool visible = true;

  void _setValues(Dish dish) {
    price.text = dish.price.toString();
    descpription.text = dish.description;
    name.text = dish.name;
    cats = Set.from(dish.categoriesAsCat);
    url = dish.url;
    visible = dish.visible;
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      iconTheme: Theme.of(context).iconTheme,
      backgroundColor: Theme.of(context).backgroundColor,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context, false);
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocConsumer(
          bloc: _bloc,
          listener: (context, dynamic state) {
            if (state is DishEditMainState) {
              if (Mode == DishCreate) {
                // Navigator.pop(context);
              }
              if (Mode == DishChange) {
                _setValues(state.dish!);
              }
            }
            if (state is DishEditingCompleteState) {
              if (state.successful) {
                Navigator.of(context).pop(true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.caption),
                  ),
                );
              }
            }
          },
          builder: (context, dynamic state) {
            if (state is DishEditLoadingState) {
              return Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Пожалуйста, подождите'),
                ],
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Center(
                        child: Container(
                          width: ResponsiveSize.width(300),
                          child: TextField(
                            controller: name,
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.height),
                      PictureAndPrice(
                        imageController: imageController,
                        priceController: price,
                        picUrl: url,
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
                      TextField(
                        style: Theme.of(context).accentTextTheme.bodyText1,
                        maxLines: 10,
                        minLines: 1,
                        controller: descpription,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text('Блюдо видно:'),
                          Checkbox(
                            value: visible,
                            onChanged: (value) => setState(
                              () {
                                visible = value ?? true;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.height),
                      TagController(
                        categories: cats,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomButtonBar(
        trashVisibility: Mode == DishChange,
        leftFieldCallback: () {
          DeleteAlert.showDeleteDialog(context);
        },
        rightFieldCallback: () => _bloc!.add(
          DishEditingDone(
            dish: Dish(
              visible: visible,
              id: widget._dish?.id ?? 'undefined',
              categories: cats.isEmpty ? {Category.all} : cats,
              description: descpription.text,
              name: name.text,
              price: int.tryParse(price.text) ?? 0,
              url: (imageController.image != null
                  ? imageController.base64
                  : (Mode == DishCreate
                      ? AppDefaultUrls.DEFAULT_DISH_URL
                      : widget._dish!.url)),
            ),
          ),
        ),
      ),
    );
  }
}
