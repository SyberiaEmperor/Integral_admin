import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:integral_admin/UI/widgets/image_form/image_form.dart';
import 'package:integral_admin/entities/gallery_image_controller.dart';

class PictureAndPrice extends StatefulWidget {
  final String? picUrl;
  final void Function(Uint8List) picChanged;

  final TextEditingController priceController;
  final GalleryImageController imageController;
  final Uint8List? img;

  PictureAndPrice({
    required this.picUrl,
    required this.picChanged,
    required this.priceController,
    required this.img,
    required this.imageController,
  });

  @override
  _PictureAndPriceState createState() => _PictureAndPriceState();
}

class _PictureAndPriceState extends State<PictureAndPrice> {
  Uint8List? img;
  @override
  void initState() {
    super.initState();
    img = widget.img;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ImageForm(
        controller: widget.imageController,
        picUrl: widget.picUrl,
      ),
      /*GestureDetector(
        onTap: () async {
          img = await Images.getImage();
          setState(() {});
          widget.picChanged(img);
        },
        child: Container(
          width: double.infinity,
          height: ResponsiveSize.height(281),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: widget.img == null
                  ? (widget.picUrl == null
                      ? AssetImage('assets/no_image.jpg')
                      : CachedNetworkImageProvider(widget.picUrl))
                  : MemoryImage(widget.img),
            ),
          ),
        ),
      ),*/
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color: Colors.blueGrey[100]!, width: 0),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Цена:', style: Theme.of(context).primaryTextTheme.bodyText1),
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
                  suffix: Text('Руб.',
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
