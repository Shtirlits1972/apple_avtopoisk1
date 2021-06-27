import 'package:apple_avtopoisk1/constants.dart';
import 'package:apple_avtopoisk1/dto/ExpandedTop.dart';
import 'package:apple_avtopoisk1/dto/vehicle_expanded.dart';
import 'package:apple_avtopoisk1/dto/vehicles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dto/header.dart';
import 'dto/vehicles_object.dart';

class VehiclesCrud {
  Future<ExpandedTop> getExpanded(String oem, int page, int page_size) async {

    List<Header> headerTop = List<Header>();
    List<VehicleExpanded> expanded = List<VehicleExpanded>();

    ExpandedTop expandedTop = ExpandedTop(headerTop, expanded);
    //   список моделей автомобилей
    Set<String> titles = Set<String>();
    //  получаем "первичный" объект с автомобилями и заголовками
    VehiclesObject vehiclesObject =
        await GetVehiclesObject(oem, page, page_size);
    // заполняем масив с названиями моделей
    for (int i = 0; i < vehiclesObject.vehicles.length; i++) {
      if (!titles.contains(vehiclesObject.vehicles[i].model_name)) {
        titles.add(vehiclesObject.vehicles[i].model_name);
      }
    }

    expandedTop.headers = vehiclesObject.headers;
    for (String title in titles) {

      VehicleExpanded vehicleExpanded = VehicleExpanded();
      vehicleExpanded.header = title;

      for (int i = 0; i < vehiclesObject.vehicles.length; i++) {
        if (vehiclesObject.vehicles[i].model_name == title) {
          vehicleExpanded.vehicles.add(vehiclesObject.vehicles[i]);
        }
      }

      expandedTop.expanded.add(vehicleExpanded);
    }

    return expandedTop;
  }

  Future<VehiclesObject> GetVehiclesObject(
      String oem, int page, int page_size) async {
    VehiclesObject vehiclesObject = VehiclesObject();

    try {
      var response = await http.post(
        Uri.http(hostNissan, '/appability/vehicles'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, Object>{
          'brand_id': '20',
          'oem': oem,
          'page': page,
          'page_size': page_size
        }),
        //  encoding: Encoding.getByName('UTF-8')
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as dynamic;

        List<Header> headerList = List<Header>();
        List<dynamic> headerRaw = data['header'];

        for (int i = 0; i < headerRaw.length; i++) {
          Header header =
              Header(code: headerRaw[i]['code'], title: headerRaw[i]['title']);
          headerList.add(header);
        }
        vehiclesObject.headers = headerList;

        List<dynamic> itemRaw = data['items'];
        List<Vehicles> vehiclesList = List<Vehicles>();

        for (int i = 0; i < itemRaw.length; i++) {
          Vehicles vehicle = Vehicles(
            vehicle_id: itemRaw[i]['vehicle_id'],
            model_name: itemRaw[i]['model_name'],
            D1: itemRaw[i]['d1'],
            D2: itemRaw[i]['d2'],
            D3: itemRaw[i]['d3'],
            D4: itemRaw[i]['d4'],
            D5: itemRaw[i]['d5'],
            D6: itemRaw[i]['d6'],
            D7: itemRaw[i]['d7'],
            D8: itemRaw[i]['d8'],
            V1: itemRaw[i]['v1'],
            V2: itemRaw[i]['v2'],
            V3: itemRaw[i]['v3'],
            V4: itemRaw[i]['v4'],
            V5: itemRaw[i]['v5'],
            V6: itemRaw[i]['v6'],
            V7: itemRaw[i]['v7'],
            V8: itemRaw[i]['v8'],
            catalog: itemRaw[i]['catalog'],
            model_num: itemRaw[i]['model_num'],
            from_date: itemRaw[i]['from_date'],
            upto_date: itemRaw[i]['upto_date'],
          );
          vehiclesList.add(vehicle);
        }

        vehiclesObject.vehicles = vehiclesList;
        vehiclesObject.cnt_items = int.parse(data['cnt_items'].toString());
        vehiclesObject.page = int.parse(data['page'].toString());

        int y = 0;
        return vehiclesObject;
      } else {
        print('Errror. ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('error: $error');
      return null;
    }
  }
}
