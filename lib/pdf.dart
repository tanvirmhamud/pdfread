import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  TextEditingController paitent = TextEditingController();

  Future permissioncheck() async {
    await Permission.storage.request();
  }

  Future pdfeit() async {
    var per = await Permission.storage.status;
    if (per.isGranted) {
      final dr = await getExternalStorageDirectories();

      // print(dr![0].path);
      // var file = await File("/storage/emulated/0/input.pdf").exists();
      // print(file);

      final PdfDocument document = PdfDocument(
          inputBytes: File('/storage/emulated/0/input.pdf').readAsBytesSync());

      PdfForm form = document.form;
      PdfTextBoxField name = document.form.fields[0] as PdfTextBoxField;
      PdfTextBoxField datacomplete = document.form.fields[1] as PdfTextBoxField;
      PdfTextBoxField title = document.form.fields[2] as PdfTextBoxField;
      name.text = paitent.text;
      name.font = PdfStandardFont(PdfFontFamily.timesRoman, 12);
      datacomplete.text = "22/29/04";
      title.text = "Dentist";
      PdfRadioButtonListField gender =
          form.fields[30] as PdfRadioButtonListField;
      gender.selectedIndex = 0;
      File('/storage/emulated/0/output.pdf')
          .writeAsBytesSync(document.saveSync());
      document.dispose();
    } else {
      await Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("sdvsdvsdv")),
      body: Column(
        children: [
          TextFormField(
            controller: paitent,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                hintText: "paitent"),
          ),
          MaterialButton(
            onPressed: () {
              pdfeit();
              // permissioncheck();
            },
            child: Text("edit"),
          )
        ],
      ),
    );
  }
}
