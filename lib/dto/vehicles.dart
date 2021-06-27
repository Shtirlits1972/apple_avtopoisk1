import 'package:flutter/material.dart';

class Vehicles {
  String vehicle_id = '';
  String model_name = '';
  String D1 = '';
  String D2 = '';
  String D3 = '';
  String D4 = '';
  String D5 = '';
  String D6 = '';
  String D7 = '';
  String D8 = '';

  String V1 = '';
  String V2 = '';
  String V3 = '';
  String V4 = '';
  String V5 = '';
  String V6 = '';
  String V7 = '';
  String V8 = '';

  String catalog = '';
  String model_num = '';
  String from_date = '';
  String upto_date = '';

  Map<String, String> toMap() {
    final Map<String, String> map = {
      'vehicle_id': vehicle_id,
      'model_name': model_name,
      'D1': D1,
      'D2': D2,
      'D3': D3,
      'D4': D4,
      'D5': D5,
      'D6': D6,
      'D7': D7,
      'D8': D8,
      'V1': V1,
      'V2': V2,
      'V3': V3,
      'V4': V4,
      'V5': V5,
      'V6': V6,
      'V7': V7,
      'V8': V8,
      'catalog': catalog,
      'model_num': model_num,
      'from_date': from_date,
      'upto_date': upto_date
    };

    return map;
  }

  @override
  String toString() {
    return '{vehicle_id: $vehicle_id  model_name: $model_name, catalog: $catalog, model_num: $model_num,' +
        ' from_date: $from_date, upto_date: $upto_date, ' +
        ' D1: $D1, D2: $D2, D3: $D3, D4: $D4, D5: $D5, D6: $D6, D7: $D7, D8: $D8,' +
        'V1: $V1, V2: $V2, V3: $V3, V4: $V4, V5: $V5, V6: $V6, V7: $V7, V8: $V8    }';
  }

  Vehicles(
      {@required this.vehicle_id,
      @required this.model_name,
      @required this.D1,
      @required this.D2,
      @required this.D3,
      @required this.D4,
      @required this.D5,
      @required this.D6,
      @required this.D7,
      @required this.D8,
      @required this.V1,
      @required this.V2,
      @required this.V3,
      @required this.V4,
      @required this.V5,
      @required this.V6,
      @required this.V7,
      @required this.V8,
      @required this.catalog,
      @required this.model_num,
      @required this.from_date,
      @required this.upto_date});
}
