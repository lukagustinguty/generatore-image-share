import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _keyBoundary = GlobalKey();
  Uint8List? _memoryimage;
  void generateImage() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  child: _memoryimage != null
                      ? Image.memory(_memoryimage!)
                      : Container(),
                ),
              ],
            ),
            RepaintBoundary(
              key: _keyBoundary,
              child: Carta(),
            ),
            ElevatedButton(
                onPressed: () {
                  generateImage();
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

class Carta extends StatelessWidget {
  const Carta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.green,
      child: Center(child: Text("Hello Chio")),
    );
  }
}
