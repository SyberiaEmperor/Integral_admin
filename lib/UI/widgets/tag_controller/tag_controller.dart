import 'dart:async';

import 'package:flutter/material.dart';
import 'package:integral_admin/UI/widgets/tag_controller/widgets/add_tag_button.dart';
import 'package:integral_admin/UI/widgets/tag_controller/widgets/tag_field.dart';
import 'package:integral_admin/UI/widgets/tag_controller/widgets/tag_wheel.dart';
import 'package:integral_admin/entities/dish.dart';

class TagController extends StatefulWidget {
  final Set<Category>? categories;

  TagController({required this.categories});

  void removeCategory(Category e) {
    categories!.remove(e);
  }

  void addCategory(Category e) {
    categories!.add(e);
  }

  @override
  _TagControllerState createState() => _TagControllerState();
}

class _TagControllerState extends State<TagController> {
  late List<Widget> tags;
  late final Widget addButton;

  void fillTags() {
    if (widget.categories != null) {
      tags = [
        ...widget.categories!
            .map(
              (category) => TagField(
                category,
                () {
                  widget.removeCategory(category);
                  setState(() {});
                },
              ),
            )
            .toList(),
        addButton
      ];
    }
  }

  @override
  void initState() {
    super.initState();
    addButton = AddTagButton(
      addTag: () async {
        Set<Category> diff =
            CategoriesExt.excludeAll.toSet().difference(widget.categories!);
        if (diff.isNotEmpty) {
          //Теперь не выезжает лист. Если нужно будет другое поведение - заменить
          Category? new_tag = await (Modal.mainBottomSheet(context, diff)
              as FutureOr<Category?>);
          if (new_tag != null) {
            widget.addCategory(new_tag);
            setState(() {});
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    fillTags();
    return Wrap(
      children: tags as List<Widget>,
    );
  }
}
