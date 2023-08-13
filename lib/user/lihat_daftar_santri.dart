import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:fluttertoast/fluttertoast.dart';

import '../services/dio.dart';

class LihatDaftarSantri extends StatefulWidget {
  const LihatDaftarSantri({Key? key}) : super(key: key);

  @override
  State<LihatDaftarSantri> createState() => _LihatDaftarSantriState();
}

class _LihatDaftarSantriState extends State<LihatDaftarSantri> {

  TextEditingController _searchController = TextEditingController();
  late var jsonList;
  List<dynamic> _foundData = [];


  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {

    Dio.Response response = await dio().get('/getallsantri');
    print(response.data.toString());

    if(response.statusCode == 200){
      setState(() {
        jsonList = response.data['data'] as List;
        _foundData = jsonList;
      });
    }else{
      print(response.statusCode);
    }


  }


  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      results = jsonList;
    } else {
      results = _foundData
          .where((name) =>
          name['name'].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {


      _foundData = results;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.4),
      appBar: AppBar(
        title: Text('Daftar Santri'),
      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        /*decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.white],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),*/
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(255, 255, 255, 100),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Cari Nama',
                    border: InputBorder.none

                ),
              ),
            ),
            SizedBox(height: 10,),

            Expanded(
              child: ListView.builder(
                  itemCount: _foundData == null ? 0 : _foundData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        gradient: LinearGradient(
                          //colors: [Colors.deepOrange, Colors.deepOrange.withOpacity(0.9)],
                          colors: [Color(0xffF37335),Colors.deepOrange],
                          end: Alignment.centerRight,
                          begin: Alignment.centerLeft,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5,),
                            Text(_foundData[index]['name'], style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Asrama ${_foundData[index]['asrama']}',style: TextStyle(color: Colors.white,fontSize: 15)),

                                InkWell(
                                  onTap: (){
                                    print('terhapus');

                                    _showDialog(context, _foundData[index]['id']);




                                  },
                                  child: Icon(
                                      Icons.delete,
                                    color: Colors.white,),
                                )
                              ],
                            ),
                            SizedBox(height: 5,)



                          ],
                        ),
                      ),




                    );
                  }),
            ),




          ],
        ),


      ),

    );
  }

  void _showDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Hapus Santri"),
          content: new Text("Apakah anda yakin akan Menghapus Data Santri ini ??"),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                /*Provider.of<Auth>(context, listen: false)
                    .logout();*/
                hapus(id: id);
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




  void hapus ({required int id}) async {
    print(id.toString());

    try{
      Dio.Response response = await dio().post('/deleteuser/$id');
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
      Navigator.pop(context);

      setState(() {
        getData();
      });


    } catch(e){
      print(e);

      String toast = "Tidak dapat menghapus data santri";
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
