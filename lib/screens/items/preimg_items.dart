import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:photo_view/photo_view.dart';

class PreImg extends StatefulWidget {
  final String img;
  final String name;
  const PreImg({Key? key, required this.img, required this.name})
      : super(key: key);

  @override
  State<PreImg> createState() => _PreImgState();
}

class _PreImgState extends State<PreImg> {
  String? img;
  String? name;

  @override
  void initState() {
    super.initState();
    img = widget.img;
    name = widget.name;
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
                String url = "http://simhega.sultengprov.go.id/uploads/$img";

                await GallerySaver.saveImage(url, toDcim: true);
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
      body: Container(
        child: PhotoView(
          imageProvider:
              NetworkImage('http://simhega.sultengprov.go.id/uploads/$img'),
        ),
      ),
    );
  }

  void _saveNetworkImage(String path) async {
    GallerySaver.saveImage(path).then((bool? success) {
      setState(() {
        print('Image is saved');
      });
    });
  }
}
