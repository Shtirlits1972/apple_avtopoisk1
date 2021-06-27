import 'package:flutter/material.dart';

class images {
  String image_id = '';
  String ext = '';
  String path = '';

   images({@required this.image_id, @required this.ext, @required this.path});

@override
String toString() {

    return 'image_id: $image_id, ext: $ext, path: $path ';
  }

}
