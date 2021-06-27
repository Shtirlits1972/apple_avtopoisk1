import 'package:apple_avtopoisk1/dto/ExpandedTop.dart';
import 'package:flutter/material.dart';

class DataExpandedTop with ChangeNotifier {
  ExpandedTop vehicles = null;

  ExpandedTop get getVehiclesExpanded => vehicles;

  void setExpandedTop(ExpandedTop vehiclesExpandedInput) {
    vehicles = vehiclesExpandedInput;
  }
}