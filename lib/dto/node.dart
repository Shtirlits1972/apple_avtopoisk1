import 'package:flutter/material.dart';

class Node {
  String node_id;
  String name;
  String image_id;

  @override
  String toString() {
    return 'node_id : $node_id name: $name image_id: $image_id';
  }

  Node({@required this.node_id, @required this.name, @required this.image_id});

  factory Node.fromJson(Map<String, dynamic> json) {
    return Node(
      node_id: json['node_id'],
      name: json['name'],
      image_id: json['image_id'],
    );
  }
}
