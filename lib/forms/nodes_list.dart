import 'package:apple_avtopoisk1/constants.dart';
import 'package:apple_avtopoisk1/dataDetailsInNode.dart';
import 'package:apple_avtopoisk1/dataNodeList.dart';
import 'package:apple_avtopoisk1/details_in_node_crud.dart';
import 'package:apple_avtopoisk1/dto/details_in_node.dart';
import 'package:apple_avtopoisk1/dto/node.dart';
import 'package:apple_avtopoisk1/forms/details_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dataOEM.dart';

class NodesListForm extends StatefulWidget {
  const NodesListForm({Key key}) : super(key: key);

  @override
  _NodesListFormState createState() => _NodesListFormState();
}

class _NodesListFormState extends State<NodesListForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('список узлов'),
        centerTitle: true,
      ),
      body: Container(
        child: Consumer(
            builder: (BuildContext context, DataNode node, Widget child) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 600,
            width: double.infinity,
            child: getNodeList(node.getListNode),
          );
        }),
      ),
    );
  }

  Widget getNodeList(List<Node> list) {
    int a = 0;
    if (list == null || list.length == 0) {
      return Center(
          child: Text(
        'Нет данных',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ));
    } else {
      ListView listWiev = ListView.separated(
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 1,
          color: Colors.white,
          thickness: 1,
        ),
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  list[index].name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                width: double.infinity,
              ),
              Container(
                width: double.infinity,
                child: InkWell(
                  onTap: () async {
                    await LoadDetailsInNode(list[index].node_id);
                    //  преход в узел
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailsForm()),
                    );
                  },
                  child: Image.network('http://' +
                      hostNissan +
                      '/image/' +
                      list[index].image_id),
                ),
              ),
            ],
          );
        },
      );

      return listWiev;
    }
  }

  Future LoadDetailsInNode(String node_id) async {
    String vehicle_id =
        Provider.of<DataOEM>(context, listen: false).getVehicleId;

    DetailsInNodeCrud crud = DetailsInNodeCrud();
    DetailsInNode detailsInNode =
        await crud.GetNodesList(vehicle_id, node_id, '20');
    int h = 0;
    setState(() {
      int y = 0;
      Provider.of<DataDetailsInNode>(context, listen: false)
          .setDetailsInNode(detailsInNode);
    });
  }
}
