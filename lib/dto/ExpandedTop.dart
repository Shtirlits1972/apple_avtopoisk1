import 'package:apple_avtopoisk1/dto/header.dart';
import 'package:apple_avtopoisk1/dto/vehicle_expanded.dart';
import 'package:flutter/material.dart';

class ExpandedTop {
  List<Header> headers = List<Header>();
  List<VehicleExpanded> expanded = List<VehicleExpanded>();

  ExpandedTop(this.headers, this.expanded);

  Column getTileChildren() {
    Row row1 = Row(
      children: [
        Text('one'),
        Text('two'),
        Text('three'),
      ],
    );

    Row row2 = Row(
      children: [
        Text('one'),
        Text('two'),
        Text('three'),
      ],
    );

    Row row3 = Row(
      children: [
        Text('one'),
        Text('two'),
        Text('three'),
      ],
    );



    // for (int i = 0; i < headers.length; i++) {
    //   Text text = new Text(headers[i].title);

    //   row.children.add(text);
    // }
    return Column(children: [row1, row2, row3],);
  }
}
