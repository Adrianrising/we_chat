import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerPageBloc extends ChangeNotifier {
  QRViewController? _qrViewController;
  final _qrKey = GlobalKey(debugLabel: 'QR');

  ////////////////////////////////////////////
  /////////////////Attributes/////////////////
  ////////////////////////////////////////////
  bool _isDispose = false;
  String? qrResult;

  ////////////////////////////////////////////
  /////////////////Getters////////////////////
  ////////////////////////////////////////////
  QRViewController? get getQRViewController => _qrViewController;
  GlobalKey get getQrKey => _qrKey;

  ////////////////////////////////////////////
  /////////////////Setters////////////////////
  ////////////////////////////////////////////
  set setQrController(QRViewController qrViewController) {
    _qrViewController = qrViewController;
  }

  ////////////////////////////////////////////
  /////////////////Methods////////////////////
  ////////////////////////////////////////////

  ////////////////////////////////////////////
  /////////////////Constructor////////////////
  ////////////////////////////////////////////

  @override
  void notifyListeners() {
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
}
