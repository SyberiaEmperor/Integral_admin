import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class Images {
  static Future<Uint8List> getImage() async {
    ImagePicker imagePicker = ImagePicker();
    // ignore: avoid_init_to_null
    ImageSource source = null;
    source = ImageSource.gallery;
    try {
      Uint8List img =
          await (await imagePicker.getImage(source: source, imageQuality: 20))
              ?.readAsBytes();
      return img;
    } catch (PlatformException) {
      print("Image pick error");
    }
  }
}
