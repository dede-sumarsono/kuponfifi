import 'package:flutter/material.dart';

class DataPrint {
  String name;
  String asrama;
  String qrscan;

  DataPrint(this.name, this.asrama, this.qrscan);

  DataPrint.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        asrama = json['asrama'],
        qrscan = json['qr_code'];
}