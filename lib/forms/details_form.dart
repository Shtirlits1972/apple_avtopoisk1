import 'package:apple_avtopoisk1/constants.dart';
import 'package:apple_avtopoisk1/dataDetailsInNode.dart';
import 'package:apple_avtopoisk1/details_in_node_crud.dart';
import 'package:apple_avtopoisk1/dto/detail.dart';
import 'package:apple_avtopoisk1/dto/details_in_node.dart';
import 'package:apple_avtopoisk1/dto/image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsForm extends StatefulWidget {
  DetailsForm({Key key}) : super(key: key);

  @override
  _DetailsFormState createState() => _DetailsFormState();
}

class _DetailsFormState extends State<DetailsForm> {
  @override
  Widget build(BuildContext context) {
    DetailsInNode detailsInNode =
        Provider.of<DataDetailsInNode>(context, listen: false).getDetailsInNode;
    int as = 0;
    return Scaffold(
      appBar: AppBar(
          title: Text(detailsInNode.name + ' ' + detailsInNode.number),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
                        SizedBox(height: 10),
          getImages(detailsInNode.imagesList),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsetsDirectional.only(start: 10),
                  child: Text(
                    '№ Детали',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsetsDirectional.only(start: 10),
                  child: Text(
                    'Название',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),
          getListDetails(detailsInNode.parts),
        ]),
      ),
    );
  }

  Widget getImages(List<ImagePart> list) {
    try {
      Column col = Column(children: []);

      for (int i = 0; i < list.length; i++) {
        Container cont = Container(
          width: double.infinity,
          child: Image.network(
              'http://' + hostNissan + '/image/' + list[i].image_id),
        );
        col.children.add(cont);
      }

      return col;
    } catch (error) {
      return null;
    }
  }

  Widget getListDetails(List<Detail> list) {
    try {
      if (list == null || list.length == 0) {
        return Center(
            child: Text(
          'Нет данных',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ));
      } else {
        Column col = Column(
          children: [],
        );

        for (int i = 0; i < list.length; i++) {
          Row row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  list[i].number,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  list[i].name,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          );

          col.children.add(row);
        }
        return col;
      }
    } catch (error) {
      return Center(
        child: Text(
          'Нет данных',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      );
    }
  }
}
