import 'package:apple_avtopoisk1/dto/detail.dart';
import 'package:apple_avtopoisk1/dto/details_in_node.dart';
import 'package:apple_avtopoisk1/dto/image.dart';
import 'package:apple_avtopoisk1/dto/images.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'constants.dart';

class DetailsInNodeCrud {
  Future<DetailsInNode> GetNodesList(
      String vehicle_id, String node_id, String brandId) async {
    String path =
        '/vehicle/$vehicle_id/sgroups/$node_id?vehicle_id=$vehicle_id&node_id=$node_id&brand_id=$brandId';
    try {

      String url = 'http://' + hostNissan + path;
            var request =
          http.Request('GET', Uri.parse(url));
      http.StreamedResponse response = await request.send();
      // var response = await http.get(
      //   Uri.http(hostNissan, path),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //     'Accept-Language': 'EN'
      //   },
      // );

      if (response.statusCode == 200) {
        //var detail = json.decode(response.body) as dynamic;
        String data = await response.stream.bytesToString();
        var detail = (json.decode(data) as dynamic);

        String node_id = detail['node_id'];
        String name = detail['name'];
        String number = detail['number'];

        var partsRaw = detail['parts'] as List<dynamic>;
        // ignore: deprecated_member_use
        List<Detail> parts = List<Detail>();

        for (int i = 0; i < partsRaw.length; i++) {
          Detail detail = Detail(
              name: partsRaw[i]['name'],
              number: partsRaw[i]['number'],
              PARTCODE: partsRaw[i]['PARTCODE']);
          parts.add(detail);
        }

        var imagesListRaw = detail['images'];
        // ignore: deprecated_member_use
        List<ImagePart> imagesLst = List<ImagePart>();
        for (int i = 0; i < imagesListRaw.length; i++) {
          ImagePart img = ImagePart(
              image_id: imagesListRaw[i]['image_id'],
              ext: imagesListRaw[i]['ext'],
              path: imagesListRaw[i]['path']);

          imagesLst.add(img);
        }

        return DetailsInNode(
            node_id: node_id,
            name: name,
            number: number,
            parts: parts,
            imagesList: imagesLst);
      } else {
        print('statusCode: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('error: $error');
      return null;
    }
    return null;
  }
}
