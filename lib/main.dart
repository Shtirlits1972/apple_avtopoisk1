import 'package:apple_avtopoisk1/dataDetailsInNode.dart';
import 'package:apple_avtopoisk1/dataVehicleExpanded.dart';
import 'package:apple_avtopoisk1/dto/ExpandedTop.dart';
import 'package:apple_avtopoisk1/dto/header.dart';
import 'package:apple_avtopoisk1/dto/vehicles.dart';
import 'package:apple_avtopoisk1/dto/vehicles_object.dart';
import 'package:apple_avtopoisk1/forms/nodes_list.dart';
import 'package:apple_avtopoisk1/node_crud.dart';
import 'package:apple_avtopoisk1/vehicles_crud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dataNodeList.dart';
import 'dataOEM.dart';
import 'dto/node.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataExpandedTop()),
        ChangeNotifierProvider(create: (context) => DataNode()),
        ChangeNotifierProvider(create: (context) => DataOEM()),
        ChangeNotifierProvider(create: (context) => DataDetailsInNode()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController oemController =
      TextEditingController(text: '1000531U01');
  @override
  void initState() {
    super.initState();
    // oemController = new TextEditingController(text: '1000531U01');
  }

  @override
  Widget build(BuildContext context) {
    ExpandedTop top2 = context.watch<DataExpandedTop>().getVehiclesExpanded;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('применимость - ниссан'), centerTitle: true),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: 40,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Flexible(
                      flex: 3,
                      child: TextField(
                        controller: oemController,
                        decoration: const InputDecoration(
                          hintText: 'Enter OEM number',
                        ),
                      ),
                    ),
                    new Flexible(
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.blue,
                          borderRadius: new BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        child: IconButton(
                          splashColor: Colors.lightBlue,
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            LoadVehicle(oemController.text, 1, 50);
                          },
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 15,
              child: Container(
                width: double.infinity,
                child: getListBuilder2(context, top2, oemController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Node>> LoadNodeList(
      BuildContext context, String vehicle_id, String oem) async {
    NodeCrud nodeCrud = NodeCrud();
    List<Node> listNode = await nodeCrud.GetNodesList(vehicle_id, oem);
    setState(() {
      Provider.of<DataNode>(context, listen: false).setListNode(listNode);
      Provider.of<DataOEM>(context, listen: false).setOemValue(oem);
      Provider.of<DataOEM>(context, listen: false).setVehicleId(vehicle_id);
    });

    return listNode;
  }

  Widget getChildrenTile(BuildContext context, List<Header> headerInput,
      List<Vehicles> vehiclesInput, String oem) {
    Column column = Column(
      children: [],
    );
    Row headersRow = Row(
      children: [
        SizedBox(width: 20),
      ],
    );

    for (int i = 0; i < headerInput.length; i++) {
      headersRow.children.add(Container(
        child: Text(
          headerInput[i].title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        height: 20,
        width: 150,
      ));
    }

    column.children.add(headersRow);

    for (int i = 0; i < vehiclesInput.length; i++) {
      Row vehicleRow = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 20),
        ],
      );

      vehicleRow.children.add(
        InkWell(
          onTap: () async {
            List<Node> listNode =
                await LoadNodeList(context, vehiclesInput[i].vehicle_id, oem);

            if (listNode != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NodesListForm()),
              );
            }
          },
          child: Container(
            child: Text(
              vehiclesInput[i].model_name + ' ' + vehiclesInput[i].model_num,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            height: 20,
            width: 150,
          ),
        ),
      );

      for (int j = 0; j < headerInput.length; j++) {
        int y = 0;

        if (headerInput[j].code == 'v1') {
          vehicleRow.children.add(
            Container(
              child: Text(
                vehiclesInput[i].V1,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              height: 20,
              width: 150,
            ),
          );
        } else if (headerInput[j].code == 'v2') {
          vehicleRow.children.add(
            Container(
              child: Text(
                vehiclesInput[i].V2,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              height: 20,
              width: 150,
            ),
          );
        } else if (headerInput[j].code == 'v3') {
          vehicleRow.children.add(
            Container(
              child: Text(
                vehiclesInput[i].V3,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              height: 20,
              width: 150,
            ),
          );
        } else if (headerInput[j].code == 'v4') {
          vehicleRow.children.add(
            Container(
              child: Text(
                vehiclesInput[i].V4,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              height: 20,
              width: 150,
            ),
          );
        } else if (headerInput[j].code == 'v5') {
          vehicleRow.children.add(
            Container(
              child: Text(
                vehiclesInput[i].V5,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              height: 20,
              width: 150,
            ),
          );
        } else if (headerInput[j].code == 'v6') {
          vehicleRow.children.add(
            Container(
              child: Text(
                vehiclesInput[i].V6,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              height: 20,
              width: 150,
            ),
          );
        } else if (headerInput[j].code == 'v7') {
          vehicleRow.children.add(
            Container(
              child: Text(
                vehiclesInput[i].V7,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              height: 20,
              width: 150,
            ),
          );
        } else if (headerInput[j].code == 'v8') {
          vehicleRow.children.add(
            Container(
              child: Text(
                vehiclesInput[i].V8,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              height: 20,
              width: 150,
            ),
          );
        } else if (headerInput[j].code == 'catalog') {
          vehicleRow.children.add(
            Container(
              child: Text(
                vehiclesInput[i].catalog,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              height: 20,
              width: 150,
            ),
          );
        } else if (headerInput[j].code == 'from_date') {
          vehicleRow.children.add(
            Container(
              child: Text(
                vehiclesInput[i].from_date,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              height: 20,
              width: 150,
            ),
          );
        } else if (headerInput[j].code == 'upto_date') {
          vehicleRow.children.add(
            Container(
              child: Text(
                vehiclesInput[i].upto_date,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              height: 20,
              width: 150,
            ),
          );
        }
      }
      column.children.add(vehicleRow);
    }

    SingleChildScrollView scroll =
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: column);
    return scroll;
  }

  Widget getListBuilder2(BuildContext context, ExpandedTop top, String oem) {
    if (top == null) {
      return null;
    } else {
      ListView listWiev = ListView.separated(
        itemCount: top.expanded.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 1,
          color: Colors.white,
          thickness: 1,
        ),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey.withOpacity(0.3),
            child: ExpansionTile(
              title: Text(
                top.expanded[index].header,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              children: [
                getChildrenTile(
                    context, top.headers, top.expanded[index].vehicles, oem)
              ],
            ),
          );
        },
      );

      return listWiev;
    }
  }

  Future<void> LoadVehicle(String oem, int page, int page_size) async {
    VehiclesCrud crud = VehiclesCrud();
    ExpandedTop top = await crud.getExpanded(oem, page, page_size);

    Widget w = top.getTileChildren();
    setState(() {
      context.read<DataExpandedTop>().setExpandedTop(top);
    });
  }
}
