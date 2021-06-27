import 'package:flutter/material.dart';

class Detail {
  String name = '';
  String number = '';
  String PARTCODE = '';

  @override
  toString() {
    return ' name: $name number: $number PARTCODE: $PARTCODE ';
  }

  Detail({@required this.name, @required this.number, @required this.PARTCODE});
}
