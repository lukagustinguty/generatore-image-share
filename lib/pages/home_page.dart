import 'dart:io';
import 'package:card_invatation/pages/pagestest.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  final path;
  HomePage(this.path);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _keyBoundary = GlobalKey();

  Uint8List? _memoryimage;
  Future generateImage() async {
    final currentContext = _keyBoundary.currentContext;
    final boundary =
        currentContext!.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary!.toImage(
      pixelRatio: 3.0,
    );
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

    setState(() {
      _memoryimage = bytes!.buffer.asUint8List();
    });

    Directory imagepng = await getApplicationDocumentsDirectory();
    String imagePath = '${imagepng.path}/bank_nation.png';
    final file = File(imagePath);
    var path = await file.writeAsBytes(_memoryimage!);

    return path.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: _keyBoundary,
              child: Carta(),
            ),
            ElevatedButton(
                onPressed: () async {
                  var path = await generateImage();
                  Share.shareFiles([path]);
                },
                child: Container(
                  child: Text("CREATE CUADRADO"),
                ))
          ],
        ),
      ),
    );
  }
}
