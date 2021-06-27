import 'package:apple_avtopoisk1/dto/vehicles_object.dart';
import 'package:flutter/material.dart';

class DataVehiclesObject with ChangeNotifier {
  VehiclesObject vehiclesObject = null;

  VehiclesObject get getVehiclesObject => vehiclesObject;

  void setVehiclesObject(VehiclesObject vehiclesObjectInput) {
    vehiclesObject = vehiclesObjectInput;
  }
}
