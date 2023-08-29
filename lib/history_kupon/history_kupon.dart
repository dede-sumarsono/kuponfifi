import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as Dio;

import '../services/dio.dart';




class HistoriKupon extends StatefulWidget {
  const HistoriKupon({Key? key}) : super(key: key);

  @override
  State<HistoriKupon> createState() => _HistoriKuponState();
}

class _HistoriKuponState extends State<HistoriKupon> {



  late List jsonList;
  bool isDataLoaded = false;
  List<dynamic> jsonListConvert = [];


  TextEditingController _tanggal = TextEditingController();
  TextEditingController _tanggal2 = TextEditingController();
  Map<String, String> data = {"start_date":"","end_date":""};


  void getData() async {
    try {

      ////////////////////////////////sing 2
      /*String? token = await storage.read(key: 'token');
      Provider.of<Auth>(context, listen: false).tryToken(token: token!);
      print(token);
      token2 = token;*/


      //Dio.Response response = await dio().get('/filter',
      Dio.Response response = await dio().get('/cuponuses',
        data: data,
      );

      print(response);

      if(response.statusCode == 200){
        setState(() {
          jsonList = response.data['data'] as List;
          isDataLoaded = true;
          jsonListConvert = jsonList;
        });
      }else{
        print(response.statusCode);
      }




      //print(response);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text("Riwayat Kupon"),
      ),
      body: Column(
        children: [
          //SizedBox(height: 40,),

          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 8,right: 8,left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                      style: TextStyle(color: Colors.deepOrange),
                      readOnly: true,
                      decoration: new InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepOrange),
                          ),
                          prefixIcon: Icon(Icons.calendar_today,color: Colors.deepOrange,),
                          labelText: "Awal",
                          labelStyle: TextStyle(
                            color: Colors.deepOrange, //<-- SEE HERE
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                            ),
                          )
                      ),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100)
                        );
                        if (pickeddate != null){
                          setState(() {
                            _tanggal.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                            data["start_date"] = _tanggal.text;
                            print(data.toString());

                          });
                        }
                      },
                      controller: _tanggal,
                      validator: (value) => value!.isEmpty ? 'Masukan Tanggal' : null
                  ),
                ),
                SizedBox(width: 30,),

                Expanded(
                  child: TextFormField(
                      readOnly: true,
                      style: TextStyle(color: Colors.deepOrange),
                      decoration: new InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepOrange),
                          ),
                          prefixIcon: Icon(Icons.calendar_today,color: Colors.deepOrange,),
                          labelText: "Akhir",
                          labelStyle: TextStyle(
                            color: Colors.deepOrange, //<-- SEE HERE
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                            ),
                          )
                      ),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100)
                        );
                        if (pickeddate != null){
                          setState(() {
                            _tanggal2.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                            data["end_date"] = _tanggal2.text;
                            print(data.toString());
                          });
                        }
                      },
                      controller: _tanggal2,
                      validator: (value) => value!.isEmpty ? 'Masukan Tanggal' : null
                  ),
                ),

              ],
            ),
          ),

        SizedBox(height: 10,),
          
          Row(
            children: [
              Spacer(),
              InkWell(
                onTap: (){
                  setState(() {
                    getData();
                  });
                },
                  child: Icon(Icons.search,color: Colors.deepOrange,)),
            ],
          ),
          
//          SizedBox(height: 20,),

          isDataLoaded ?
          Row(
            children: [
              SizedBox(width: 10,),
              Text('Total  :  ${jsonList.length}',
                style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.w600,fontSize: 18),
              ),
              Spacer()
            ],
          ) :
          Row(
            children: [
              SizedBox(width: 10,),
              Text('Total  :  - ',
                style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.w600,fontSize: 18),
              ),
              Spacer()
            ],
          ),

          SizedBox(height: 20,),
          /*Spacer(),



          Center(
            child: Text(
              'Tidak ada yang ditampilkan'
            ),
          ),

          Spacer()*/


          isDataLoaded ?
          Expanded(
            child: ListView.builder(
                itemCount: jsonListConvert == null ? 0 : jsonListConvert.length,
                itemBuilder: (BuildContext context,int index ){
                  return Card(
                    color: Colors.deepOrange,
                    child: ListTile(
                      onTap:() {
                        print(jsonListConvert[index]);
                        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainListDetail(idx: jsonList[index],)));
                        },
                      title: Text(jsonListConvert[index]['name']
                        ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(jsonListConvert[index]['created_at'],
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)
                      ),
                      trailing: Container(
                        width: 50,
                        child: Row(
                          children: [
                            Spacer(),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(jsonListConvert[index]['asrama'],
                                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)
                                  ),

                                Text(jsonListConvert[index]['sesi'],
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)
                                ),

                              ],
                            ),


                            /*Expanded(child: IconButton(
                                onPressed: (){
                                  String pilihan = jsonListConvert[index]['atas_nama'];
                                  showDialog(
                                      context: context,
                                      builder: (context)=>AlertDialog(
                                        title: Text("Yakin kah kamu?"),
                                        content: Text("Apakah kamu yakin ingin menghapus data berkas atas nama $pilihan ?"),
                                        actions: [
                                          TextButton(onPressed: () async {

                                            var pilihanid = jsonListConvert[index]['id'];
                                            print(pilihanid.toString());


                                            *//*Dio.Response response = await dio().post('/hapus/$pilihanid',
                                              options: Dio.Options(headers: {'Authorization': 'Bearer $token2'}),
                                            );*//*

                                            setState(() {
                                              getData();
                                            });
                                            //print(response);


                                            Navigator.of(context, rootNavigator: true).pop('dialog');

                                          }, child: Text("Ya")),
                                          TextButton(onPressed: () => Navigator.of(context, rootNavigator: true).pop('dialog')
                                              , child: Text("Tidak")),
                                        ],
                                      )


                                  );
                                },
                                icon: Icon(Icons.delete,color: Colors.white,))),*/

                          ],
                        ),
                      ),
                    ),);
                }),
          ) :Center(child: CircularProgressIndicator()),












        ],
      ),
    );
  }
}
