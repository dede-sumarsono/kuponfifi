

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../util/util.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({Key? key}) : super(key: key);

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {

  PrintingInfo? printingInfo;

  @override
  void initState() {
    // TODO: implement initState
    //final info = await PrintingInfo();
    _init();

    super.initState();
  }

  Future<void>_init()async{
    final info = await Printing.info();
    setState(() {
      printingInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug=true;

    final actions=<PdfPreviewAction>[
      if(!kIsWeb)
        const PdfPreviewAction(icon: Icon(Icons.save), onPressed: saveAsFile)
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Kupon Fifi'),
      ),

      body: PdfPreview(
        maxPageWidth: 700,
        actions: actions,
        onPrinted: showPrintedToast,
        onShared: showSharedToast,
        build: generatePdf,


      ),

    );
  }
}
