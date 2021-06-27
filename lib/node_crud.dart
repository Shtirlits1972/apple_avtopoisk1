import 'package:apple_avtopoisk1/dto/node.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'constants.dart';

class NodeCrud {
  Future<List<Node>> GetNodesList(String vehicle_id, String oem) async {
    List<Node> list = List<Node>();

    try {
      var response = await http.post(
        Uri.http(hostNissan, '/appability/nodes'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'brand_id': '20',
          'oem': oem,
          'vehicle_id': vehicle_id,
        }),
      );
      if (response.statusCode == 200) {
        var nodeListRaw = json.decode(response.body) as List<dynamic>;

        for (int i = 0; i < nodeListRaw.length; i++) {
          Node node = Node(
              node_id: nodeListRaw[i]["node_id"],
              name: nodeListRaw[i]["name"],
              image_id: nodeListRaw[i]["image_id"]);
 
          list.add(node);
        }
      } else {
        print('statusCode: ${response.statusCode}');
      }
    } catch (error) {
      print('error: $error');
      return null;
    }

    return list;
  }
}
