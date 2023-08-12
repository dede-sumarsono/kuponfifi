

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kuponfifi/model/data_print.dart';
import 'package:kuponfifi/model/kupon.dart';
import 'package:kuponfifi/pdf/pdf_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:kuponfifi/scan/scan_page.dart';
import 'package:kuponfifi/services/dio.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  var data_qr;

  getDataKupon() async {

    Dio.Response response = await dio().get('/getqr');
    print(response.data.toString());
    data_qr = response.data;


    var list = response.data['data'] as List;

    print('hasil dari list : ${list[0]}');


  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PdfPage()));
              },
              child: Text('To PDF'),
            ),
            ElevatedButton(
              onPressed: (){




                getDataKupon();
                String toast = 'Data Sudah berhasil ditambahkan';
                Fluttertoast.showToast(
                    msg: toast,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );



              },
              child: Text('Tampilkan Pesan'),
            ),


            ElevatedButton(
              onPressed: (){





                String toast = 'Data Sudah berhasil ditambahkan';
                Fluttertoast.showToast(
                    msg: toast,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );

                //print(list.length);





              },
              child: Text('Chek Model'),
            ),


            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanPage()));
              },
              child: Text('Scan Barcode'),
            ),


          ],
        )
      ),
    );
  }
}

