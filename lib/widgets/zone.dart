import 'package:flutter/material.dart';


class Zone{
  final String name;
  final List<Widget> tables;
  Zone({
    this.name,
    List<Widget> tables,
  }) : tables = tables ?? [];

}