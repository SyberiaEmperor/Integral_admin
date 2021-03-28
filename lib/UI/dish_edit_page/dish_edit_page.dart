import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:integral_admin/UI/dish_edit_page/widgets/button_bar.dart';
import 'package:integral_admin/blocs/dish_edit_bloc/dishedit_bloc.dart';

import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/entities/gallery_image_controller.dart';
import 'package:integral_admin/models/dish_edit_modes.dart';
import 'package:integral_admin/services/responsive_size.dart';
import 'package:integral_admin/UI/widgets/tag_controller/tag_controller.dart';

import 'widgets/picture_and_price.dart';

class DishEditScreen<Mode extends DishEditMode> extends StatelessWidget {
  final Dish? _dish;
  late final DisheditBloc? _bloc;

  final TextEditingController price = TextEditingController();
  final TextEditingController descpription = TextEditingController();
  final TextEditingController name = TextEditingController();
  final GalleryImageController imageController = GalleryImageController();

  String? url;
  Set<Category>? cats;

  Uint8List? image;

  DishEditScreen._(this._dish, {Key? key}) : super(key: key) {
    print(Mode);
    print(Mode == DishChange);
    print(Mode == DishCreate);
    if (Mode == DishChange) {
      _setValues(_dish!);
    } else {
      cats = Set<Category>();
    }
    _bloc = DisheditBloc<Mode>(_dish);
  }

  factory DishEditScreen.edit(Dish dish) {
    return DishEditScreen<Mode>._(dish);
  }

  factory DishEditScreen.create() {
    return DishEditScreen<Mode>._(null);
  }

  void _setValues(Dish dish) {
    price.text = dish.price.toString();
    descpription.text = dish.description;
    name.text = dish.name;
    cats = Set.from(dish.categories);
    url = dish.url;
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
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //TODO: Check. It was Scaffold.of(context)
                    content: Text(state.caption),
                  ));
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
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.height as double?),
                        PictureAndPrice(
                          imageController: imageController,
                          priceController: price,
                          picUrl: url,
                          img: image,
                          picChanged: (newPic) {
                            image = newPic;
                          },
                        ),
                        SizedBox(height: 20.height as double?),
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
                        SizedBox(height: 20.height as double?),
                        TagController(
                          categories: cats,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
      bottomNavigationBar: BottomButtonBar(
        trashVisibility: Mode == DishChange,
        leftFieldCallback: () => print('left'),
        rightFieldCallback: () => _bloc!.add(DishEditingDone(
            dish: Dish(
          id: _dish?.id ?? 'undefined',
          categories: cats!,
          description: descpription.text,
          name: name.text,
          price: int.tryParse(price.text) ?? 0,
          url: (imageController.image != null
              ? imageController.base64
              : (Mode == DishCreate ? null : _dish!.url)),
        ))),
      ),
    );
  }
}
