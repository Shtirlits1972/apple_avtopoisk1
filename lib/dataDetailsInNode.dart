import 'package:apple_avtopoisk1/dto/details_in_node.dart';
import 'package:flutter/material.dart';

class DataDetailsInNode with ChangeNotifier {
  DetailsInNode detailsInNode = null;


  DetailsInNode get getDetailsInNode => detailsInNode;

  void setDetailsInNode(DetailsInNode detailsInNodeInput) {
    detailsInNode = detailsInNodeInput;
  }
}