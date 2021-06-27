import 'package:apple_avtopoisk1/dto/header.dart';
import 'package:flutter/material.dart';
import 'package:apple_avtopoisk1/dto/vehicles.dart';

class VehiclesObject {
  List<Header> headers = List<Header>();
  List<Vehicles> vehicles;

  int cnt_items = 0;
  int page = 1;

  @override
  String toString() {
    return 'headers: ${headers.toString()}, vehicles: ${vehicles.toString()}, cnt_items: ${cnt_items.toString()}, page: ${page.toString()} ';
  }

  VehiclesObject(
      {@required this.headers,
      @required this.vehicles,
      @required this.cnt_items,
      @required this.page});
}
