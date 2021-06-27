import 'package:flutter/material.dart';
import 'dto/node.dart';

class DataNode with ChangeNotifier {
  List<Node> list = List<Node>();

  List<Node> get getListNode => list;

  void setListNode(List<Node> listInput) {
    list = listInput;
  }
}
