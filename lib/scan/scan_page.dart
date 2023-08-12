

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kuponfifi/scan/scanner.dart';

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
           'Silahkan Scan Barcode',
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
}
