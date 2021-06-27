import 'package:flutter/material.dart';

class DataOEM with ChangeNotifier {
  String oem = '';
  String vehicle_id = '';

  String get getOEM => oem;
  String get getVehicleId => vehicle_id;

  void setOemValue(String oemInput) {
    oem = oemInput;
  }

  void setVehicleId(String vehicleIdInput) {
    vehicle_id = vehicleIdInput;
  }
}
