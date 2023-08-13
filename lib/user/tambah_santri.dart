

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:fluttertoast/fluttertoast.dart';

import '../services/dio.dart';

class TambahSantri extends StatefulWidget {
  const TambahSantri({Key? key}) : super(key: key);

  @override
  State<TambahSantri> createState() => _TambahSantriState();
}

class _TambahSantriState extends State<TambahSantri> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _asramaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        title: Text("Tambah Santri Baru"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),

            Center(
              child: Text('Tambahkan Data Santri Baru',
              style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
              ),
            ),


            SizedBox(height: 20,),

            Form(
                key: _formKey,
                child:
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _textInput(hint: "Nama Santri",icon: Icons.person,controller: _nameController,validVar: 'Tolong isi nama yang sesuai'),
                _textInput(hint: "Asrama Santri",icon: Icons.home,controller: _asramaController,validVar: 'Tolong isi tempat asrama yang sesuai'),

                SizedBox(height: 30,),


                ElevatedButton(
                    onPressed: (){


                      Map creds = {

                        "name" : _nameController.text,
                        "asrama" : _asramaController.text,
                        "password":"rahasia"

                      };

                      if(_formKey.currentState!.validate()){
                        /*Provider.of<Auth>(context,listen: false)
                            .register(creds: creds);*/
                        print(creds);
                        register(creds: creds);

//                        Navigator.pop(context);
                      }

                    },
                    child: Text("Daftarkan Santri"
                    ,style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ))
              ],
            )





            )


          ],
        ),
      )

    );
  }


  Widget _textInput({controller, hint, icon,validVar}){
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          //hintText: "Email",
          hintText: hint,
          //prefixIcon: Icon(Icons.email),
          prefixIcon: Icon(icon),

        ),
        //controller: _emailController,
        controller: controller,
        //validator: (value) => value!.isEmpty ? 'Tolong isi email yang sesuai' : null,
        validator: (value) => value!.isEmpty ? validVar : null,
      ),
    );
  }



  void register ({required Map creds}) async {

    try{
      Dio.Response response = await dio().post('/register',data: creds);
      print(response.data['message'].toString());

      String toast = response.data['message'.toString()];
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


    } catch(e){
      print(e);

      String toast = "Register Gagal";
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
