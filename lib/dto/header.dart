import 'package:flutter/material.dart';

class Header {
  String code;
  String title;

  Header({@required this.code, @required this.title});

    @override
   String toString()
  {
     return '{ code: $code, title: $title}';
  }

  factory Header.fromJson(Map<String, dynamic> json) {
    return Header(
      code: json['code'],
      title: json['title'],
    );
  }
}
