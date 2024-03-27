import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class ContratInfo extends StatelessWidget {
  final DateTime? dateDebut;
  final DateTime? dateFin;
  final String cin;
  final String permisNumero;
  final String imageCinPath;
  final String imagePermisPath;
  final String name; // Nouveau paramètre
  final String surname; // Nouveau paramètre

  ContratInfo({
    required this.dateDebut,
    required this.dateFin,
    required this.cin,
    required this.permisNumero,
    required this.imageCinPath,
    required this.imagePermisPath,
    required this.name, // Initialiser le nouveau paramètre
    required this.surname, // Initialiser le nouveau paramètre
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contrat Info'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: MaterialButton(
            onPressed: () {
              createPDF();
            },
            height: 50,
            minWidth: double.infinity,
            color: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: const Text(
              "Download ",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ));
  }

  Future<void> createPDF() async {
    final ByteData bytes = await rootBundle.load('images_Cars/logo_app.jpg');
    final Uint8List byteList = bytes.buffer.asUint8List();
    // Create a new PDF document
    final pdf = pw.Document();

    // Add a page to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Image(
                  pw.MemoryImage(
                    byteList,
                  ),
                  height: 100,
                  width: 100),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.Text(
                  'Name : ',
                  style: pw.TextStyle(
                      fontSize: 18.0, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(
                  width: 65,
                ),
                pw.Text(
                  '$name',
                  style: const pw.TextStyle(fontSize: 18.0),
                )
              ]),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.Text(
                  'Prenom : ',
                  style: pw.TextStyle(
                      fontSize: 18.0, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(
                  width: 49,
                ),
                pw.Text(
                  '$surname',
                  style: pw.TextStyle(fontSize: 18.0),
                ),
              ]),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.Text(
                  'Date de début :',
                  style: pw.TextStyle(
                      fontSize: 18.0, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(
                  width: 10,
                ),
                pw.Text(
                  '${dateDebut?.toIso8601String().split('T').first ?? ' '}',
                  style: pw.TextStyle(fontSize: 18.0),
                ),
              ]),
              pw.SizedBox(
                height: 10.0,
              ),
              pw.Row(
                children: [
                  pw.Text(
                    'Date de fin :',
                    style: pw.TextStyle(
                        fontSize: 18.0, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(
                    width: 35,
                  ),
                  pw.Text(
                    '${dateFin?.toIso8601String().split('T').first ?? ' '}',
                    style: pw.TextStyle(fontSize: 18.0),
                  )
                ],
              ),
              pw.SizedBox(height: 10.0),
              pw.Row(
                children: [
                  pw.Text(
                    'CIN N° : ',
                    style: pw.TextStyle(
                        fontSize: 18.0, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(
                    width: 60,
                  ),
                  pw.Text(
                    ' $cin',
                    style: pw.TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
              pw.SizedBox(height: 10.0),
              pw.Row(
                children: [
                  pw.Text(
                    'Permis N° : ',
                    style: pw.TextStyle(
                        fontSize: 18.0, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(
                    width: 40,
                  ),
                  pw.Text(
                    ' $permisNumero',
                    style: pw.TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Get the device's temporary directory
    final output = await getTemporaryDirectory();

    // Create the PDF file
    final file = File("${output.path}/example.pdf");

    // Write the PDF content to the file
    await file.writeAsBytes(await pdf.save());

    // Open the PDF file
    OpenFile.open(file.path);
  }
}
