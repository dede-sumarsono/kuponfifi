

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kuponfifi/model/data_print.dart';
import 'package:kuponfifi/model/kupon.dart';
import 'package:kuponfifi/pdf/pdf_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:kuponfifi/scan/scan_page.dart';
import 'package:kuponfifi/services/dio.dart';
import 'package:kuponfifi/user/lihat_daftar_santri.dart';
import 'package:kuponfifi/user/tambah_santri.dart';

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
      appBar: AppBar(
        title: Text("Kupon Santri"),
        centerTitle: true,
      ),
      body: Column(
        children: [

          SizedBox(height: 40,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //SizedBox(width: 5,),
              Spacer(),

              InkWell(
                onTap: (){
                  print('kupon berhasil dibuat');
                  _showDialog(context);

                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    //  color: Color.fromRGBO(255, 255, 255, 100),
                    color: Colors.deepOrange,

                  ),
                  width: MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.2,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.credit_card,
                        size: MediaQuery.of(context).size.width*0.2,
                        color: Colors.white,),
                      SizedBox(height: 5,),
                      Text(
                        'Buat Kupon',
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                        ),

                      )
                    ],
                  ),
                ),
              ),

              Spacer(),


              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PdfPage()));

                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    //  color: Color.fromRGBO(255, 255, 255, 100),
                    color: Colors.deepOrange,

                  ),
                  width: MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.2,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.picture_as_pdf,
                        size: MediaQuery.of(context).size.width*0.2,
                        color: Colors.white,),
                      SizedBox(height: 5,),
                      Text(
                        'Cetak Kupon',
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                        ),

                      )
                    ],
                  ),
                ),
              ),

              Spacer(),





            ],
          ),

          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //SizedBox(width: 5,),
              Spacer(),

              InkWell(
                onTap: (){
                  print('Daftar Santri diklik');
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LihatDaftarSantri()));

                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    //color: Colors.orange,
                    color: Colors.deepOrange
                  ),
                  width: MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.2,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                          Icons.people,
                          size: MediaQuery.of(context).size.width*0.2,
                      color: Colors.white,),
                      SizedBox(height: 5,),
                      Text(
                          'Lihat Daftar Santri',
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          fontSize: 15
                        ),

                      )
                    ],
                  ),
                ),
              ),

              Spacer(),


              InkWell(
                onTap: (){
                  print('Tambahkan Santri Baru');
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> TambahSantri() ));

                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    //  color: Color.fromRGBO(255, 255, 255, 100),
                    color: Colors.deepOrange
                  ),
                  width: MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.2,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_add,
                        size: MediaQuery.of(context).size.width*0.2,
                        color: Colors.white,),
                      SizedBox(height: 5,),
                      Text(
                        'Tambahkan Santri \nBaru',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                        ),

                      )
                    ],
                  ),
                ),
              ),


              Spacer()



            ],
          ),

          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //SizedBox(width: 5,),

              /////////////////////////////

              Spacer(),


              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanPage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    //  color: Color.fromRGBO(255, 255, 255, 100),
                    color: Colors.deepOrange
                  ),
                  width: MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.2,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Icon(
                        Icons.center_focus_strong,
                        size: MediaQuery.of(context).size.width*0.2,
                        color: Colors.white,),
                      SizedBox(height: 5,),
                      Text(
                        'Scan Kupon',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                        ),

                      )
                    ],
                  ),
                ),
              ),


              Spacer()



            ],
          ),

          SizedBox(height: 20,),




        ],
      ),
    );
  }




  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Buat Kupon"),
          content: new Text("Apakah anda yakin akan akan membuat kupon?? \n\nBila anda klik iya maka data kupon yang belum terscan akan dihapus dan diganti dengan yang baru lagi! "),
          actions: <Widget>[
            new TextButton(
              child: new Text("Iya"),
              onPressed: () {
                /*Provider.of<Auth>(context, listen: false)
                    .logout();*/
                _buatkupon();
                Navigator.of(context).pop();


              },
            ),
            new TextButton(
              child: new Text("Tidak"),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),

          ],
        );
      },
    );
  }




  _buatkupon() async {

    try{
      Dio.Response response = await dio().get('/getalluser');
      print(response.data['data'].toString());

      String toast = response.data['data'];
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

      String toast2 = 'Anda bisa klik cetak kupon';
      Fluttertoast.showToast(
          msg: toast2,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


    } catch(e){
      print(e);

      String toast = "Kupon Gagal Dibuat";
      Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );


    }


  }


}

