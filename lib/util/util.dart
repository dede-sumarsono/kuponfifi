
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kuponfifi/util/url_text.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;


import 'package:dio/dio.dart' as Dio;
import 'package:kuponfifi/services/dio.dart';




Future<Uint8List>generatePdf(final PdfPageFormat format) async{
  final doc = pw.Document(
    title: 'Ponpes Kupon'
  );
  final logoImage = pw.MemoryImage(
      (await rootBundle.load('assets/flutter_school.png')).buffer.asUint8List());

  /*final footerImage = pw.MemoryImage(
      (await rootBundle.load('assets/footer.png')).buffer.asUint8List());*/

  final font = await rootBundle.load("assets/OpenSans-Regular.ttf");

  final ttf = pw.Font.ttf(font);

  final pageTheme = await _myPageTheme(format);

  ///////////////////////////////////////
  var data_qr;

  Dio.Response response = await dio().get('/getqr');
  print(response.data.toString());
  data_qr = response.data;

  var list = response.data['data'] as List;

  print('hasil dari list : ${list[0]}');

  /////////////////////

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      /*header: (final context)=>pw.Image(
        alignment: pw.Alignment.topLeft,
        logoImage,
        fit: pw.BoxFit.contain,
        width: 180,
      ),*/
      /*footer: (final context)=>pw.Image(
        footerImage,
        fit: pw.BoxFit.scaleDown,
      ),*/
      build: (final context)=>[
        pw.Container(
          padding: pw.EdgeInsets.only(left: 30,bottom: 20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                //mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Nama : ${list[0]['name']}'),
                      pw.Text('Pondok : ${list[0]['asrama']}'),
                      //pw.Text('Instagram : '),
                    ]
                  ),
                  pw.SizedBox(width: 70),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(' Fifi Aja'),
                      UrlText(' Asrama I ','myflutter@gmail.com'),
                      //UrlText('flutter tutorial', '@fluttertutorial'),
                    ],
                  ),
                  pw.SizedBox(width: 70),
                  pw.BarcodeWidget(
                    //data: "Flutter School",
                    data: "${list[0]['qr_code']}",
                    width: 40,
                    height: 40,
                    barcode: pw.Barcode.qrCode(),
                    drawText: false
                  )
                ],
              ),




              //////////////////second








            ],
          ),
        ),

      ]
    )
  );

  return doc.save();
}

Future<pw.PageTheme>_myPageTheme(PdfPageFormat format)async{
  final logoImage = pw.MemoryImage(
      (await rootBundle.load('assets/flutter_school.png')).buffer.asUint8List());
  return pw.PageTheme(
    margin: const pw.EdgeInsets.symmetric(
      horizontal: 1*PdfPageFormat.cm,
        vertical: 0.5*PdfPageFormat.cm
    ),
    textDirection: pw.TextDirection.ltr,
    orientation: pw.PageOrientation.portrait,
    buildBackground: (final context)=>pw.FullPage(
      ignoreMargins: true,
      child: pw.Watermark(
        angle: 20,
        child: pw.Image(
          alignment: pw.Alignment.center,
          logoImage,
          fit: pw.BoxFit.cover

        )
      )
    )
  );
}

Future<void> saveAsFile(
final BuildContext context,
final LayoutCallback build,
final PdfPageFormat pageFormat,
)async{
  final bytes = await build(pageFormat);
  final appDocDir =  await getApplicationDocumentsDirectory();
  final file = File('$appDocDir/document.pdf');
  print('save file as file ${file.path}...');

  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}

void showPrintedToast(final BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Document Printed successfully')));
}

void showSharedToast(final BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Document shared successfully'))
  );
}