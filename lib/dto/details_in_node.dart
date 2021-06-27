import 'package:apple_avtopoisk1/dto/detail.dart';
import 'package:apple_avtopoisk1/dto/image.dart';
import 'package:apple_avtopoisk1/dto/images.dart';
import 'package:apple_avtopoisk1/dto/images.dart';
import 'package:flutter/material.dart';

class DetailsInNode {
  String node_id = '';
  String name = '';
  String number = '';
  List<Detail> parts = List<Detail>();
  List<ImagePart> imagesList = List<ImagePart>();

  DetailsInNode(
      {@required this.node_id,
      @required this.name,
      @required this.number,
      @required this.parts,
      @required this.imagesList});

  @override
  String toString() {
    return 'node_id: $node_id, name: $name, number: $number';
  }
}
