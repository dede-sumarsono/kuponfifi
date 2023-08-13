

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kuponfifi/scan/scanner.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:fluttertoast/fluttertoast.dart';
import '../services/dio.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String _result="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qr Code'),
      ),

      body: _result != "" ?

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Scan Code : $_result",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.black87
                ),
                ),

                SizedBox(height: 20,),

                ElevatedButton(
                    onPressed: (){
                      print('Kupon telah dihanguskan');
                      deleteKupon(qr: _result);




                    },
                    child:
                    Text("Hanguskan Kupon ?")
                )
              ],
            ),
          )


          :


      Center(
        child: Text(
           'Silahkan Scan Barcode Dulu',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),

        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.center_focus_strong),
        onPressed: () => _openScanner(context)  ,
      ),
    );
  }



  Future _openScanner( BuildContext context) async{
    final result = await Navigator.push(context, MaterialPageRoute(builder: (c)=>Scanner() ));

    setState(() {
      _result = result;
    });
  }


  //////////////delete kupon
  void deleteKupon ({required String qr}) async {
    try{
      Dio.Response response = await dio().post('/qrdelete/$qr');
      print(response.data.toString());

      String toast = response.data['data'].toString();
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


    } catch(e){

      String toast = 'Kupon gagal dihapuskan';
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );


      if(e.toString() == 'DioException [bad response]: The request returned an invalid status code of 500.'){
        toast = 'Kupon tidak ada';
        Fluttertoast.showToast(
            msg: toast,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

      print(e);
    }

  }
  /////////// delete kupon selesai



}
