import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(QRScannerApp());
}

class QRScannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TMTLUS - QR Scanner',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QRScannerScreen(),
    );
  }
}

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();

  void _onDetect(BarcodeCapture barcode) {
    final String? qrData = barcode.barcodes.first.rawValue;
    if (qrData != null) {
      _openLink(qrData);
    }
  }

  Future<void> _openLink(String url) async {
  Uri uri = Uri.parse(url);

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Could not open link: $url")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TMTLUS - QR Scanner')),
      body: MobileScanner(
        controller: cameraController,
        onDetect: _onDetect,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => cameraController.toggleTorch(),
        child: Icon(Icons.flash_on),
      ),
    );
  }
}
