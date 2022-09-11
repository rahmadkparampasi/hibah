import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PrePdf extends StatefulWidget {
  final String pdf;
  final String name;
  const PrePdf({Key? key, required this.pdf, required this.name})
      : super(key: key);

  @override
  State<PrePdf> createState() => _PrePdfState();
}

class _PrePdfState extends State<PrePdf> {
  String? pdf;
  String? name;

  String urlPDFPath = "";
  bool exists = true;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController? _pdfViewController;
  bool loaded = false;

  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = widget.name;
    Uri newApiUrl = Uri.parse(url);

    if (name != null) {
      fileName = name;
    }
    try {
      var data = await http.get(newApiUrl);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/" + fileName + ".pdf");
      print(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  @override
  void initState() {
    setState(() {
      pdf = 'http://simhega.sultengprov.go.id/uploads/${widget.pdf}';
      name = widget.name;
    });
    getFileFromUrl(pdf!).then(
      (value) => {
        setState(() {
          if (value != null) {
            urlPDFPath = value.path;
            loaded = true;
            exists = true;
          } else {
            exists = false;
          }
        })
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name!,
          style: const TextStyle(color: Colors.grey),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                var dir = await getApplicationDocumentsDirectory();
                await FlutterDownloader.enqueue(
                    url: pdf!, savedDir: "${dir.path}/${name!}.pdf");
              },
              child: const Icon(
                Icons.download,
                size: 26.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.grey),
        titleSpacing: 0.0,
      ),
      body: loaded
          ? PDFView(
              filePath: urlPDFPath,
              autoSpacing: true,
              enableSwipe: true,
              pageSnap: true,
              swipeHorizontal: true,
              nightMode: false,
              onError: (e) {
                //Show some error message or UI
              },
              onRender: (_pages) {
                setState(() {
                  _totalPages = _pages!;
                  pdfReady = true;
                });
              },
              onViewCreated: (PDFViewController vc) {
                setState(() {
                  _pdfViewController = vc;
                });
              },
              onPageChanged: (int? page, int? total) {
                setState(() {
                  _currentPage = page!;
                });
              },
              onPageError: (page, e) {},
            )
          : exists
              ? const Text(
                  "Loading..",
                  style: TextStyle(fontSize: 20),
                )
              : const Text(
                  "PDF Not Available",
                  style: TextStyle(fontSize: 20),
                ),
    );
  }
}
