import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:integral_admin/services/images.dart';
import 'package:integral_admin/services/responsive_size.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PictureAndPrice extends StatefulWidget {
  final String picUrl;
  final int dishPrice;
  final void Function(Uint8List) picChanged;

  final TextEditingController priceController;
  final Uint8List img;

  PictureAndPrice({
    @required this.picUrl,
    @required this.dishPrice,
    @required this.picChanged,
    @required this.priceController,
    @required this.img,
  });

  @override
  _PictureAndPriceState createState() => _PictureAndPriceState();
}

class _PictureAndPriceState extends State<PictureAndPrice> {
  Uint8List img;
  @override
  void initState() {
    super.initState();
    img = widget.img;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
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
                      ? AssetImage('asset/no_image.png')
                      : CachedNetworkImageProvider(widget.picUrl))
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
